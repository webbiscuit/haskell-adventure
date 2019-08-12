import Test.Tasty
import Test.Tasty.Hspec

main :: IO ()
main = do
  tree <- testSpec "Gamebook Tests" gamebookTestSuite
  defaultMain tree

gamebookTestSuite :: Spec
gamebookTestSuite = do
  basicTests

basicTests :: SpecWith()
basicTests = do
  describe "Tests of one thing" $
    context "When the numbers are small" $
      it "5 == 5" $
      5 `shouldBe` (5 :: Int)

