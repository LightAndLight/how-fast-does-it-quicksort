# How fast does it QuickSort?

I created this because I wanted to test the performance of the canonical
in-place quicksort implementation in Haskell. I wrote equivalent Rust and Python
implementations for reference.

Results (8000 elements, already sorted, run on Surface Pro 3 with 64-bit Windows):

| Language | Time |
| --- | --- |
| C | 0.018s |
| Rust | 0.035s |
| Swift | 0.041s |
| Haskell | 1.4s |
| PHP 7.0 | 2.8s |
| Python | 9.5s |

# Want to contribute?

Implement [this](https://en.wikipedia.org/wiki/Quicksort#Lomuto_partition_scheme)
version of QuickSort in your desired language, and some form of benchmarking
for collections of 1000, 2000, 4000 and 8000 elements (already sorted - this
is the worst case of the algorithm :) ). Then submit a PR!
