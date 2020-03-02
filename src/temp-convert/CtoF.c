/*
 * http://github.com/mitchweaver
 *
 * convert celsius to fahrenheit
 */

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("%.1f\n", ((atof(argv[1]) * 9)/5) + 32);
    return 0;
}
