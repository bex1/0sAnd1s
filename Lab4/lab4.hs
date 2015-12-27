import System.Environment (getArgs)
import System.Exit (exitFailure)

import ParGrammar
import ErrM
import PrintGrammar

import Interpreter

type Flag = String

main :: IO ()
main =
  do
    args <- getArgs
    case args of
      (flag:file:_) ->
        do
          source <- readFile file
          evaluate (lookupEvaluationMode flag) source
      (file:_) ->
        do
          source <- readFile file
          evaluate defaultEvaluationMode source
      _ ->
        do
          putStrLn "Usage: lab4 (-n|-v) <SourceFile>"
          exitFailure

evaluate :: EvaluationMode -> String-> IO ()
evaluate evaluationMode source =
  case pProgram (myLexer source) of
    Bad err ->
     do
       putStrLn "SYNTAX ERROR"
       putStrLn err
       exitFailure
    Ok tree ->
     do
       putStrLn $ printTree tree
       let result = interpret tree evaluationMode
       putStrLn $ "Result: " ++ show result

defaultEvaluationMode :: EvaluationMode
defaultEvaluationMode = CallByValue

lookupEvaluationMode :: Flag -> EvaluationMode
lookupEvaluationMode "-n" = CallByName
lookupEvaluationMode "-v" = CallByValue
lookupEvaluationMode flag = error $ flag ++ " is an invalid flag. Usage: lab4 (-n|-v) <SourceFile>"
