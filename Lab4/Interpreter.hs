module Interpreter where

import AbsGrammar
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe

data EvaluationMode
  = CallByName
  | CallByValue
  deriving (Eq)

data Environment
  = Environment
    {
      functions :: Map Ident Value,
      variables :: Map Ident Value
    }
  deriving (Show, Eq)

data Value
  = IntegerValue Integer
  | Closure Exp Environment
  deriving (Show, Eq)

interpret :: Program -> EvaluationMode -> Integer
interpret (Prog definitions) evaluationMode = result
  where
    Closure mainExpression _ = lookupIdentifier (Ident "main") environment
    environment = buildFunctionEnvironment definitions
    value = evaluateExpression environment mainExpression evaluationMode
    result = getIntegerValue value

buildFunctionEnvironment :: [Def] -> Environment
buildFunctionEnvironment =
  foldl
    (\environment (DDef identifier args expression) ->
      updateFunction environment identifier (createEmptyClosure expression args))
    emptyEnvironment

evaluateExpression :: Environment -> Exp -> EvaluationMode -> Value
evaluateExpression environment expression evaluationMode =
  case expression of

    EVar identifier ->
      let
        Closure expression' environment' = lookupIdentifier identifier environment
      in
        evaluateExpression (Environment (functions environment) (variables environment')) expression' evaluationMode

    EInt _ -> Closure expression emptyEnvironment

    EApp expression1 expression2 ->
      let
        Closure (EAbs identifier expression') environment' = evaluateExpression environment expression1 evaluationMode
        value = case evaluationMode of
          CallByName -> Closure expression2 (Environment Map.empty $ variables environment)
          CallByValue -> evaluateExpression environment expression2 evaluationMode
        newEnvironment = updateVariable (Environment (functions environment) (variables environment')) identifier value
      in
        evaluateExpression newEnvironment expression' evaluationMode

    EAdd expression1 expression2 ->
      let
        u = getIntegerValue $ evaluateExpression environment expression1 evaluationMode
        v = getIntegerValue $ evaluateExpression environment expression2 evaluationMode
      in
        Closure (EInt (u + v)) emptyEnvironment

    ESub expression1 expression2 ->
      let
        u = getIntegerValue $ evaluateExpression environment expression1 evaluationMode
        v = getIntegerValue $ evaluateExpression environment expression2 evaluationMode
      in
        Closure (EInt (u - v)) emptyEnvironment

    ELt expression1 expression2 ->
      let
        u = getIntegerValue $ evaluateExpression environment expression1 evaluationMode
        v = getIntegerValue $ evaluateExpression environment expression2 evaluationMode
      in
        IntegerValue (if u < v then 1 else 0)

    EIf condition expression1 expression2 ->
      let
        conditionResult = evaluateExpression environment condition evaluationMode
      in
        if conditionResult == IntegerValue 1 then
          evaluateExpression environment expression1 evaluationMode
        else
          evaluateExpression environment expression2 evaluationMode

    EAbs _ _ -> Closure expression (Environment Map.empty $ variables environment)

getIntegerValue :: Value -> Integer
getIntegerValue (IntegerValue integer) = integer
getIntegerValue (Closure (EInt integer) _) = integer
getIntegerValue _ = error "Not an integer value."

createEmptyClosure :: Exp -> [Ident] -> Value
createEmptyClosure expression args = Closure (convertToAbstractionExpression expression args) emptyEnvironment

convertToAbstractionExpression :: Exp -> [Ident] -> Exp
convertToAbstractionExpression expression [] = expression
convertToAbstractionExpression expression args = convertToAbstractionExpression (EAbs lastIdentifier expression) (init args)
  where
    lastIdentifier = last args

emptyEnvironment :: Environment
emptyEnvironment = Environment Map.empty Map.empty

lookupIdentifier :: Ident -> Environment -> Value
lookupIdentifier identifier@(Ident name) environment =
  fromMaybe
    (fromMaybe
      (error $ "Unknown identifier " ++ name)
      (lookupFunction identifier environment))
    (lookupVariable identifier environment)

lookupFunction :: Ident -> Environment -> Maybe Value
lookupFunction identifier environment = Map.lookup identifier (functions environment)

lookupVariable :: Ident -> Environment -> Maybe Value
lookupVariable identifier environment = Map.lookup identifier (variables environment)

updateFunction :: Environment -> Ident -> Value -> Environment
updateFunction environment identifier value =
  environment
    {
      functions = Map.insert identifier value (functions environment)
    }

updateVariable :: Environment -> Ident -> Value -> Environment
updateVariable environment identifier value =
  environment
    {
      variables = Map.insert identifier value (variables environment)
    }
