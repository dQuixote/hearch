A primitive search engine written in Haskell.

TODO
  * finish writing `storeFreqMap`!
  * ~~limit crawling to single domain~~
  * make sure crawler never visits same page twice
  * complete haddock documentation
  * ~~implement word ignore in crawler's processing functions~~
  * implement `AND`, `OR` operators for search
  * make ranking less naive

## Usage

Run `setupDB.bash` once before doing anything to create the SQLite database.

    $ cabal install --only-dependencies --enable tests
    $ cabal configure --enable-tests
    $ cabal build

    $ cabal run

    $ cabal test

## Modules

#### Crawler.hs

The web crawler. It restricts itself to browsing
[stackoverflow.com/questions](stackoverflow.com/questions). Applicable URLs
from [stackoverflow.com/robots.txt](stackoverflow.com/robots.txt) are
hard-coded into the crawler.

#### Database.hs

~~Manages the Redis database (using `hedis`).~~

Functions for storing and retrieving word/page-frequency entries from the
SQL database.

#### Search.hs

Will contain search algorithms.

#### Rank.hs

Will contain ranking algorithms.

## Data

#### Database

Hearch uses SQLite for storing word/page-frequency entries generated by the
crawler. The columns of the table are

    word  |  page  | frequency

where `word` occurred on `page`, `frequency` number of times.


#### URL File

`data/urls.txt` stores a list of URLs to crawl. As the crawler finds new
hyperlinks in a page, it appends them to the file. When it begins processing
a page, it removes that page's URL from the file.

#### Crawled File

`data/crawled.txt` stores a list of URLs which have already been crawled.
The crawler appends URLs to this file immediately after it finishes
processessing them.

#### Ignore File

`data/ignore.txt` stores a list of words to ignore when counting word
frequency for a page.
