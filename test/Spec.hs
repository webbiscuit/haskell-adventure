import Test.Tasty
import Test.Tasty.Hspec

main :: IO ()
main = do
  tree <- testSpec "Gamebook tests" gamebookTestSuite
  defaultMain tree

gamebookTestSuite :: Spec
gamebookTestSuite = do
  basicTests

basicTests :: SpecWith()
basicTests = do
  describe "passing test" $
    it "5 == 5" $
      5 `shouldBe` (5 :: Int)

