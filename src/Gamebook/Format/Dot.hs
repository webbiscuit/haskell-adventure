{-# LANGUAGE OverloadedStrings #-}

module Gamebook.Format.Dot where

import Data.Graph.Inductive
import Data.GraphViz as G
import Data.GraphViz.Printing
import Data.GraphViz.Attributes.Complete
import Data.Text.Lazy as L
import Data.Text as T
import Data.Word
import Prelude

import Gamebook.Book
import Gamebook.Section
import Gamebook.Choice

dotParams :: GraphvizParams n L.Text L.Text () L.Text
dotParams = nonClusteredParams { 
  globalAttributes = ga,
  fmtNode          = fn,
  fmtEdge          = fe
  }
  where fn (_,l)   = [textLabel l]
        fe (_,_,l) = []
        ga = [ GraphAttrs [ 
          RankDir   FromLeft,
          BgColor   [toWColor White]
          ], NodeAttrs  [ 
            shape     BoxShape,
            FillColor fillColour,
            style filled
            ]
          ]

fillColour :: ColorList
fillColour = toColorList [RGB 175 177 112]

sectionToTuple :: Section -> (Int, L.Text)
sectionToTuple s = (sectionNumber s, L.pack . show $ sectionNumber s)

sectionsToTuples :: [Section] -> [(Int, L.Text)]
sectionsToTuples = Prelude.map sectionToTuple

choiceToTuple :: Choice -> (Int, Int, L.Text)
choiceToTuple c = (source c, destination c, "")

choicesToTuples :: [Choice] -> [(Int, Int, L.Text)]
choicesToTuples = Prelude.map choiceToTuple

bookToGraph :: Book -> Gr L.Text L.Text
bookToGraph b = mkGraph sectionData choiceData
  where sectionData = sectionsToTuples $ sections b
        choiceData = choicesToTuples $ choices b

-- |Converts a book into a dot string.
toDot :: Book -> T.Text
toDot b = L.toStrict . renderDot $ G.toDot $ graphToDot dotParams $ bookToGraph b