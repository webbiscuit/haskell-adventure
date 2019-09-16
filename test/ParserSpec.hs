module ParserSpec(
  spec
) where

import Test.Tasty.Hspec
import Gamebook.Parser
import Gamebook.Book
import Gamebook.Section
import Gamebook.Choice

spec :: Spec
spec = do
  describe "Tests the book parser" $ do

    context "When the book string is empty" $ do
      it "No sections are returned" $ do
        parseTextIntoBook "" `shouldBe` (Book [] [])

    context "When there is a book with 1 section" $ do
      it "1 section is parsed" $ do
        parseTextIntoBook "1\nThis is a one section book." `shouldBe` (
          Book [(Section 1 "This is a one section book.")] [])

    context "When there is a book with three sections" $ do
      it "3 sections are parsed" $ do
        parseTextIntoBook "1\nThis is a three section book. Turn to 2. Or turn to 3.\n2\nOpps, you get lost. Turn to 1.\n3\nYou win. Yay!" `shouldBe` (
          Book [
            (Section 1 "This is a three section book. Turn to 2. Or turn to 3."),
            (Section 2 "Opps, you get lost. Turn to 1."),
            (Section 3 "You win. Yay!")
          ] [
            (Choice 1 2),
            (Choice 1 3),
            (Choice 2 1)
          ])

    context "When there is a book with embedded choice text" $ do
      it "Should pick out the choice correctly" $ do
        parseTextIntoBook "1\nThis is an infinite book. Okay, turn to 2 immediately.\n2\nOkay great! Something happens.\n\nIf you have less than 100 stamina, turn to 1 immediately." `shouldBe` (
          Book [
            (Section 1 "This is an infinite book. Okay, turn to 2 immediately."),
            (Section 2 "Okay great! Something happens.\n\nIf you have less than 100 stamina, turn to 1 immediately.")
          ] [(Choice 1 2), (Choice 2 1)])