# logstash-various
Logstash various stuff

##scripts folder
Scripts to collect multiline logs from specific folder and pass it to logstash local tcp input on port 5544.

1. collects zip files
2. upack certain files by pattern to zip's folder
3. delete zip files
4. collect log files by pattern - this is just next check, i.e. you will unpuck by yourself and try to run this script on folder.
5. pick next file
6. calc sha256 of the file
7. check if file is in db (defalt db is in ~/.filesenddb)
8. if it is - goto 5.
9. merge lines by pattern (line that doesn't start with date merged to previous)
10. send to localhost:5544
11. add file/hash to files db
12. delete log file




!Important

Please note all patterns are specifically created for my usage. For now, there is no plan to generalise this behaviour.



Regards,
