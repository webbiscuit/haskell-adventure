{-# LANGUAGE OverloadedStrings #-}

module Gamebook.Format.Dot where

import Data.Graph.Inductive
import Data.GraphViz as G
import Data.GraphViz.Printing
import Data.GraphViz.Attributes.Complete
import Data.Text.Lazy as L
import Data.Text as T
import Data.Word

import Gamebook.Book

ex1 :: Gr L.Text L.Text
ex1 = mkGraph [ (1,"one")
              , (3,"three")
              ]
              [ (1,3,"edge label") ]

ex1Params :: GraphvizParams n L.Text L.Text () L.Text
ex1Params = nonClusteredParams { 
  globalAttributes = ga,
  fmtNode          = fn,
  fmtEdge          = fe
  }
  where fn (_,l)   = [textLabel l]
        fe (_,_,l) = [textLabel l]
        ga = [ GraphAttrs [ 
          RankDir   FromLeft,
          BgColor   [toWColor White]
          ], NodeAttrs  [ 
            shape     BoxShape,
            FillColor (myColorCL 2),
            style filled
            ]
          ]

-- http://www.colorcombos.com/color-schemes/2025/ColorCombo2025.html
myColorCL :: Word8 -> ColorList
myColorCL n | n == 1 = c $ (RGB 127 108 138)
            | n == 2 = c $ (RGB 175 177 112)
            | n == 3 = c $ (RGB 226 206 179)
            | n == 4 = c $ (RGB 172 126 100)
 where c rgb = toColorList [rgb]
myColorCL _  = error "Error calculating colours"


myColor :: Word8 -> Attribute
myColor n = Color $ myColorCL n

-- |Converts a book into a json string.
toDot :: Book -> T.Text
toDot _ = L.toStrict . renderDot $ G.toDot $ graphToDot ex1Params ex1