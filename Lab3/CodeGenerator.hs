module CodeGenerator where

import Data.Map (Map)
import qualified Data.Map as Map
import Control.Monad.State
import Data.Maybe

import AbsCPP

type Instruction = String
type Address = Int
type Label = Int

data Environment = Environment {
  className       :: String,
  variableScopes  :: [Map Id Address],
  functions       :: Map Id Type,
  nextLabel       :: Label,
  nextAddress     :: Address,
  code            :: [Instruction]
} deriving (Show)

compile :: String -> Program -> String
compile state program =
  unlines $ reverse $ code (execState (compileProgram state program) (emptyClassEnvironment state))

compileProgram :: String -> Program -> State Environment ()
compileProgram name (PDefs definitions) =
  do
    buildSymbolTable definitions
    mapM_ emit [
      ".class public " ++ name,
      ".super java/lang/Object",
      ".method public <init>()V",
      "aload_0",
      "invokespecial java/lang/Object/<init>()V",
      "return",
      ".end method",
      ".method public static main([Ljava/lang/String;)V",
      ".limit locals 100",
      ".limit stack 1000",
      "invokestatic " ++ name ++ "/main()I",
      "pop",
      "return",
      ".end method"
     ]
    mapM_ compileDefintion definitions

buildSymbolTable :: [Def] -> State Environment ()
buildSymbolTable = mapM_ (\(DFun functionType functionId _ _) -> addFunction functionId functionType)

compileDefintion :: Def -> State Environment ()
compileDefintion (DFun returnType (Id "main") _ statements) =
  do
    emit ".method public static main()I"
    emit ".limit locals 100"
    emit ".limit stack 1000"
    newScope
    mapM_ compileStatement statements
    exitScope
    -- default return
    emit "iconst_0"
    emit "ireturn"
    emit ".end method"
compileDefintion (DFun returnType (Id functionId) arguments statements) =
  do
    emit $ ".method public static " ++ functionId ++ "(" ++ argumentTypes ++ ")" ++ typeIndicator returnType
    emit ".limit locals 100"
    emit ".limit stack 1000"
    newScope
    state <- get
    let tempAddress = nextAddress state
    modify (\state -> state {nextAddress = 0} )
    mapM_ (\(ADecl variableType variableId) -> addVariable variableId variableType) arguments
    mapM_ (\(ADecl variableType variableId) ->
          lookupVariableAddress variableId >>=
          (\variableAddress -> emit $ loadInstruction variableType ++ " " ++ show variableAddress)) arguments
    mapM_ compileStatement statements
    modify (\state' -> state' { nextAddress = tempAddress } )
    -- default return
    case returnType of
      Type_int    -> emit "iconst_0" >> emit "ireturn"
      Type_bool   -> emit "iconst_0" >> emit "ireturn"
      Type_double -> emit "dconst_0" >> emit "dreturn"
      Type_void   -> emit "return"
    emit ".end method"
    exitScope
  where
    argumentTypes = concatMap (\(ADecl argumentType _) -> typeIndicator argumentType) arguments
    loadInstruction Type_int = "iload"
    loadInstruction Type_double = "dload"
    loadInstruction Type_bool   = "iload"

compileStatement :: Stm -> State Environment ()
compileStatement state =
  case state of
    SExp expression ->
      do
        compileExpression expression
        case typeOfExpression expression of
          Type_int -> emit "pop"
          Type_bool -> emit "pop"
          Type_double -> emit "pop2"
          Type_void -> return ()
    SDecls variableType variableIds ->
      do
        mapM_ (`addVariable` variableType) variableIds
        case variableType of
          Type_int ->
            mapM_ (\variableId -> lookupVariableAddress variableId >>=
                  (\variableAddress -> emit "iconst_0" >> emit ("istore " ++ show variableAddress))) variableIds
          Type_double ->
            mapM_ (\variableId -> lookupVariableAddress variableId >>=
                  (\variableAddress -> emit "dconst_0" >> emit ("dstore " ++ show variableAddress))) variableIds
          Type_bool ->
            mapM_ (\variableId -> lookupVariableAddress variableId >>=
                  (\variableAddress -> emit "iconst_0" >> emit ("istore " ++ show variableAddress))) variableIds
    SInit variableType variableId expression ->
      do
        addVariable variableId variableType
        variableAddress <- lookupVariableAddress variableId
        compileExpression expression
        case variableType of
          Type_int    -> emit $ "istore " ++ show variableAddress
          Type_double -> emit $ "dstore " ++ show variableAddress
          Type_bool   -> emit $ "istore " ++ show variableAddress
    SReturn expression ->
      do
        compileExpression expression
        case typeOfExpression expression of
          Type_int    -> emit "ireturn"
          Type_double -> emit "dreturn"
          Type_bool   -> emit "ireturn"
          Type_void   -> emit "return"
    SWhile conditionExpression state' ->
      do
        test <- newLabel
        end  <- newLabel
        let testLabel = 'l' : show test
        let endLabel = 'l' : show end
        emit $ testLabel ++ ":"
        compileExpression conditionExpression
        emit $ "ifeq " ++ endLabel
        compileStatement state'
        emit $ "goto " ++ testLabel
        emit $ endLabel ++ ":"
    SBlock statements ->
      do
        newScope
        mapM_ compileStatement statements
        exitScope
    SIfElse conditionExpression statement1 statement2 ->
      compileIfElse conditionExpression (compileStatement statement1) (compileStatement statement2)

