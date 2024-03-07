#! /bin/bash

# Add Kerberos KDC hostname
echo $'
##
# Kerberos KDC
##
172.25.0.2	cluster-172-25-0-2
172.25.0.3	cluster-172-25-0-3
172.25.0.4	cluster-172-25-0-4
172.25.0.3  longpt.kdc
' >> /etc/hosts

# mkdir /etc/sudoers.d . nếu k có file này tức là chưa cài sudo package
echo longpt ALL=NOPASSWD:ALL | tee -a  /etc/sudoers.d/longpt

su - longpt -c $'\
          whoami && \
          mkdir .ssh && \
          echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDH21d4cu32i7EIKut9zcgrov5PiZfKATWdkrOUPSb9CbbaNjVKs/pntDMZuycwIDoIwVxmzyhUNx5tuflwRHUwwDaLEYv17AaIYTnZtL+IN4G1BAnFqqNTBVnrEVzjQqh+AVsI/G8fvUz56zM+N3Zonpz3o4C9KcHXHlMDFwu/yxiaH57QmL0+t2Unly3nOhjwqsZR1JFy+d71jYcWzadEgenjDX9AU4xgVGJDFgwBJ+eR3L31QmBd9A/uTylhXikn0oYVce1vFOx7VyTjD3Qxrwo74ABi9tE8ThRKy+LNsc79qYFHJobz7GUM3MWTvxlQzY3kZYtS2v2wFBiQzDGP long@Long-Laptop" > .ssh/authorized_keys && \
          chmod 700 .ssh && \
          chmod 600 .ssh/authorized_keys && \
          file_path=".ssh/authorized_keys" && \
          echo "cat file $file_path after make change" && \
          cat $file_path '

service ssh start
tail -f /dev/null 