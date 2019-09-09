import Test.Tasty
import Test.Tasty.Hspec

import ParseBookTests
import FormatJsonTests

main :: IO ()
main = do
  tree <- testSpec "Gamebook Tests" gamebookTestSuite
  defaultMain tree

gamebookTestSuite :: Spec
gamebookTestSuite = do
  parseBookTests
  formatJsonTests