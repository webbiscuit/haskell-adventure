module Gamebook.Parser
  (
    parseTextIntoBook,
  ) where

import qualified Data.Text as T
import Text.Regex.PCRE
import Gamebook.Book hiding (sections, choices)
import Gamebook.Section
import Gamebook.Choice

bookParseRegex :: String
bookParseRegex = "^(\\d+)\\n([\\s\\S]*?)(?=^\\d+|\\z)"

sectionParseRegex :: String
sectionParseRegex = "(?i)(turn to|at|turning to|go to) (\\d+)"

toSectionNumber :: String -> SectionNumber
toSectionNumber n = read n :: SectionNumber

matchToChoice :: Section -> [String] -> Choice
matchToChoice section [_, _, d] = Choice (sectionNumber section) (toSectionNumber d)
matchToChoice _ _ = error "Error parsing choice"

matchesToChoices :: Section -> [[String]] -> [Choice]
matchesToChoices = map . matchToChoice

matchToSection :: [String] -> Section
matchToSection [_, n, t] = Section (toSectionNumber n) $ T.strip (T.pack t)
matchToSection _ = error "Error parsing section"

matchesToSections :: [[String]] -> [Section]
matchesToSections = map matchToSection

parseSectionIntoChoices :: Section -> [Choice]
parseSectionIntoChoices section = matchesToChoices section $ parseSectionText $ T.unpack $ sectionText section

parseSectionsIntoChoices :: [Section] -> [Choice]
parseSectionsIntoChoices = concatMap parseSectionIntoChoices

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

-- test = "1\n\nI am a section.\n\nSomething happens. Turn to 2.\n\nSomething else. Turn to 3.\n2\nSome stuff. Turn to 1.\n3\nDone.\nTurn to 2."