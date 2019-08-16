module Gamebook.Player
()
where

-- Not sure how to do this yet

-- findChoices :: SectionNumber -> [Choice] -> [Choice]
-- findChoices n = filter (\x -> (source x) == n)

-- findSection :: SectionNumber -> [Section] -> Maybe Section
-- findSection n = find (\x -> (sectionNumber x) == n) 

-- formatChoice :: Choice -> String
-- formatChoice c = (choiceText c) ++ " - " ++ show (destination c)

-- displayChoices :: [Choice] -> String
-- displayChoices = intercalate "\n" . map formatChoice

-- displaySection :: Maybe Section -> [Choice] -> String
-- displaySection Nothing _ = ""
-- displaySection (Just s) xs = sectionText s ++ "\n" ++ displayChoices (findChoices (sectionNumber s) xs) 

-- play :: [Section] -> [Choice] -> SectionNumber -> IO()
-- play sections choices n = putStr $ displaySection (findSection n sections) choices ++ "\n"
