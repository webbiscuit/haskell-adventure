module Main where

import Gamebook.Parser
import System.Environment

main :: IO ()
main = interact parser
    where parser input = show (parseTextIntoBook input)

mainFromFileName :: IO ()
mainFromFileName = do
    args <- getArgs  
    contents <- readFile $ head args
    putStr contents
