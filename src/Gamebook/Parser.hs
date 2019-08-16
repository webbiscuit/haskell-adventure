module Gamebook.Parser
  (
    parseTextIntoBook,
  ) where

import Text.Regex.PCRE
import Data.String.Utils

import Gamebook.Book
import Gamebook.Section
import Gamebook.Choice

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
parseSectionsIntoChoices = concat . map parseSectionIntoChoices

parseSectionText :: String -> [[String]]
parseSectionText s = s =~ sectionParseRegex :: [[String]]

parseText :: String -> [[String]]
parseText t = t =~ bookParseRegex :: [[String]]

parseTextIntoSections :: String -> [Section]
parseTextIntoSections = matchesToSections . parseText

parseTextIntoBook :: String -> Book
parseTextIntoBook t = Book sections choices
    where
      sections = parseTextIntoSections t
      choices = parseSectionsIntoChoices sections

test = "1\n\nI am a section.\n\nSomething happens. Turn to 2.\n\nSomething else. Turn to 3.\n2\nSome stuff. Turn to 1.\n3\nDone.\nTurn to 2."