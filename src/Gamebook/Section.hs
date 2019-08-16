module Gamebook.Section
  (
    Section (..),
    SectionNumber
  ) where

type SectionNumber = Int

data Section = Section {
  sectionNumber :: SectionNumber,
  sectionText :: String 
} deriving (Show, Eq)