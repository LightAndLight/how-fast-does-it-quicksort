module Main where

import           Control.DeepSeq
import           Control.Exception
import           Criterion.Main
import qualified Data.Vector       as V
import           Lib
import           System.Random

main = do
  gen <- getStdGen
  input <- evaluate $ force $ take 1000000 $ randomRs (-1000000, 1000000) gen
  defaultMain
    [ bgroup "quicksort"
      [ bench "sorted - 1..1000" $ nf quicksort (V.fromList [1..1000] :: V.Vector Int)
      , bench "sorted - 1..2000" $ nf quicksort (V.fromList [1..2000] :: V.Vector Int)
      , bench "sorted - 1..4000" $ nf quicksort (V.fromList [1..4000] :: V.Vector Int)
      , bench "sorted - 1..8000" $ nf quicksort (V.fromList [1..8000] :: V.Vector Int)
      , bench "random - 1..1000000" $ nf quicksort (V.fromList input :: V.Vector Int)
      ]
    , bgroup "quicksort2"
      [ bench "sorted - 1..1000" $ nf quicksort2 (V.fromList [1..1000] :: V.Vector Int)
      , bench "sorted - 1..2000" $ nf quicksort2 (V.fromList [1..2000] :: V.Vector Int)
      , bench "sorted - 1..4000" $ nf quicksort2 (V.fromList [1..4000] :: V.Vector Int)
      , bench "sorted - 1..8000" $ nf quicksort2 (V.fromList [1..8000] :: V.Vector Int)
      , bench "random - 1..1000000" $ nf quicksort2 (V.fromList input :: V.Vector Int)
      ]
    ]
