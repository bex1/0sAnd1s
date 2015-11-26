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

typecheck :: Program -> Err ()
typecheck (PDefs definitions) =
  do
    environment  <- buildInitialSymbolTable emptyEnvironment
    environment' <- buildSymbolTable environment definitions
    checkDefinitions environment' definitions
    return ()

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

checkDefinitions :: Environment -> [Def] -> Err Environment
checkDefinitions = foldM checkDefinition

checkDefinition :: Environment -> Def -> Err Environment
checkDefinition environment (DFun returnType _ arguments statements) =
    do
      environment' <- foldM addArgument (newBlock environment) arguments
      checkStatements environment' returnType statements
  where
    addArgument environment (ADecl argumentType argumentId) = updateVariable environment argumentId argumentType

checkStatements :: Environment -> Type -> [Stm] -> Err Environment
checkStatements environment _ [] = return environment
checkStatements environment returnType (statement:statements) =
  do
    environment' <- checkStatement environment returnType statement
    checkStatements environment' returnType statements

checkStatement :: Environment -> Type -> Stm -> Err Environment
checkStatement environment functionReturnType statement =
    case statement of
      SExp expression -> inferExpression environment expression >> return environment
      SDecls variableType variableIds -> foldM (addVariable variableType) environment variableIds
      SInit variableType variableId expression -> checkExpression environment expression variableType
                                                  >> updateVariable environment variableId variableType
      SReturn returnExpression -> checkExpression environment returnExpression functionReturnType >> return environment
      SWhile conditionExpression statement' -> checkExpression environment conditionExpression Type_bool
                                               >> checkStatement environment functionReturnType statement'
      SBlock statements -> checkStatements (newBlock environment) functionReturnType statements >> return environment
      SIfElse conditionExpression trueStatement falseStatement ->
        do
          checkExpression environment conditionExpression Type_bool
          checkStatement environment functionReturnType trueStatement
          checkStatement environment functionReturnType falseStatement
          return environment
  where
    addVariable variableType environment variableId = updateVariable environment variableId variableType

checkExpression :: Environment -> Exp -> Type -> Err ()
checkExpression environment expression expectedType =
  do
    actualType <- inferExpression environment expression
    when (actualType /= expectedType) $
      fail $ printTree expression ++ " has type " ++ printTree actualType ++ " expected " ++ printTree expectedType

inferExpression :: Environment -> Exp -> Err Type
inferExpression environment expression =
  case expression of
    ETrue     -> return Type_bool
    EFalse    -> return Type_bool
    EInt _    -> return Type_int
    EDouble _ -> return Type_double
    EId variableId -> lookupVariable environment variableId
    EApp functionId argumentExpressions ->
      do
        (expectedArgumentTypes, returnType) <- lookupFunction environment functionId
        actualArgumentTypes <- mapM (inferExpression environment) argumentExpressions
        if expectedArgumentTypes == actualArgumentTypes then
          return returnType
        else
          fail $ printTree functionId ++ " called with argument types " ++ show actualArgumentTypes
                 ++ ", but the required argument types are " ++ show expectedArgumentTypes
    EPostIncr expression  -> inferUnaryExpression [Type_int, Type_double] environment expression
    EPostDecr expression  -> inferUnaryExpression [Type_int, Type_double] environment expression
    EPreIncr expression   -> inferUnaryExpression [Type_int, Type_double] environment expression
    EPreDecr expression   -> inferUnaryExpression [Type_int, Type_double] environment expression
    ETimes expression1 expression2 -> sameExpressionTypes expression1 expression2
    EDiv expression1 expression2   -> sameExpressionTypes expression1 expression2
    EPlus expression1 expression2  -> inferBinaryExpression [Type_int, Type_double] environment expression1 expression2
    EMinus expression1 expression2 -> inferBinaryExpression [Type_int, Type_double] environment expression1 expression2
    ELt expression1 expression2    -> sameExpressionTypes expression1 expression2 >> return Type_bool
    EGt expression1 expression2    -> sameExpressionTypes expression1 expression2 >> return Type_bool
    ELtEq expression1 expression2  -> sameExpressionTypes expression1 expression2 >> return Type_bool
    EGtEq expression1 expression2  -> sameExpressionTypes expression1 expression2 >> return Type_bool
    EEq expression1 expression2    -> sameExpressionTypes expression1 expression2 >> return Type_bool
    ENEq expression1 expression2   -> sameExpressionTypes expression1 expression2 >> return Type_bool
    EAnd expression1 expression2   -> bothExpressionsBool expression1 expression2
    EOr expression1 expression2    -> bothExpressionsBool expression1 expression2
    EAss (EId variableId) expression1 -> sameExpressionTypes (EId variableId) expression1
                                         >> inferExpression environment (EId variableId)
  where
    sameExpressionTypes expression1 expression2 =
      do
        type1 <- inferExpression environment expression1
        type2 <- inferExpression environment expression2
        if type1 == type2 then
          return type1
        else
          fail $ printTree expression1 ++ " has type " ++ printTree type1 ++ " but " ++ printTree expression2
                 ++ " has type " ++ printTree type2
    bothExpressionsBool expression1 expression2 =
      do
        type1 <- inferExpression environment expression1
        type2 <- inferExpression environment expression2
        if type1 == Type_bool && type2 == Type_bool then
          return Type_bool
        else
          fail $ printTree expression1 ++ " has type " ++ printTree type1 ++ " and " ++ printTree expression2
                 ++ " has type " ++ printTree type2 ++ ", but both should be bool."

inferBinaryExpression :: [Type] -> Environment -> Exp -> Exp -> Err Type
inferBinaryExpression types environment expression1 expression2 =
  do
    expression1Type <- inferExpression environment expression1
    if expression1Type `elem` types then
      checkExpression environment expression2 expression1Type >> return expression1Type
    else
      fail $ "Wrong type of expression" ++ printTree expression1

inferUnaryExpression :: [Type] -> Environment -> Exp -> Err Type
inferUnaryExpression types environment expression =
  do
    expressionType <- inferExpression environment expression
    if expressionType `elem` types then
      return expressionType
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
