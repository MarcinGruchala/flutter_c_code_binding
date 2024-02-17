#include <stdio.h>
#include "hello.h"

int main() {
    const char *message = getHelloMessage();
    printf("%s\n", message);
    return 0;
}
