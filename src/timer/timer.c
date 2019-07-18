/* 
 * http://github.com/mitchweaver/bin
 * countdown timer - alert after given minutes
 *
 * dependencies: toilet, libnotify
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("no argument provided\n");
        return 1;
    }

    const int goal_mins = atoi(argv[1]);
    const int goal_secs = goal_mins * 60;

    for(int count = 0 ; count < goal_secs ; count++) {
        int secs = goal_secs - count;
        int mins = secs / 60;
        secs = secs % 60;

        char buffer[80] = "toilet -t -f mono9 --metal '";

        // ensure '00:00' time format
        if(mins < 10)
            sprintf(buffer, "%s0", buffer);

        sprintf(buffer, "%s%d:", buffer, mins);

        // ensure '00:00' time format
        if(secs < 10)
            sprintf(buffer, "%s0", buffer);

        sprintf(buffer, "%s%d'", buffer, secs);

        system("clear");
        system(buffer);
        sleep(1);
    }   

    // flash the terminal
    printf("\033[?5h");
    sleep(1);
    printf("\033[?5l");

    // run notify-send
    char buffer[50];
    snprintf(buffer, sizeof(buffer), \
            "notify-send -u critical 'Your %d minutes are up!'", goal_mins);
    system(buffer);

    return 0;
}
