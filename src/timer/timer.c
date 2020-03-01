/* 
 * http://github.com/mitchweaver/bin
 *
 * countdown timer
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <minutes>\n", argv[0]);
        return 1;
    }

    const int goal = atoi(argv[1]) * 60;

    for(int c = 0 ; c < goal ; c++) {
        int secs = goal - c;
        int mins = secs / 60;
        secs = secs % 60;

        // ensure '00:00' time format
        if(mins < 10)
            printf("%d", 0);

        printf("%d:", mins);

        // ensure '00:00' time format
        if(secs < 10)
            printf("%d", 0);

        printf("%d\n", secs);
        fflush(stdout);

        sleep(1);
    }   

    return 0;
}
