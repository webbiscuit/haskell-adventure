module Gamebook.Choice
  (
    Choice (..),
  ) where

import Gamebook.Section

data Choice = Choice {
  source :: SectionNumber,
  destination :: SectionNumber
} deriving (Show, Eq)