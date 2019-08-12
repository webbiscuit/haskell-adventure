import Test.Tasty
import Test.Tasty.Hspec

import Gamebook

main :: IO ()
main = do
  tree <- testSpec "Gamebook Tests" gamebookTestSuite
  defaultMain tree

gamebookTestSuite :: Spec
gamebookTestSuite = do
  parseBookTests

parseBookTests :: Spec
parseBookTests = do
  describe "Tests the book parser" $ do

    context "When the book string is empty" $ do
      it "No sections are returned" $ do
        parseBookIntoSections "" `shouldBe` ([] :: [Section])

    context "When there is a book with 1 section" $ do
      it "1 section is parsed" $ do
        parseBookIntoSections "1\nThis is a one section book." `shouldBe` ([
          (Section 1 "This is a one section book.")
          ] :: [Section])

    context "When there is a book with three sections" $ do
      it "3 sections are parsed" $ do
        parseBookIntoSections "1\nThis is a three section book. Turn to 2. Or turn to 3.\n2\nOpps, you get lost. Turn to 1.\n3\nYou win. Yay!" `shouldBe` ([
          (Section 1 "This is a three section book. Turn to 2. Or turn to 3."),
          (Section 2 "Opps, you get lost. Turn to 1."),
          (Section 3 "You win. Yay!")
          ] :: [Section])


