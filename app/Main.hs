module Main where

import Gamebook
import System.Environment

main :: IO ()
main = interact parser
    where parser input = show (parseTextIntoSections input)

mainFromFileName :: IO ()
mainFromFileName = do
    args <- getArgs  
    contents <- readFile $ head args
    putStr contents
