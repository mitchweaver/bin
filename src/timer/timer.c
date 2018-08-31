/* ----------------------------------------------------- */
// http://github.com/mitchweaver/bin
// alert after given minutes
//
// dependencies: toilet, notify-send
/* ----------------------------------------------------- */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

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

        int secs_remaining = goal_secs - count;
        int mins_remaining = secs_remaining / 60;
        secs_remaining = secs_remaining % 60;

		char buffer[128] = "toilet -t -f mono9 --metal '";

        // ensure '00:00' time format
        if( mins_remaining < 10 )
			sprintf(buffer, "%s0", buffer);

		sprintf(buffer, "%s%d:", buffer, mins_remaining);

        // ensure '00:00' time format
        if( secs_remaining < 10 )
			sprintf(buffer, "%s0", buffer);

		sprintf(buffer, "%s%d'", buffer, secs_remaining);

        // clear the screen before each print
        system("printf \"\033c\"");

		system(buffer);

        sleep(1);

		count++;

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
