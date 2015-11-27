module Interpreter where

import AbsCPP
import PrintCPP

import Control.Monad
import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map

type FunctionDefinitions = Map Id Def
type Context = Map Id Value
type Environment = (FunctionDefinitions, [Context])

data Value = VInt Integer
           | VDouble Double
           | VBool Bool
           | VVoid
           | VUndef
           deriving (Eq, Show)

instance Ord Value where
    compare (VInt integer1) (VInt integer2) = compare integer1 integer2
    compare (VInt integer) (VDouble double) = compare (fromIntegral integer) double
    compare (VDouble double) (VInt integer) = compare double (fromIntegral integer)
    compare (VDouble double1) (VDouble double2) = compare double1 double2

interpret :: Program -> IO ()
interpret (PDefs definitions) =
  do
    let environment = foldl updateFunctionDefinition emptyEnvironment definitions
    evaluateExpression environment (EApp (Id "main") [])
    return ()

evaluateExpression :: Environment -> Exp -> IO (Value,Environment)
evaluateExpression environment expression =
    case expression of
      ETrue              -> return (VBool True, environment)
      EFalse             -> return (VBool False, environment)
      EInt integer       -> return (VInt integer, environment)
      EDouble double     -> return (VDouble double, environment)
      EId variableId     -> return (lookupVariableValue environment variableId, environment)
      EApp (Id "printInt") expression' ->
        do
          (VInt integer, environment') <- evaluateExpression environment (head expression')
          print integer
          return (VVoid, environment')
      EApp (Id "printDouble") expression' ->
        do
          (VDouble double, environment') <- evaluateExpression environment (head expression')
          print double
          return (VVoid, environment')
      EApp (Id "readInt") _ ->
        do
          integer <- getLine
          return (VInt (read integer), environment)
      EApp (Id "readDouble") _ ->
        do
          double <- getLine
          return (VDouble (read double), environment)
      EApp functionId argumentExpressions ->
        do
          (argumentValues, environment') <- foldM evaluateAndConcatenateExpressionValue ([], environment) argumentExpressions
          let functionDefinition@(DFun _ _ argumentDeclarations _) = lookupFunctionDefinition environment' functionId
          let argumentIds = map (\(ADecl _ it) -> it) argumentDeclarations
          let environment'' = enterScope environment'
          let arguments = zip argumentIds argumentValues
          let environment''' = foldl (\expression' (argumentId,argumentValue) -> updateVariableValue (addVariableToCurrentContext expression' argumentId) argumentId argumentValue) environment'' arguments
          (resultingValue, resultingEnvironment) <- executeFunction environment''' functionDefinition
          return (resultingValue, leaveScope resultingEnvironment)
      EPostIncr (EId variableId)        -> evaluateUnaryPostExpression environment variableId (+) (+)
      EPostDecr (EId variableId)        -> evaluateUnaryPostExpression environment variableId (-) (-)
      EPreIncr (EId variableId)         -> evaluateUnaryPreExpression environment variableId (+) (+)
      EPreDecr (EId variableId)         -> evaluateUnaryPreExpression environment variableId (-) (-)
      ETimes expression1 expression2    -> evaluteBinaryNumberExpression environment expression1 expression2 (*) (*)
      EDiv expression1 expression2      -> evaluteBinaryNumberExpression environment expression1 expression2 div (/)
      EPlus expression1 expression2     -> evaluteBinaryNumberExpression environment expression1 expression2 (+) (+)
      EMinus expression1 expression2    -> evaluteBinaryNumberExpression environment expression1 expression2 (-) (-)
      ELt expression1 expression2       -> evaluateComparisonExpression (<)  expression1 expression2
      EGt expression1 expression2       -> evaluateComparisonExpression (>)  expression1 expression2
      ELtEq expression1 expression2     -> evaluateComparisonExpression (<=) expression1 expression2
      EGtEq expression1 expression2     -> evaluateComparisonExpression (>=) expression1 expression2
      EEq expression1 expression2       -> evaluateComparisonExpression (==) expression1 expression2
      ENEq expression1 expression2      -> evaluateComparisonExpression (/=) expression1 expression2
      EAnd expression1 expression2 ->
        do
          (value1, environment') <- evaluateExpression environment expression1
          if value1 == VBool True then
            evaluateExpression environment' expression2
          else
            return (VBool False, environment')
      EOr expression1 expression2 ->
        do
          (value1, environment') <- evaluateExpression environment expression1
          if value1 == VBool False then
            evaluateExpression environment' expression2
          else
            return (VBool True, environment')
      EAss (EId variableId) expression2 ->
        do
          (value, environment')  <- evaluateExpression environment expression2
          return (value, updateVariableValue environment' variableId value)
  where
    evaluateAndConcatenateExpressionValue (value, environment) expression =
      do
        (value', environment') <- evaluateExpression environment expression
        return (value ++ [value'], environment')
    evaluateComparisonExpression operator expression1 expression2 =
      do
        (value1, environment') <- evaluateExpression environment expression1
        (value2, environment'') <- evaluateExpression environment' expression2
        if value1 `operator` value2 then
          return (VBool True, environment'')
        else
          return (VBool False, environment'')
    evaluteBinaryNumberExpression environment expression1 expression2 integerOperator doubleOperator =
      do
        (value1, environment')  <- evaluateExpression environment expression1
        (value2, environment'') <- evaluateExpression environment' expression2
        case (value1,value2) of
          (VInt integer1, VInt integer2)     -> return (VInt (integer1 `integerOperator` integer2), environment'')
          (VDouble double1, VDouble double2) -> return (VDouble (double1 `doubleOperator` double2), environment'')
    evaluateUnaryPostExpression environment variableId integerOperator doubleOperator =
      do
        (value, environment') <- evaluateExpression environment (EId variableId)
        (_, environment'') <- evaluateNewUnaryExpressionValue environment' variableId value integerOperator doubleOperator
        return (value, environment'')
    evaluateUnaryPreExpression environment variableId integerOperator doubleOperator =
      do
        (value, environment') <- evaluateExpression environment (EId variableId)
        (newValue, environment'') <- evaluateNewUnaryExpressionValue environment' variableId value integerOperator doubleOperator
        return (newValue, environment'')
    evaluateNewUnaryExpressionValue environment variableId value integerOperator doubleOperator =
      do
        let newValue = case value of
              VInt integer -> VInt $ integer `integerOperator` 1
              VDouble double -> VDouble $ double `doubleOperator` 1
        let environment' = updateVariableValue environment variableId newValue
        return (newValue, environment')


executeFunction :: Environment -> Def -> IO (Value, Environment)
executeFunction environment (DFun _ _ _ []) = return (VVoid, environment)
executeFunction environment (DFun returnType functionId argumentDeclarations (statement:restStatements)) =
  do
    (returnValue, environment') <- executeStatement environment statement
    case returnValue of
      Nothing -> executeFunction environment' (DFun returnType functionId argumentDeclarations restStatements)
      Just resultValue -> return (resultValue, environment')

executeStatement :: Environment -> Stm -> IO (Maybe Value, Environment)
executeStatement environment statement =
  case statement of
    SExp expression ->
      do
        (_, environment') <- evaluateExpression environment expression
        return (Nothing, environment')
    SDecls _ variableIds -> return (Nothing, foldl addVariableToCurrentContext environment variableIds)
    SInit _ variableId expression ->
      do
        let environment' = addVariableToCurrentContext environment variableId
        (value, environment'') <- evaluateExpression environment' expression
        return (Nothing, updateVariableValue environment'' variableId value)
    SReturn returnExpression ->
      do
        (resultValue, environment') <- evaluateExpression environment returnExpression
        return (Just resultValue, environment')
    SWhile conditionExpression statement' ->
      do
        (value, environment') <- evaluateExpression environment conditionExpression
        if value == VBool True then
          do
            (returnValue, environment'') <- executeStatement environment' statement'
            if isNothing returnValue then
              executeStatement environment'' statement
            else
              return (returnValue, environment'')
        else
          return (Nothing, environment')
    SBlock statements ->
      do
        (returnValue, environment') <- executeStatements (enterScope environment) statements
        return (returnValue, leaveScope environment')
    SIfElse conditionExpression statement1 statement2 ->
      do
        (value, environment') <- evaluateExpression environment conditionExpression
        if value == VBool True then
          executeStatement environment' statement1
        else
          executeStatement environment' statement2

executeStatements :: Environment -> [Stm] -> IO (Maybe Value, Environment)
executeStatements environment [] = return (Nothing, environment)
executeStatements environment (statement:statements) =
  do
    (returnValue, environment') <- executeStatement environment statement
    if isNothing returnValue then
      executeStatements environment' statements
    else
      return (returnValue, environment')

addVariableToCurrentContext :: Environment -> Id -> Environment
addVariableToCurrentContext (functionDefinitions, context:restContexts) variableId = (functionDefinitions, Map.insert variableId VUndef context:restContexts)

lookupVariableValue :: Environment -> Id -> Value
lookupVariableValue (_, []) variableId = error $ "Variable " ++ printTree variableId ++ " not found."
lookupVariableValue (functionDefinitions, context:restContexts) variableId =
  fromMaybe
    (lookupVariableValue (functionDefinitions, restContexts) variableId)
    (Map.lookup variableId context)

updateVariableValue :: Environment -> Id -> Value -> Environment
updateVariableValue (_, []) variableId _ = error $ "Unknown variable " ++ printTree variableId ++ "."
updateVariableValue (functionDefinitions, context:contexts) variableId newValue =
  case Map.lookup variableId context of
    Nothing -> let (functionDefinitions', contexts') = updateVariableValue (functionDefinitions, contexts) variableId newValue
               in (functionDefinitions', context:contexts')
    Just _  -> (functionDefinitions, Map.insert variableId newValue context:contexts)

lookupFunctionDefinition :: Environment -> Id -> Def
lookupFunctionDefinition (functionDefinitions, _) functionId =
  fromMaybe
    (error $ "Function " ++ show functionId ++ " not found.")
    (Map.lookup functionId functionDefinitions)

updateFunctionDefinition :: Environment -> Def -> Environment
updateFunctionDefinition (functionDefinitions, contexts) functionDefinition@(DFun _ functionId _ _) = (Map.insert functionId functionDefinition functionDefinitions, contexts)

enterScope :: Environment -> Environment
enterScope (functionDefinitions, contexts) = (functionDefinitions, Map.empty:contexts)

leaveScope :: Environment -> Environment
leaveScope (functionDefinitions, _:restContexts) = (functionDefinitions, restContexts)

emptyEnvironment :: Environment
emptyEnvironment = (Map.empty, []) -- (Map.empty, [Map.empty]) ?
