module TypeChecker where

import AbsCPP
import PrintCPP
import ErrM

import Control.Monad
import Data.Map (Map)
import qualified Data.Map as Map

type Environment = (Functions, [Context])
type Functions   = Map Id ([Type], Type)
type Context     = Map Id Type

typecheck :: Program -> Err Program
typecheck (PDefs definitions) =
  do
    environment  <- buildInitialSymbolTable emptyEnvironment
    environment' <- buildSymbolTable environment definitions
    (_, annotatedDefinitions) <- checkDefinitions environment' definitions
    return (PDefs annotatedDefinitions)

buildInitialSymbolTable :: Environment -> Err Environment
buildInitialSymbolTable environment =
  do
    environment <- updateFunction environment (Id "printInt")    ([Type_int], Type_void)
    environment <- updateFunction environment (Id "printDouble") ([Type_double], Type_void)
    environment <- updateFunction environment (Id "readInt")     ([], Type_int)
    updateFunction                environment (Id "readDouble")  ([], Type_int)

buildSymbolTable :: Environment -> [Def] -> Err Environment
buildSymbolTable environment [] = return environment
buildSymbolTable environment (DFun returnType functionId arguments _:restDefinitions) =
    do
      environment' <- updateFunction environment functionId (map getType arguments, returnType)
      buildSymbolTable environment' restDefinitions
  where
    getType (ADecl declarationType _) = declarationType