compileExpression :: Exp -> State Environment ()
compileExpression (EType expressionType expression) =
  case expression of
    ETrue -> emit "iconst_1"
    EFalse -> emit "iconst_0"
    EInt integer -> emit $ "ldc " ++ show integer
    EDouble double -> emit $ "ldc2_w " ++ show double
    EId variableId ->
      do
        variableAddress <- lookupVariableAddress variableId
        emit $ case expressionType of
          Type_int    -> "iload " ++ show variableAddress
          Type_bool   -> "iload " ++ show variableAddress
          Type_double -> "dload " ++ show variableAddress
    EApp (Id "printInt") expression' ->
      do
        mapM_ compileExpression expression'
        emit "invokestatic Runtime/printInt(I)V"
    EApp (Id "printDouble") expression' ->
      do
        mapM_ compileExpression expression'
        emit "invokestatic Runtime/printDouble(D)V"
    EApp (Id "readInt")    _ -> emit "invokestatic Runtime/readInt()I"
    EApp (Id "readDouble") _ -> emit "invokestatic Runtime/readDouble()D"
    EApp (Id functionId) expressions ->
      do
        functionType <- lookupFunctionReturnType (Id functionId)
        mapM_ compileExpression expressions
        state <- get
        emit $ "invokestatic " ++ className state ++ "/" ++ functionId ++ "(" ++ argumentTypes ++ ")" ++ typeIndicator functionType
      where
        argumentTypes = concatMap (\ (EType argumentType _) -> typeIndicator argumentType) expressions
    EPostIncr expression' -> compilePostExpression expression' "iadd" "dadd"
    EPostDecr expression' -> compilePostExpression expression' "isub" "dsub"
    EPreIncr expression' -> compilePreExpression expression' "iadd" "dadd"
    EPreDecr expression' -> compilePreExpression expression' "isub" "dsub"
    ETimes expression1 expression2 -> compileBinaryArithmeticExpression expression1 expression2 "mul" expressionType
    EDiv   expression1 expression2 -> compileBinaryArithmeticExpression expression1 expression2 "div" expressionType
    EPlus  expression1 expression2 -> compileBinaryArithmeticExpression expression1 expression2 "add" expressionType
    EMinus expression1 expression2 -> compileBinaryArithmeticExpression expression1 expression2 "sub" expressionType
    ELt    expression1 expression2 -> compileComparisonExpression expression1 expression2 CLT
    EGt    expression1 expression2 -> compileComparisonExpression expression1 expression2 CGT
    ELtEq  expression1 expression2 -> compileComparisonExpression expression1 expression2 CLTEQ
    EGtEq  expression1 expression2 -> compileComparisonExpression expression1 expression2 CGTEQ
    EEq    expression1 expression2 -> compileComparisonExpression expression1 expression2 CEQ
    ENEq   expression1 expression2 -> compileComparisonExpression expression1 expression2 CNEQ
    EAnd   expression1 expression2 ->
      compileIfElse expression1 (compileIfElse expression2 (emit "iconst_1") (emit "iconst_0")) (emit "iconst_0")
    EOr expression1 expression2  ->
      compileIfElse expression1 (emit "iconst_1") (compileIfElse expression2 (emit "iconst_1") (emit "iconst_0"))
    EAss (EType _ (EId variableId)) expression2  ->
      do
        compileExpression expression2
        variableAddress <- lookupVariableAddress variableId
        case expressionType of
          Type_int ->
            do
              emit "dup"
              emit $ "istore " ++ show variableAddress
          Type_double ->
            do
              emit "dup2"
              emit $ "dstore " ++ show variableAddress
          Type_bool ->
            do
              emit "dup"
              emit $ "istore " ++ show variableAddress
compileExpression expression = error $ "Not type annotated with EType: " ++ show expression

data ComparisonOperator = CLT | CLTEQ | CEQ | CNEQ | CGTEQ | CGT
  deriving (Enum, Eq)

compileComparisonExpression :: Exp -> Exp -> ComparisonOperator -> State Environment ()
compileComparisonExpression expression1 expression2 comparisonOperator =
  do
    let expression1Type = typeOfExpression expression1
    true <- newLabel
    let trueLabel = 'l' : show true
    emit "bipush 1"
    compileExpression expression1
    compileExpression expression2
    compileComparison trueLabel expression1Type
    emit "pop"
    emit "bipush 0"
    emit $ trueLabel ++ ":"
  where
    compileComparison trueLabel expressionType =
      case expressionType of
        Type_int    -> emit $ "if_icmp" ++ comparisonInstruction comparisonOperator ++ trueLabel
        Type_double -> emit "dcmpl" >> emit ("if" ++ comparisonInstruction comparisonOperator ++ trueLabel)
    operatorMap = zip [CLT ..] ["lt ", "le ", "eq ", "ne ", "ge ", "gt "]
    comparisonInstruction comparisonOperator = fromJust $ lookup comparisonOperator operatorMap

