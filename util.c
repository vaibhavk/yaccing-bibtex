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
    printf("\\usepackage{cite}\n");
    printf("%cbibtype{%s}\n",'\\', entry.name);

    for (int i = 0; fields[i] != NULL; ++i) {
        for (int j = 0; j < size; ++j) {
            if (strcmp(fields[i], entry.fields[j].name) == 0) {
                value = entry.fields[j].value;
                break;
            } else {
                value = null;
            }
        }
        if(strcmp(value,null))
            printf("%c%s{ %s }\n",'\\',fields[i], value);
    }
    printf("%ccite{%s}\n",'\\',entry.key);
    printf("\n");
}
