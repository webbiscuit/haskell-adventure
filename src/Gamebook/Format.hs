{-# LANGUAGE TemplateHaskell #-}

module Gamebook.Format
  (
    toJson,
  ) where

import Data.Aeson
import Data.Aeson.TH
import Gamebook.Book
import Gamebook.Section
import Gamebook.Choice

deriveJSON defaultOptions ''Section
deriveJSON defaultOptions ''Choice
deriveJSON defaultOptions ''Book

toJson :: Book -> String
toJson book = show (encode book)