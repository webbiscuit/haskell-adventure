module Gamebook.Choice
  (
    Choice (..),
  ) where

import Gamebook.Section

-- |A choice in a gamebook which links two sections.
data Choice = Choice {
  source :: SectionNumber,
  destination :: SectionNumber
} deriving (Show, Eq)