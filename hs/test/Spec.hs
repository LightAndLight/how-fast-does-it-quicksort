module Main where

import           Lib

main :: IO ()
main = print $ quicksort [1..8000]
