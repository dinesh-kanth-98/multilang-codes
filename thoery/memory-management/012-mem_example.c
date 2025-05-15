#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    int *ptr = malloc(sizeof(int));
    *ptr = 42;
    printf("PID: %d\n", getpid());
    printf("Virtual address of ptr: %p\n", (void*)ptr);
    getchar(); // Wait for user input to keep the process running
    free(ptr);
    return 0;
}

