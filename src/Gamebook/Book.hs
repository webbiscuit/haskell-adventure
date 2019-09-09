module Gamebook.Book
  (
    Book (..),
  ) where

import Gamebook.Section
import Gamebook.Choice

-- |A gamebook has a list of sections and choices.
data Book = Book {
  sections :: [Section],
  choices :: [Choice]
} deriving (Show, Eq)
