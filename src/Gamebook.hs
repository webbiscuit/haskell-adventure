module Gamebook
  (
    loadBook,
    parseTextIntoSections,
    Section (..)
  ) where

import Text.Regex.PCRE
import Data.String.Utils

type SectionNumber = Int

data Section = Section {
  sectionNumber :: SectionNumber,
  sectionText :: String 
} deriving (Show, Eq)

data Choice = Choice {
  source :: SectionNumber,
  destination :: SectionNumber
} deriving (Show, Eq)

-- findChoices :: SectionNumber -> [Choice] -> [Choice]
-- findChoices n = filter (\x -> (source x) == n)

-- findSection :: SectionNumber -> [Section] -> Maybe Section
-- findSection n = find (\x -> (sectionNumber x) == n) 

-- formatChoice :: Choice -> String
-- formatChoice c = (choiceText c) ++ " - " ++ show (destination c)

-- displayChoices :: [Choice] -> String
-- displayChoices = intercalate "\n" . map formatChoice

-- displaySection :: Maybe Section -> [Choice] -> String
-- displaySection Nothing _ = ""
-- displaySection (Just s) xs = sectionText s ++ "\n" ++ displayChoices (findChoices (sectionNumber s) xs) 

-- play :: [Section] -> [Choice] -> SectionNumber -> IO()
-- play sections choices n = putStr $ displaySection (findSection n sections) choices ++ "\n"


bookParseRegex :: String
bookParseRegex = "^(\\d+)\\n([\\s\\S]*?)(?=^\\d+|\\z)"

sectionParseRegex :: String
sectionParseRegex = "(?i)(turn to|at|turning to|go to) (\\d+)"

matchToChoice :: Section -> [String] -> Choice
matchToChoice section [_, _, d] = Choice (sectionNumber section) (read d :: SectionNumber)

matchesToChoices :: Section -> [[String]] -> [Choice]
matchesToChoices = map . matchToChoice

matchToSection :: [String] -> Section
matchToSection [_, n, t] = Section (read n :: SectionNumber) $ strip t

matchesToSections :: [[String]] -> [Section]
matchesToSections = map matchToSection

parseSectionIntoChoices :: Section -> [Choice]
parseSectionIntoChoices section = matchesToChoices section $ parseSectionText $ sectionText section

parseSectionsIntoChoices :: [Section] -> [Choice]
parseSectionsIntoChoices xs = concat (map parseSectionIntoChoices xs) 

parseSectionText :: String -> [[String]]
parseSectionText s = s =~ sectionParseRegex :: [[String]]

parseText :: String -> [[String]]
parseText t = t =~ bookParseRegex :: [[String]]

parseTextIntoSections :: String -> [Section]
parseTextIntoSections =  matchesToSections . parseText

loadBook :: IO String
loadBook = readFile "./app/books/fridge.txt"

-- test = [["1\n\nAfter a restless night full of sleepless dreams, you awake to find yourself trapped in a fridge. \n\nTurn to 2.\n\n","1","\n\nAfter a restless night full of sleepless dreams, you awake to find yourself trapped in a fridge. \n\nTurn to 2.\n\n"],["2\n\nThere's some food all around.\n\nTry to open the door. Turn to 3.\nEat some food. Turn to 4.\nGive up and die. Turn to 5.\n\n","2","\n\nThere's some food all around.\n\nTry to open the door. Turn to 3.\nEat some food. Turn to 4.\nGive up and die. Turn to 5.\n\n"],["3\n\nThe door does not seem to open.\n\nTry to open the door. Turn to 3.\nEat some food. Turn to 4.\nGive up and die. Turn to 5.\n\n","3","\n\nThe door does not seem to open.\n\nTry to open the door. Turn to 3.\nEat some food. Turn to 4.\nGive up and die. Turn to 5.\n\n"],["4\n\nThere is so much food here.\nYou eat so much food you die.\n\nThe End\n\n","4","\n\nThere is so much food here.\nYou eat so much food you die.\n\nThe End\n\n"],["5\n\nYou have died.\n\nThe End\n\n","5","\n\nYou have died.\n\nThe End\n\n"],["6\n\n","6","\n\n"],["7\n\n","7","\n\n"],["8\n\n","8","\n\n"],["9\n\n","9","\n\n"],["10\n\n","10","\n\n"],["11\n\n","11","\n\n"],["12\n\n","12","\n\n"],["13\n\n","13","\n\n"],["14\n\n","14","\n\n"]]
-- test2 = do
--   book <- loadBook
--   let sections = parseTextIntoSections book
--   let choices = parseSectionsIntoChoices sections
--   play sections choices 2
-- test3 = Section 1 "I am a section.\n\nSomething happens. Turn to 2.\n\nSomething else. Turn to 3."
-- test4 = "Some ‘ thing"