compileBinaryArithmeticExpression :: Exp -> Exp -> Instruction -> Type -> State Environment ()
compileBinaryArithmeticExpression expression1 expression2 instruction expressionType =
  do
    compileExpression expression1
    compileExpression expression2
    emit $ case expressionType of
      Type_int    -> 'i' : instruction
      Type_double -> 'd' : instruction

compilePostExpression :: Exp -> Instruction -> Instruction -> State Environment ()
compilePostExpression expression@(EType variableType (EId variableId)) integerInstruction doubleInstruction =
  do
    compileExpression expression
    variableAddress <- lookupVariableAddress variableId
    case variableType of
      Type_int ->
        do
          emit "dup"
          emit "iconst_1"
          emit integerInstruction
          emit $ "istore " ++ show variableAddress
      Type_double ->
        do
          emit "dup2"
          emit "dconst_1"
          emit doubleInstruction
          emit $ "dstore " ++ show variableAddress

compilePreExpression :: Exp -> Instruction -> Instruction -> State Environment ()
compilePreExpression expression@(EType variableType (EId variableId)) integerInstruction doubleInstruction =
  do
    compileExpression expression
    variableAddress <- lookupVariableAddress variableId
    case variableType of
      Type_int ->
        do
          emit "iconst_1"
          emit integerInstruction
          emit "dup"
          emit $ "istore " ++ show variableAddress
      Type_double ->
        do
          emit "dconst_1"
          emit doubleInstruction
          emit "dup2"
          emit $ "dstore " ++ show variableAddress

compileIfElse :: Exp -> State Environment () -> State Environment () -> State Environment ()
compileIfElse conditionExpression compileStatement1 compileStatement2 =
  do
    false <- newLabel
    true <- newLabel
    let falseLabel = 'l' : show false
    let trueLabel = 'l' : show true
    compileExpression conditionExpression
    emit $ "ifeq " ++ falseLabel
    compileStatement1
    emit $ "goto " ++ trueLabel
    emit $ falseLabel ++ ":"
    compileStatement2
    emit $ trueLabel ++ ":"

typeIndicator :: Type -> String
typeIndicator (Type_int)    = "I"
typeIndicator (Type_double) = "D"
typeIndicator (Type_void)   = "V"
typeIndicator (Type_bool)   = "Z"

typeOfExpression :: Exp -> Type
typeOfExpression (EType expressionType _) = expressionType

emit :: Instruction -> State Environment ()
emit instruction = modify (\state -> state {code = instruction : code state})

emptyClassEnvironment :: String -> Environment
emptyClassEnvironment name =
  Environment
    {
      className       = name,
      variableScopes  = [Map.empty],
      functions       = Map.empty,
      nextLabel       = 0,
      nextAddress     = 0,
      code            = []
    }

lookupVariableAddress :: Id -> State Environment Address
lookupVariableAddress variableId =
  do
    state <- get
    return $ findVariableAddress (variableScopes state)
  where
    findVariableAddress [] = error $ "No variable called " ++ show variableId ++ " could be found."
    findVariableAddress (scope:restScopes) = fromMaybe (findVariableAddress restScopes) (Map.lookup variableId scope)

lookupFunctionReturnType :: Id -> State Environment Type
lookupFunctionReturnType functionId =
  do
    state <- get
    case Map.lookup functionId (functions state) of
      Nothing         -> error $ "No function called " ++ show functionId ++ " could be found."
      Just returnType -> return returnType

newScope :: State Environment ()
newScope = modify (\state -> state { variableScopes = Map.empty:variableScopes state })

exitScope :: State Environment ()
exitScope = modify (\state -> state { variableScopes = tail $ variableScopes state })

newLabel :: State Environment Label
newLabel =
  do
    state <- get
    let label = nextLabel state
    modify (\state' -> state' { nextLabel = label + 1 })
    return label

addVariable :: Id -> Type -> State Environment ()
addVariable variableId variableType =
  do
    state <- get
    let (currentScope:restScopes) = variableScopes state
    modify (\state' -> state'
      {
        nextAddress = nextAddress state' + typeAddressSize variableType,
        variableScopes = Map.insert variableId (nextAddress state') currentScope:restScopes
      })

addFunction :: Id -> Type -> State Environment ()
addFunction functionId functionType =
  modify (\state -> state { functions = Map.insert functionId functionType $ functions state } )

typeAddressSize :: Type -> Int
typeAddressSize Type_int    = 1
typeAddressSize Type_bool   = 1
typeAddressSize Type_double = 2
