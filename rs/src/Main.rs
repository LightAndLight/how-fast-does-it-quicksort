extern crate time;

fn quicksort<T : PartialOrd + Copy>(input: &mut Vec<T>) {
    let hi = input.len();
    qs(input, 0, hi - 1);
}

fn qs<T : PartialOrd + Copy>(a: &mut Vec<T>, lo: usize, hi: usize) {
    let mut stack = Vec::new();
    stack.push(lo);
    stack.push(hi);
    loop {
        let opt_hi = stack.pop();
        match opt_hi {
            Some(hi) => {
                let opt_lo = stack.pop();
                match opt_lo {
                    Some(lo) => {
                        if lo < hi {
                            let p = partition(a, lo, hi);
                            stack.push(p + 1);
                            stack.push(hi);

                            let (res, overflowed) = p.overflowing_sub(1);
                            if !overflowed {
                                stack.push(lo);
                                stack.push(res);
                            }
                        }
                    },
                    None => break
                }
            },
            None => break
        }
    }
}

fn partition<T : PartialOrd + Copy>(a: &mut Vec<T>, lo: usize, hi: usize) -> usize {
    let pivot = a[hi];
    let mut i = lo;
    for j in lo..hi {
        let a_j = a[j];
        if a_j <= pivot {
            a[j] = a[i];
            a[i] = a_j;
            i += 1;
        }
    }
    let a_i = a[i];
    a[i] = a[hi];
    a[hi] = a_i;
    i
}

fn main() {
    bench_n(1000);
    bench_n(2000);
    bench_n(4000);
    bench_n(8000);
}

fn bench_n(n: i32) {
    let mut vec: Vec<i32> = Vec::with_capacity(1000);
    for i in 0..n {
        vec.push(i);
    }
    let start = time::precise_time_ns();
    quicksort(&mut vec);
    let end = time::precise_time_ns();
    let delta = end - start;
    let ns_to_ms = 1000000;
    let ns_to_us = 1000;
    if delta >= ns_to_ms {
        println!("Sorted {} elements in {}ms", n, delta / ns_to_ms);
    } else if delta >= ns_to_us {
        println!("Sorted {} elements in {}us", n, delta/ ns_to_us);
    } else {
        println!("Sorted {} elements in {}ns", n, delta);
    }
}