checkDefinitions :: Environment -> [Def] -> Err (Environment, [Def])
checkDefinitions environment definitions =
    foldM accumelateDefinitions (environment, []) definitions
  where accumelateDefinitions (environment, annotatedDefinitions) definition = do
        (environment', annotatedDefinition) <- checkDefinition environment definition
        return (environment', annotatedDefinitions ++ [annotatedDefinition])

checkDefinition :: Environment -> Def -> Err (Environment, Def)
checkDefinition environment (DFun returnType functionId arguments statements) =
    do
      environment' <- foldM addArgument (newBlock environment) arguments
      (environment'', annotatedStatements) <- checkStatements environment' returnType statements
      return (environment'', DFun returnType functionId arguments annotatedStatements)
  where
    addArgument environment (ADecl argumentType argumentId) = updateVariable environment argumentId argumentType

checkStatements :: Environment -> Type -> [Stm] -> Err (Environment, [Stm])
checkStatements environment returnType statements =
    foldM accumelateStatements (environment, []) statements
  where accumelateStatements (environment, annotatedStatements) statement = do
        (environment', annotatedStatement) <- checkStatement environment returnType statement
        return (environment', annotatedStatements ++ [annotatedStatement])

checkStatement :: Environment -> Type -> Stm -> Err (Environment, Stm)
checkStatement environment functionReturnType statement =
    case statement of
      SExp expression ->
        do
          annotatedExpression <- inferExpression environment expression
          return (environment, (SExp annotatedExpression))
      SDecls variableType variableIds ->
        do
          environment' <- foldM (addVariable variableType) environment variableIds
          return (environment', statement)
      SInit variableType variableId expression ->
        do
          annotatedExpression <- checkExpression environment expression variableType
          environment' <- updateVariable environment variableId variableType
          return (environment', (SInit variableType variableId annotatedExpression))
      SReturn returnExpression ->
        do
          annotatedExpression <- checkExpression environment returnExpression functionReturnType
          return (environment, SReturn annotatedExpression)
      SWhile conditionExpression statement' ->
        do
          annotatedExpression <- checkExpression environment conditionExpression Type_bool
          (_, annotatedStatement) <- checkStatement environment functionReturnType statement'
          return (environment, SWhile annotatedExpression annotatedStatement)
      SBlock statements ->
        do
          (_, annotatedStatements) <- checkStatements (newBlock environment) functionReturnType statements
          return (environment, (SBlock annotatedStatements))
      SIfElse conditionExpression trueStatement falseStatement ->
        do
          annotatedExpression <- checkExpression environment conditionExpression Type_bool
          (_, annotatedStatement1) <- checkStatement environment functionReturnType trueStatement
          (_, annotatedStatement2) <- checkStatement environment functionReturnType falseStatement
          return (environment, (SIfElse annotatedExpression annotatedStatement1 annotatedStatement2))
  where
    addVariable variableType environment variableId = updateVariable environment variableId variableType

checkExpression :: Environment -> Exp -> Type -> Err Exp
checkExpression environment expression expectedType =
  do
    EType actualType annotatedExpression <- inferExpression environment expression
    if actualType /= expectedType then
      fail $ printTree expression ++ " has type " ++ printTree actualType ++ " expected " ++ printTree expectedType
    else
      return (EType actualType annotatedExpression)

inferExpression :: Environment -> Exp -> Err Exp
inferExpression environment expression =
  case expression of
    ETrue     -> return $ EType Type_bool expression
    EFalse    -> return $ EType Type_bool expression
    EInt _    -> return $ EType Type_int expression
    EDouble _ -> return $ EType Type_double expression
    EId variableId ->
      do
        variableType <- lookupVariable environment variableId
        return $ EType variableType expression
    EApp functionId argumentExpressions ->
      do
        (expectedArgumentTypes, returnType) <- lookupFunction environment functionId
        annotatedArgumentTypes <- mapM (inferExpression environment) argumentExpressions
        let actualArgumentTypes = map (\(EType argumentType _) -> argumentType) annotatedArgumentTypes
        if expectedArgumentTypes == actualArgumentTypes then
          return $ EType returnType $ EApp functionId annotatedArgumentTypes
        else
          fail $ printTree functionId ++ " called with argument types " ++ show actualArgumentTypes
                 ++ ", but the required argument types are " ++ show expectedArgumentTypes
    EPostIncr expression  ->
      do
        annotatedExpression@(EType expressionType _) <- inferUnaryExpression [Type_int, Type_double] environment expression
        return $ EType expressionType $ EPostIncr annotatedExpression
    EPostDecr expression  ->
      do
        annotatedExpression@(EType expressionType _) <- inferUnaryExpression [Type_int, Type_double] environment expression
        return $ EType expressionType $ EPostDecr annotatedExpression
    EPreIncr expression   ->
      do
        annotatedExpression@(EType expressionType _) <- inferUnaryExpression [Type_int, Type_double] environment expression
        return $ EType expressionType $ EPreIncr annotatedExpression
    EPreDecr expression   ->
      do
        annotatedExpression@(EType expressionType _) <- inferUnaryExpression [Type_int, Type_double] environment expression
        return $ EType expressionType $ EPreDecr annotatedExpression
    ETimes expression1 expression2 -> sameExpressionTypes ETimes expression1 expression2
    EDiv expression1 expression2   -> sameExpressionTypes EDiv expression1 expression2
    EPlus expression1 expression2  ->
      do
        (annotatedExpression1, annotatedExpression2) <- inferBinaryExpression [Type_int, Type_double] environment expression1 expression2
        return $ EType (typeOfExpression annotatedExpression1) $ EPlus annotatedExpression1 annotatedExpression2
    EMinus expression1 expression2 ->
      do
        (annotatedExpression1, annotatedExpression2) <- inferBinaryExpression [Type_int, Type_double] environment expression1 expression2
        return $ EType (typeOfExpression annotatedExpression1) $ EMinus annotatedExpression1 annotatedExpression2
    ELt expression1 expression2    -> sameExpressionTypesBool ELt expression1 expression2
    EGt expression1 expression2    -> sameExpressionTypesBool EGt expression1 expression2
    ELtEq expression1 expression2  -> sameExpressionTypesBool ELtEq expression1 expression2
    EGtEq expression1 expression2  -> sameExpressionTypesBool EGtEq expression1 expression2
    EEq expression1 expression2    -> sameExpressionTypesBool EEq expression1 expression2
    ENEq expression1 expression2   -> sameExpressionTypesBool ENEq expression1 expression2
    EAnd expression1 expression2   -> bothExpressionsBool EAnd expression1 expression2
    EOr expression1 expression2    -> bothExpressionsBool EOr expression1 expression2
    EAss (EId variableId) expression1 ->
      do
        (EType expressionType (EAss _ annotatedExpression1)) <- sameExpressionTypes EAss (EId variableId) expression1
        return $ EType expressionType $ EAss (EType expressionType (EId variableId)) annotatedExpression1
  where
    sameExpressionTypes expressionType expression1 expression2 =
      do
        annotatedExpression1@(EType type1 _) <- inferExpression environment expression1
        annotatedExpression2@(EType type2 _) <- inferExpression environment expression2
        if type1 == type2 then
          return $ EType type1 $ expressionType annotatedExpression1 annotatedExpression2
        else
          fail $ printTree expression1 ++ " has type " ++ printTree type1 ++ " but " ++ printTree expression2
                 ++ " has type " ++ printTree type2
    sameExpressionTypesBool expressionType expression1 expression2 =
      do
        annotatedExpression1@(EType type1 _) <- inferExpression environment expression1
        annotatedExpression2@(EType type2 _) <- inferExpression environment expression2
        if type1 == type2 then
          return $ EType Type_bool $ expressionType annotatedExpression1 annotatedExpression2
        else
          fail $ printTree expression1 ++ " has type " ++ printTree type1 ++ " but " ++ printTree expression2
                 ++ " has type " ++ printTree type2
    bothExpressionsBool expressionType expression1 expression2 =
      do
        annotatedExpression1@(EType type1 _) <- inferExpression environment expression1
        annotatedExpression2@(EType type2 _) <- inferExpression environment expression2
        if type1 == Type_bool && type2 == Type_bool then
          return $ EType Type_bool $ expressionType annotatedExpression1 annotatedExpression2
        else
          fail $ printTree expression1 ++ " has type " ++ printTree type1 ++ " and " ++ printTree expression2
                 ++ " has type " ++ printTree type2 ++ ", but both should be bool."
    typeOfExpression (EType expressionType _) = expressionType

inferBinaryExpression :: [Type] -> Environment -> Exp -> Exp -> Err (Exp, Exp)
inferBinaryExpression types environment expression1 expression2 =
  do
    annotatedExpression1@(EType expression1Type _) <- inferExpression environment expression1
    annotatedExpression2@(EType expression2Type _) <- inferExpression environment expression2
    if expression1Type `elem` types && expression1Type == expression2Type then
      return (annotatedExpression1, annotatedExpression2)
    else
      fail $ "Wrong type of expression" ++ printTree expression1

inferUnaryExpression :: [Type] -> Environment -> Exp -> Err Exp
inferUnaryExpression types environment expression =
  do
    (EType expressionType expression) <- inferExpression environment expression
    if expressionType `elem` types then
      return (EType expressionType expression)
    else
      fail $ "Wrong type of expression" ++ printTree expression

lookupFunction :: Environment -> Id -> Err ([Type], Type)
lookupFunction (functions, _) functionId =
  case Map.lookup functionId functions of
    Just functionTypes  -> return functionTypes
    Nothing             -> fail $ "Function " ++ show functionId ++ " not declared."

updateFunction :: Environment -> Id -> ([Type], Type) -> Err Environment
updateFunction (functions, contexts) functionId functionTypes =
  if Map.member functionId functions then
    fail $ "Function name " ++ show functionId ++ " is aready declared in the current scope."
  else
    return (Map.insert functionId functionTypes functions, contexts)

lookupVariable :: Environment -> Id -> Err Type
lookupVariable (_, []) variableId = fail $ "Variable " ++ show variableId ++ " not declared."
lookupVariable (functions, topContext:restContexts) variableId =
  case Map.lookup variableId topContext of
    Just variableType  -> return variableType
    Nothing            -> lookupVariable (functions, restContexts) variableId

updateVariable :: Environment -> Id -> Type -> Err Environment
updateVariable (functions, topContext:restContexts) variableId variableType =
  if Map.member variableId topContext then
    fail $ "Variable " ++ show variableId ++ " already declared in current block."
  else
    return (functions, Map.insert variableId variableType topContext:restContexts)

newBlock :: Environment -> Environment
newBlock (functions, contexts) = (functions, Map.empty:contexts)

emptyEnvironment :: Environment
emptyEnvironment = (Map.empty, [])
