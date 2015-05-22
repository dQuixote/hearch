-- module Crawler

{-
 - TODO: write module description
 -}

module Crawler where

import Control.Monad
import Network.HTTP
import Text.HTML.TagSoup

import Data.Set (Set)
import qualified Data.Set as Set

type URL = String

-- read file containing list of URLs to crawl
readURLFile :: FilePath -> IO [URL]
readURLFile = fmap lines . readFile

-- read file containing list of words to ignore into Set structure
readIgnoreFile :: FilePath -> IO (Set String)
readIgnoreFile = fmap (Set.fromList . lines) . readFile

-- request a page
httpRequest :: URL -> IO String
httpRequest = simpleHTTP . getRequest >=> getResponseBody

-- get the text content of a page (which is a single string);
-- acceptable content is extracted by validTags,
-- and filtered by validText
getWords :: String -> [String]
getWords = filter validText . map innerText . validTags . parseTags
  where
    validTags = sections (== TagOpen "p" [])
    -- TODO
    validText = \_ -> True
