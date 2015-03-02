# logstash-various
Logstash various stuff

##scripts
Scripts to collect multiline logs from specific folder and pass it to logstash local tcp input on port 5544.
1. collects zip files
2. upack certain files by pattern to zip's folder
3. delete zip files
4. merge lines by pattern (line that doesn't start with date merged to previous)
5. send to localhost:5544
6. delete log file


!Important
Please note all patterns are specifically created for my usage. For now, there is no plan to generalise this behaviour.



Regards,
