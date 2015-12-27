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

compileToJava :: FilePath -> IO ()
compileToJava filePath =
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
              let strippedFileName = dropExtension file
              createClassFile dir strippedFileName $ compile strippedFileName t

createClassFile :: FilePath -> FilePath -> String -> IO ()
createClassFile dir strippedFileName code =
  do
    writeFile (combine dir (addExtension strippedFileName "j")) code
    p <- runCommand ("java -jar jasmin.jar -d " ++ dir ++ " " ++ (dir ++ addExtension strippedFileName "j"))
    waitForProcess p
    return ()

main :: IO ()
main =
  do
    args <- getArgs
    case args of
      [filePath] -> compileToJava filePath
      _      ->
        do
          putStrLn "Usage: lab3 <SourceFile>"
          exitFailure
