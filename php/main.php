<?php

function partition(&$arr, $lo, $hi) {
    $pivot = $arr[$hi];
    $i = $lo;

    foreach (range($lo, $hi - 1) as $j) {
        $arr_j = $arr[$j];
        if ($arr_j <= $pivot) {
            $arr[$j] = $arr[$i];
            $arr[$i] = $arr_j;
            $i++;
        }
    }

    $arr_i = $arr[$i];
    $arr[$i] = $arr[$hi];
    $arr[$hi] = $arr_i;
    return $i;
}

function qs(&$arr, $lo, $hi) {
    $stack = array();
    array_push($stack, $lo, $hi);

    while (count($stack)) {
        $hi = array_pop($stack);
        $lo = array_pop($stack);

        if ($lo < $hi) {
            $p = partition($arr, $lo, $hi);
            array_push(
                $stack,
                $p + 1,
                $hi,
                $lo,
                $p - 1
            );
        }
    }
}


function quicksort(&$arr) {
    qs($arr, 0, count($arr) - 1);
}

function bench_n($n) {
    $arr = range(0, $n-1);
    $start = microtime(true);
    quicksort($arr);
    $end = microtime(true);
    $delta = $end - $start;
    echo sprintf("Sorted %d elements in %fs\n", $n, $delta);
}

bench_n(1000);
bench_n(2000);
bench_n(4000);
bench_n(8000);
