module Main where

import           Criterion.Main
import qualified Data.Vector    as V
import           Lib

main = defaultMain
    [ bench "quicksort - sorted - 1..1000" $ nf quicksort (V.fromList [1..1000] :: V.Vector Int)
    , bench "quicksort - sorted - 1..2000" $ nf quicksort (V.fromList [1..2000] :: V.Vector Int)
    , bench "quicksort - sorted - 1..4000" $ nf quicksort (V.fromList [1..4000] :: V.Vector Int)
    , bench "quicksort - sorted - 1..8000" $ nf quicksort (V.fromList [1..8000] :: V.Vector Int)
    ]
