#include <sys/time.h>
#include <stdint.h>
#include <stdio.h>

static double get_time() {
    struct timeval tv;
    gettimeofday(&tv, 0);
    return tv.tv_sec + (double) tv.tv_usec * 1e-6;
}

void __attribute__ ((noinline)) noop() {
    asm volatile("":::);
}

int main() {
    double t = get_time();
    int64_t num = 0;
    for (num = 0; num < 1e9; num++) {
       noop();
    }
    double t2 = get_time();
    printf("%f ns per function call\n", (t2 - t) / 1.0e9 * 1.0e9);
    return 0;
}
