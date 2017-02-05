# How fast does it quicksort?

I created this because I wanted to test the performance of the canonical
in-place quicksort implementation in Haskell. I wrote equivalent Rust and Python
implementations for reference.

Results (8000 elements):

| Language | Time |
| --- | --- |
| Rust | 0.035s |
| Haskell | 1.4s |
| Python | 9.5s |