/* ----------------------------------------------------- */ 
// http://github.com/mitchweaver/bin
// average given input
/* ----------------------------------------------------- */ 

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    switch(argc) {
        case 1: exit(1);
        case 2: printf("%d\n", atoi(argv[1]));
                exit(0);
    }

    float total=0;
    int i=1;
    for ( i=1 ; i < argc ; i++ )
        total += atof(argv[i]);
    
    printf("%.*g\n", total / ( argc - 1 ) );

    return 0;
}
