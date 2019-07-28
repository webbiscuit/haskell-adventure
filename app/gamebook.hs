import Data.List
import System.IO
import System.Environment
import Text.Regex.PCRE
import Data.String.Utils

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
findChoices n = filter (\x -> (source x) == n)

findSection :: SectionNumber -> [Section] -> Maybe Section
findSection n = find (\x -> (sectionNumber x) == n) 

formatChoice :: Choice -> String
formatChoice c = (choiceText c) ++ " - " ++ show (destination c)

displayChoices :: [Choice] -> String
displayChoices = intercalate "\n" . map formatChoice

displaySection :: Maybe Section -> [Choice] -> String
displaySection Nothing _ = ""
displaySection (Just s) xs = sectionText s ++ "\n" ++ displayChoices (findChoices (sectionNumber s) xs) 

parseIntoSections :: String -> [Section]
parseIntoSections s = []

play :: SectionNumber -> IO()
play n = putStr $ displaySection (findSection n sections) choices ++ "\n"


bookParseRegex :: String
bookParseRegex = "^(\\d+)([\\s\\S]*?)(?=^\\d+)"

trimSectionText :: String -> String
trimSectionText = strip

matchToSection :: [String] -> Section
matchToSection [_,n, t] = Section (read n :: SectionNumber) $ trimSectionText t

matchesToSections :: [[String]] -> [Section]
matchesToSections = map matchToSection

parseBook :: String -> [[String]]
parseBook s = s =~ bookParseRegex :: [[String]]

parseBookIntoSections :: String -> [Section]
parseBookIntoSections =  matchesToSections . parseBook

loadBook :: IO String
loadBook = readFile "books/fridge.txt"

test = [["1\n\nAfter a restless night full of sleepless dreams, you awake to find yourself trapped in a fridge. \n\nTurn to 2.\n\n","1","\n\nAfter a restless night full of sleepless dreams, you awake to find yourself trapped in a fridge. \n\nTurn to 2.\n\n"],["2\n\nThere's some food all around.\n\nTry to open the door. Turn to 3.\nEat some food. Turn to 4.\nGive up and die. Turn to 5.\n\n","2","\n\nThere's some food all around.\n\nTry to open the door. Turn to 3.\nEat some food. Turn to 4.\nGive up and die. Turn to 5.\n\n"],["3\n\nThe door does not seem to open.\n\nTry to open the door. Turn to 3.\nEat some food. Turn to 4.\nGive up and die. Turn to 5.\n\n","3","\n\nThe door does not seem to open.\n\nTry to open the door. Turn to 3.\nEat some food. Turn to 4.\nGive up and die. Turn to 5.\n\n"],["4\n\nThere is so much food here.\nYou eat so much food you die.\n\nThe End\n\n","4","\n\nThere is so much food here.\nYou eat so much food you die.\n\nThe End\n\n"],["5\n\nYou have died.\n\nThe End\n\n","5","\n\nYou have died.\n\nThe End\n\n"],["6\n\n","6","\n\n"],["7\n\n","7","\n\n"],["8\n\n","8","\n\n"],["9\n\n","9","\n\n"],["10\n\n","10","\n\n"],["11\n\n","11","\n\n"],["12\n\n","12","\n\n"],["13\n\n","13","\n\n"],["14\n\n","14","\n\n"]]

main2 = do
    contents <- loadBook
    putStr contents

main = do
    args <- getArgs  
    contents <- readFile $ head args
    putStr contents