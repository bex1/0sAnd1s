import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.Process
import System.FilePath

import AbsCPP
import LexCPP
import ParCPP
import ErrM
import PrintCPP

import TypeChecker
import CodeGenerator

-- driver

compileAndRunAsJava :: FilePath -> IO ()
compileAndRunAsJava filePath =
  do
    let (dir, file) = splitFileName filePath
    s <- readFile filePath
    case pProgram (myLexer s) of
      Bad err  ->
        do
          putStrLn "SYNTAX ERROR"
          putStrLn err
          exitFailure
      Ok  tree ->
        case typecheck tree of
          Bad err ->
            do
              putStrLn "TYPE ERROR"
              putStrLn err
              exitFailure
          Ok t ->
            do
              putStrLn $ printTree t
              let strippedFileName = dropExtension file
              runCompiler dir strippedFileName $ compile strippedFileName t

runCompiler :: FilePath -> FilePath -> String -> IO ()
runCompiler dir strippedFileName code =
  do
    writeFile (combine dir (addExtension strippedFileName "j")) code
    p <- runCommand ("java -jar jasmin.jar -d " ++ dir ++ " " ++ (dir ++ addExtension strippedFileName "j") ++ " > /dev/null")
    waitForProcess p
    runCommand ("java -cp " ++ dir ++ " " ++ strippedFileName)
    return ()

main :: IO ()
main =
  do
    args <- getArgs
    case args of
      [filePath] -> compileAndRunAsJava filePath
      _      ->
        do
          putStrLn "Usage: lab3 <SourceFile>"
          exitFailure
