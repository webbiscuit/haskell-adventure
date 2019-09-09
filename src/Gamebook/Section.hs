module Gamebook.Section
  (
    Section (..),
    SectionNumber
  ) where

import qualified Data.Text as T
type SectionNumber = Int

data Section = Section {
  sectionNumber :: SectionNumber,
  sectionText :: T.Text 
} deriving (Show, Eq)