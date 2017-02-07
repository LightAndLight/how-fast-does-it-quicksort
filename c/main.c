#include <stdio.h>
#include <time.h>
#include <stdlib.h>

struct data {
    int size;
    int *array;
};

int partition(int *a, int l, int r);
void quicksort(struct data *a);
void qs(int *a, int l, int r);
void bench(int size);

int partition(int *a, int l, int r) {
    int i, j, p, t;
    p = a[r];
    i = l - 1;
    
    for(j =l; j <= r-1; j++) {
        if(a[j] <= p) {
            i++;
            t = a[j];
            a[j] = a[i];
            a[i] = t;
        }
    }
    
    t = a[i+1];
    a[i+1] = a[r];
    a[r] = t;
    return i+1;
}

void quicksort(struct data *a) {
    qs(a->array, 0, a->size);
}

void qs(int *a, int l, int r) {
    if (l < r) {
        int p = partition(a, l, r);
        qs(a, l, p-1);
        qs(a, p+1, r);
    }
}

void bench(int size) {
    struct data data;
    int a[size];
    for(int i = 0; i < size; i++) {
        a[i] = i;
    }
    data.size = size;
    data.array = a;
    clock_t begin = clock();
    quicksort(&data);
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Sorted %d elements in %fms\n", size, time_spent*1000);
}

int main() {
    bench(1000);
    bench(2000);
    bench(4000);
    bench(8000);
    return 0;
}
