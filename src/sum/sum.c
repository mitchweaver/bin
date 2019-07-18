/*
 * http://github.com/mitchweaver/bin
 * sum up piped input
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char buf[20]; 
    char *input = 0;
    size_t cur_len = 0;
    while(fgets(buf, sizeof(buf), stdin) != '\0') {
        size_t buf_len = strlen(buf);
        char *extra = realloc(input, buf_len + cur_len + 1);
        if (extra == 0) break;
        input = extra;
        strcpy(input + cur_len, buf);
        cur_len += buf_len;
    }
    input[strcspn(input, "\n")] = 0;

    float total = 0;
    char *num;
    while ((num = strsep(&input, " ")))
        total += atof(num);
    
    printf("%g\n", total);
    return 0;
}
