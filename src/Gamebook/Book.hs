module Gamebook.Book
  (
    Book (..),
  ) where

import Gamebook.Section
import Gamebook.Choice

data Book = Book {
  sections :: [Section],
  choices :: [Choice]
} deriving (Show, Eq)
