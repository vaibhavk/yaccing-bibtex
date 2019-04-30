#ifndef TYPES_H
#define TYPES_H

#define MAX_SIZE 100
#define MAX_FIELDS 20

struct _Field{
    char        name[MAX_SIZE];
    char        value[MAX_SIZE];
};
typedef struct _Field Field;

struct _Entry{
    char        *name;
    char        *key;
    int         size;
    Field       fields[MAX_FIELDS];
};
typedef struct _Entry Entry;

#endif /* end of include guard: TYPES_H */
