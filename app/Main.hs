module Main where

import Gamebook
import System.Environment

main :: IO ()
main = do
    args <- getArgs  
    contents <- readFile $ head args
    putStr contents

main2 :: IO ()
main2 = do
    contents <- loadBook
    putStr contents