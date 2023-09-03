#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <db.h>

void main()
{
   DB *db;
   int rc;
   DBT key, data;

   if ((rc = db_create(&db, NULL, 0)) != 0) {
      perror("db_create failed");
      exit(1);
   }

   if ((rc = db->open(db, NULL, "test.db", NULL, DB_HASH, 0, 0666)) != 0) {
      db->err(db, rc, "Open failed");
      exit(1);
   }

   
   memset(&key, 0, sizeof(key));
   memset(&data, 0, sizeof(data));
   key.data = "PIP.SV";
   key.size = strlen(key.data);
   if ((rc = db->get(db, NULL, &key, &data, 0)) != 0) {
      db->err(db, rc, "get failed key %s", key.data);
      exit(1);
   }
   printf("got %s len %d\n",data.data, data.size);
   db->close(db, 0);
}
