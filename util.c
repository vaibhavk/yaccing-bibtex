#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "types.h"

char *fields[] = {
    "address",
    "author",
    "booktitle",
    "chapter",
    "edition",
    "journal",
    "number",
    "pages",
    "publisher",
    "school",
    "title",
    "volume",
    "year",
    NULL
};

void entry_show(Entry entry)
{
    int size = entry.size;
    char *value = NULL;
    char *null = "NULL";

    printf("\n");
    printf("bibtype\t: %s\n", entry.name);
    printf("bibkey\t: %s\n", entry.key);

    for (int i = 0; fields[i] != NULL; ++i) {
        for (int j = 0; j < size; ++j) {
            if (strcmp(fields[i], entry.fields[j].name) == 0) {
                value = entry.fields[j].value;
                break;
            } else {
                value = null;
            }
        }
        printf("%s\t: %s\n", fields[i], value);
    }
    printf("\n");
}
