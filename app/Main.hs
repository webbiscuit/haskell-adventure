module Main where

import Gamebook.Parser
import System.Environment
import System.Exit

main :: IO ()
main = getArgs >>= parse >>= putStr . parser
    where parser = show . parseTextIntoBook

parse :: [String] -> IO String
parse ["-h"] = usage   >> exit
parse ["-v"] = version >> exit
parse []     = getContents
parse fs     = concat `fmap` mapM readFile fs

usage :: IO ()
usage   = putStrLn "Usage: haskelladventure [-vh] [file ..]"

version :: IO ()
version = putStrLn "Haskell Adventure 0.1"

exit :: IO a
exit    = exitWith ExitSuccess

die :: IO a
die     = exitWith (ExitFailure 1)