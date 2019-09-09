module Format.JsonSpec(
    spec
  ) where
  
import Test.Tasty.Hspec
import Gamebook.Format.Json
import Gamebook.Book
import Gamebook.Section
import Gamebook.Choice

spec :: Spec
spec = do
    describe "Tests the JSON formatter" $ do

        context "When the book has no sections or choices" $ do
            it "Should return a JSON string with empty lists" $ do
                toJson (Book [] []) `shouldBe` "{\"sections\":[],\"choices\":[]}"

        context "When the book has sections and choices" $ do
            it "Should return a JSON string the correct sections and choices linked" $ do
                toJson (Book [(Section 1 "This is section 1."), (Section 2 "This is section 2.")] 
                             [(Choice 1 2), (Choice 2 1)]) `shouldBe` 
                             "{\"sections\":[{\"sectionNumber\":1,\"sectionText\":\"This is section 1.\"},{\"sectionNumber\":2,\"sectionText\":\"This is section 2.\"}],\"choices\":[{\"source\":1,\"destination\":2},{\"source\":2,\"destination\":1}]}"