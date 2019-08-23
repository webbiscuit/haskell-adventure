module Main where

import Gamebook.Parser
import System.Environment
import System.Exit

main :: IO ()
main = getArgs >>= parse >>= putStr . parser
    where parser input = show (parseTextIntoBook input)

parse ["-h"] = usage   >> exit
parse ["-v"] = version >> exit
parse []     = getContents
parse fs     = concat `fmap` mapM readFile fs

usage   = putStrLn "Usage: haskelladventure [-vh] [file ..]"
version = putStrLn "Haskell Adventure 0.1"
exit    = exitWith ExitSuccess
die     = exitWith (ExitFailure 1)