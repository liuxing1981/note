```
   30 1 * * * root mysqldump -u root -pPASSWORD --all-databases | gzip > /mnt/disk2/database_`date '+%m-%d-%Y'`.sql.gz
```

