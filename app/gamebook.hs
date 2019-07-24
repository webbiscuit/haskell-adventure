import Data.List
import System.IO
import System.Environment

type SectionNumber = Int

data Section = Section {
    sectionNumber :: SectionNumber,
    sectionText :: String 
} deriving Show

data Choice = Choice {
    source :: SectionNumber,
    destination :: SectionNumber,
    choiceText :: String 
} deriving Show

sections =
    [
        Section 1 "You are in a funny room",
        Section 2 "You do something",
        Section 3 "Oops you are dead"
    ]

choices = 
    [
        Choice 1 2 "Leave the door",
        Choice 1 3 "Jump out the window",
        Choice 2 1 "Go back through the door",
        Choice 2 3 "Hold your breath for a long time"
    ]

findChoices :: SectionNumber -> [Choice] -> [Choice]
findChoices n xs = filter (\x -> (source x) == n) xs

findSection :: SectionNumber -> [Section] -> Maybe Section
findSection n xs = find (\x -> (sectionNumber x) == n) xs

formatChoice :: Choice -> String
formatChoice c = (choiceText c) ++ " - " ++ show (destination c)

displayChoices :: [Choice] -> String
displayChoices xs = intercalate "\n" $ map formatChoice xs

displaySection :: Maybe Section -> [Choice] -> String
displaySection Nothing _ = ""
displaySection (Just s) xs = sectionText s ++ "\n" ++ displayChoices (findChoices (sectionNumber s) xs) 

parseIntoSections :: String -> [Section]
parseIntoSections s = []

play :: SectionNumber -> IO()
play n = putStr $ displaySection (findSection n sections) choices ++ "\n"

-- main = do
--     contents <- getContents
--     putStr $ map toUpper contents

--gmatchRegexPR "^(\\d+)$" contents

main2 = do
    contents <- readFile "books/test.txt"
    putStr contents

main = do
    args <- getArgs  
    contents <- readFile $ head args
    putStr contents