#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Not really tied to GCC version but allows picking correct header on my system
#include <features.h>
#if __GNUC_PREREQ(4,8)
#include <db.h>
#else
#include <db4/db.h>
#endif

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))
//(.DG matches .SV)
//(.BN/.BH/.HN for handlers, add set device/ for build)

struct {
   char *ext;
   char *extra_ext;
   char *extra_txt;
   int dup_ok;
   int add_short;
} ext_map[] = {
   { "DG", "DG", "", 0, 1},
   { "DG", "SV", "", 1, 1},
   { "DG", "BX", "", 1, 1},
   { "DG", "BN", "", 1, 1},
   { "DG", "", "", 1, 1},
   { "HN", "HN", " for set handler", 0, 0},
   { "HN", "BN", " for build", 0, 0},
   { "HN", "BH", " for build", 0, 0}
};

void add_key(char *keystr, char *valstr, DB *db,int dup_ok) {
   DBT key, data;
   int rc;

//if (strncmp(keystr,"8ID5D",5) == 0)
//   printf("Found %s\n",keystr);
   memset(&key, 0, sizeof(key));
   memset(&data, 0, sizeof(data));
   key.data = keystr;
   data.data = valstr;
   key.size = strlen(key.data);
   data.size = strlen(data.data);
   if ((rc = db->put(db, NULL, &key, &data, DB_NOOVERWRITE)) != 0) {
      if (dup_ok) 
         ;//printf("ok duplicate key %s data %s\n",key.data, data.data);
      else {
         db->err(db, rc, "put failed key %s data %s\n   ", key.data, data.data);
         exit(1);
      }
   }
}

#if 0
struct {
   char *src;
   char *dest;
} path_map[] = {
   {"{games}", "/games/"};
#endif

int main()
{
   DB *db;
   int rc;
   char *value;
   char line[256];
   int len;
   char *ext;
   int cntr;

   if ((rc = db_create(&db, NULL, 0)) != 0) {
      perror("db_create failed");
      exit(1);
   }

   if ((rc = db->open(db, NULL, "filenames.db", NULL, DB_HASH, 
         DB_CREATE | DB_TRUNCATE, 0666)) != 0) {
      db->err(db, rc, "Open failed");
      exit(1);
   }

   while (fgets(line, sizeof(line), stdin) != NULL) {
      value = strchr(line,'^');
      len = strlen(line)-1;
      if (line[len] == '\n')
         line[len] = 0;
      if (value == NULL) {
         printf("Bad line %s\n",line);
         exit(1);
      }
      *value = 0;
      value++;
      ext = strrchr(line, '.');
      if (ext == NULL) {
         add_key(line, value, db, 0);
      } else {
         int found_map = 0;
         char base[7];
         strncpy(base, line, 6);
         base[ext - line] = 0;

         ext++;
         if (strcmp(ext,"DG") == 0 && value[strlen(value)-1] == '^') {
            char new_fn[30];
            //strcat(value, "/pdp8cgi/search_docs.pl?name=");
            //strcat(value, line);
            strcat(value, "/pdp8cgi/query_docs/query.pl?Search=");
            strcpy(new_fn, base);
            new_fn[5] = 0;  // remove version if present
            strcat(value, new_fn);
            strcat(value, ";stype=Partial+Word;dtype=Document+Sets;sp=1");
         }
         for (cntr = 0; cntr < ARRAYSIZE(ext_map); cntr++) {
            if (strcmp(ext, ext_map[cntr].ext) == 0) {
               char new_fn[30];
               char new_line[256];
               found_map = 1;
               strcpy(new_fn, base);
               strcat(new_fn, ".");
               strcat(new_fn, ext_map[cntr].extra_ext);
               strcpy(new_line, value); 
               strcat(new_line,ext_map[cntr].extra_txt);
               add_key(new_fn, new_line, db, ext_map[cntr].dup_ok);
               if (ext_map[cntr].add_short && (ext - line) == 7 &&
                     (line[0] == '1' || line[0] == '8' || line[0] == 'A' || 
                     line[0] == 'D')) {
                  strcpy(new_fn, line);
                  new_fn[ext-line - 2] = '.';
                  strcpy(new_fn + (ext - line) - 1, ext_map[cntr].extra_ext);
                  add_key(new_fn, new_line, db, 1);
               }
            } 
         }
         if (!found_map)
            add_key(line, value, db, 0);
         if (strcmp(ext,"SV") == 0) {
            add_key(base, value, db, 1);
         }
      }
//printf("key %s\n",key.data);
   }
   db->close(db, 0);
}
