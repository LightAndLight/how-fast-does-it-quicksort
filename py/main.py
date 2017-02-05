import time

def quicksort(a):
    qs(a, 0, len(a) - 1)

def partition(a, lo, hi):
    pivot = a[hi]
    i = lo
    for j in range(lo, hi):
        a_j = a[j]
        if a_j <= pivot:
            a[j] = a[i]
            a[i] = a_j
            i += 1
    a_i = a[i]
    a[i] = a[hi]
    a[hi] = a_i
    return i

def qs(a, lo, hi):
    stack = []
    stack.append(lo)
    stack.append(hi)

    while stack:
        hi = stack.pop()
        lo = stack.pop()

        if lo < hi:
            p = partition(a, lo, hi)
            stack.append(p + 1)
            stack.append(hi)

            stack.append(lo)
            stack.append(p - 1)

def bench_n(n):
    a = [x for x in range(n)]
    start = time.time()
    quicksort(a)
    end = time.time()
    delta = end - start
    print('Sorted {} elements in {}s'.format(n, delta))

if __name__ == '__main__':
    bench_n(1000)
    bench_n(2000)
    bench_n(4000)
    bench_n(8000)
