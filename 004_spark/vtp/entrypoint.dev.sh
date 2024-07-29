echo $'
##
# vtp proxy
##
Acquire::http::proxy "http://110.60.x.x:8080/";
Acquire::https::proxy "http://110.60.x.x:8080/";
Acquire::ftp::proxy "http://110.60.x.x:8080/";
' >> /etc/apt/apt.conf
