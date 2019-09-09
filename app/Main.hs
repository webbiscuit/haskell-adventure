module Main where

import Gamebook.Parser
import Gamebook.Format.Json
import Gamebook.Format.Dot
import Gamebook.Book
import Options.Applicative
import Data.Semigroup ((<>))
import qualified Data.Text as T
import qualified Data.Text.IO as T

data Options = Options
    { source     :: Input
    , output     :: String }

data Input
    = FileInput FilePath
    | StdInput

fileInput :: Parser Input
fileInput = FileInput <$> strOption
    (  long "file"
    <> short 'f'
    <> metavar "FILENAME"
    <> help "Input file" )

stdInput :: Parser Input
stdInput = flag' StdInput
    (  long "stdin"
    <> help "Read from stdin" )

input :: Parser Input
input = fileInput <|> stdInput

options :: Parser Options
options = Options
    <$> input
    <*> strOption
        ( long "output"
        <> short 'o'
        <> help "Output type. Supported: debug,json,dot"
        <> showDefault
        <> value "debug"
        <> metavar "OUTPUT_TYPE" )
  
main :: IO ()
main = handleOptions =<< execParser opts
    where
    opts = info (options <**> helper)
        ( fullDesc
        <> progDesc "Parses gamebooks to the specified output"
        <> header "Haskell Adventure" )

handleOptions :: Options -> IO ()
handleOptions (Options (FileInput f) o) = readFile f >>= T.putStrLn . toOutput o . parseTextIntoBook
handleOptions (Options StdInput o) = getContents >>= T.putStrLn . toOutput o . parseTextIntoBook

toOutput :: String -> Book -> T.Text
toOutput "json" = toJson
toOutput "dot" = toDot
toOutput _ = T.pack . show
