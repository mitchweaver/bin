/* ----------------------------------------------------- */
// http://github.com/mitchweaver/bin
// alert after given minutes
/* ----------------------------------------------------- */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {

    // if no minute argument provided, exit
    if ( argc < 2 ) {
        printf("no argument provided\n");
        return 1;
    }

    const int goal_mins = atoi(argv[1]);
    const int goal_secs = goal_mins * 60;

    int count = 0;

    while ( count < goal_secs ) {

        count++;

        int secs_remaining = goal_secs - count;
        int mins_remaining = secs_remaining / 60;
        secs_remaining = secs_remaining % 60;

        // clear the screen after each print
        printf("\033c");

        if( mins_remaining > 0 ) 
            printf("%d minutes, %d seconds remaining\n", mins_remaining, secs_remaining);
        else
            printf("%d seconds remaining\n", secs_remaining);

        sleep(1);

    }   

    // print time-up message, flash the terminal, and run notify-send

    printf("--------------------------\n       Time is up!      \n--------------------------\n");

    char buffer[50];
    snprintf(buffer, sizeof(buffer), "notify-send -u critical 'Your %d minutes are up!'", goal_mins);
    system(buffer);

    // note: fix this, for whatever reason can't get printf() from C to work
    //       with this escape code
    system("printf \"\033[?5h\"");
    sleep(1);
    system("printf \"\033[?5l\"");

    return 0;

}
