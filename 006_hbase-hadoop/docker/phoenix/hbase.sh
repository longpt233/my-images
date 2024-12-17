long@hello:~$ docker exec -it dragonhbase bash
root@hadoop113:/# $HBASE_HOME/bin/hbase shell
2024-12-16 10:45:40,988 WARN  [main] util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
HBase Shell
Use "help" to get list of supported commands.
Use "exit" to quit this interactive shell.
For Reference, please visit: http://hbase.apache.org/2.0/book.html#shell
Version 2.4.17, r7fd096f39b4284da9a71da3ce67c48d259ffa79a, Fri Mar 31 18:10:45 UTC 2023
Took 0.0008 seconds                                                                                                                                                                           
hbase:001:0> scan 'testspark';
ROW                                              COLUMN+CELL                                                                                                                                  
 2                                               column=cf:city, timestamp=2024-12-16T10:43:34.231, value=Telangana                                                                           
 2                                               column=cf:name, timestamp=2024-12-16T10:43:34.231, value=Chhetri                                                                             
 3                                               column=cf:city, timestamp=2024-12-16T10:43:34.231, value=Sikkim                                                                              
 3                                               column=cf:name, timestamp=2024-12-16T10:43:34.231, value=Bhutia                                                                              
 4                                               column=cf:city, timestamp=2024-12-16T10:43:34.231, value=Hyderabad                                                                           
 4                                               column=cf:name, timestamp=2024-12-16T10:43:34.231, value=Shabbir                                                                             
 5                                               column=cf:city, timestamp=2024-12-16T10:43:34.231, value=Kerala                                                                              
 5                                               column=cf:name, timestamp=2024-12-16T10:43:34.231, value=Vijayan                                                                             
 6                                               column=cf:city, timestamp=2024-12-16T10:43:34.231, value=Mizoram                                                                             
 6                                               column=cf:name, timestamp=2024-12-16T10:43:34.231, value=Lalpekhlua                                                                          
5 row(s)
Took 0.2823 seconds                                                                                                                                                                           
hbase:002:0> 

