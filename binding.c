#include <stdio.h>
#include <string.h>
//#include "slre.h"
#include "slre.c" //not bad

typedef struct return_value {
    int ok;
    char error;
    struct slre_cap *val;
} RETVAL;

RETVAL greet (char *string,char *regex, int *num){

    const char *error_msg,
    *request = string;
    int n = (int)num;

    struct slre_cap caps[n];
    RETVAL ret;
    ret.ok = slre_match(regex, request, strlen(request), caps, &error_msg);
    ret.val = caps;
    if (ret.ok) {
        ret.val = caps;
    }
    return ret;
}
