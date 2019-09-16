module Format.DotSpec(
    spec
  ) where
  
import Test.Tasty.Hspec
import Gamebook.Format.Dot
import Gamebook.Book
import Gamebook.Section
import Gamebook.Choice

spec :: Spec
spec = do
    describe "Tests the dot formatter" $ do

        context "When the book has no sections or choices" $ do
            it "Should return a plain dot file" $ do
                toDot (Book [] []) `shouldBe` "digraph {\n    graph [rankdir=LR\n          ,bgcolor=white];\n    node [shape=box\n         ,fillcolor=\"#afb170\"\n         ,style=filled];\n}"

        context "When the book has sections and choices" $ do
            it "Should return a dot file with the correct sections and choices" $ do
                toDot (Book [(Section 1 "This is section 1."), (Section 2 "This is section 2.")] 
                             [(Choice 1 2), (Choice 2 1)]) `shouldBe` 
                             "digraph {\n    graph [rankdir=LR\n          ,bgcolor=white];\n    node [shape=box\n         ,fillcolor=\"#afb170\"\n         ,style=filled];\n    1 [label=1];\n    2 [label=2];\n    1 -> 2;\n    2 -> 1;\n}"