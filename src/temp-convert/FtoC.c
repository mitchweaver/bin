/*
 * http://github.com/mitchweaver
 *
 * convert fahrenheit to celsius
 */

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("%.1f\n", (atof(argv[1]) - 32) * 0.5555);
    return 0;
}
