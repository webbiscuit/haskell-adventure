{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Gamebook.Format.Json
  (
    toJson,
  ) where

import Data.Aeson
import Data.Aeson.TH
import Data.Aeson.Text
import Gamebook.Book
import Gamebook.Section
import Gamebook.Choice
import qualified Data.Text as T
import qualified Data.Text.Lazy as L

deriveJSON defaultOptions ''Section
deriveJSON defaultOptions ''Choice
deriveJSON defaultOptions ''Book

toJson :: Book -> T.Text
toJson = L.toStrict . encodeToLazyText
