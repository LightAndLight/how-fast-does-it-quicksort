module Lib where

import           Control.Applicative
import           Control.Monad
import           Control.Monad.ST
import           Data.Foldable
import           Data.IORef
import           Data.STRef
import           Data.Traversable
import           Data.Vector         (Vector)
import qualified Data.Vector         as V
import           Data.Vector.Mutable (IOVector, STVector)
import qualified Data.Vector.Mutable as M

quicksort :: Ord a => Vector a -> Vector a
quicksort input = runST $ do
  vect <- V.thaw input
  quicksort' vect 0 (V.length input - 1)
  V.freeze vect
  where
    quicksort' :: Ord a => STVector s a -> Int -> Int -> ST s ()
    quicksort' a lo hi = when (lo < hi) $ do
      p <- partition a lo hi
      quicksort' a lo (p-1)
      quicksort' a (p+1) hi
    partition :: Ord a => STVector s a -> Int -> Int -> ST s Int
    partition a lo hi = do
      pivot <- M.read a hi
      i <- newSTRef lo
      for [lo..hi-1] $ \j -> do
        a_j <- M.read a j
        when (a_j <= pivot) $ do
          i_value <- readSTRef i
          M.write a j =<< M.read a i_value
          M.write a i_value a_j
          modifySTRef i (+1)
      a_i <- M.read a =<< readSTRef i
      i_value <- readSTRef i
      M.write a i_value =<< M.read a hi
      M.write a hi a_i
      pure i_value

quicksortF :: Ord a => Vector a -> Vector a
quicksortF input
  | V.null input = input
  | otherwise
    = let initInput = V.init input
          lastInput = V.last input
      in quicksortF (V.filter (<= lastInput) initInput) V.++ V.cons lastInput (quicksortF $ V.filter (> lastInput) initInput)
