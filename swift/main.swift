import Foundation
func quicksort(array: inout [Int], low: Int, high: Int) {
    if low < high {
        let p = partition(array: &array, low: low, high: high)
        quicksort(array: &array, low: low, high: p-1)
        quicksort(array: &array, low: p + 1, high: high)
    }
}

func partition(array: inout [Int], low: Int, high: Int) -> Int {
    let pivot = array[high]
    var i = low
    for index in low...high-1 {
        if array[index] <= pivot {
            (array[index],array[i]) = (array[i],array[index])
            i += 1
        }
    }
    (array[high],array[i]) = (array[i],array[high])
    return i
}

func quicksort(array: inout [Int]) {
    quicksort(array: &array, low: 0, high: array.count-1)
}

func benchmark(count: Int) {
    var array = [Int]()
    array += 1...count
    let start = Date()
    quicksort(array: &array)
    let end = Date()
    let interval = end.timeIntervalSince(start)
    print("Benchmark time for " + String(count) + " items: " + String(Double(interval)))
}
benchmark(count: 1000)
benchmark(count: 2000)
benchmark(count: 4000)
benchmark(count: 8000)
