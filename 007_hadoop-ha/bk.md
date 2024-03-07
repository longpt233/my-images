
```
sync-config:
	# @docker exec --workdir /storage datanode1_name bash -c "mkdir -p /etc/krb5kdc"
	@docker datanode1_name bash -c "echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDH21d4cu32i7EIKut9zcgrov5PiZfKATWdkrOUPSb9CbbaNjVKs/pntDMZuycwIDoIwVxmzyhUNx5tuflwRHUwwDaLEYv17AaIYTnZtL+IN4G1BAnFqqNTBVnrEVzjQqh+AVsI/G8fvUz56zM+N3Zonpz3o4C9KcHXHlMDFwu/yxiaH57QmL0+t2Unly3nOhjwqsZR1JFy+d71jYcWzadEgenjDX9AU4xgVGJDFgwBJ+eR3L31QmBd9A/uTylhXikn0oYVce1vFOx7VyTjD3Qxrwo74ABi9tE8ThRKy+LNsc79qYFHJobz7GUM3MWTvxlQzY3kZYtS2v2wFBiQzDGP long@Long-Laptop" > .ssh/authorized_keys && \"
	@docker cp ./conf/kdc/krb5.conf datanode1_name:/etc/krb5.conf
	@docker cp ./conf/kdc/kdc.conf datanode1_name:/etc/krb5kdc/kdc.conf 
	@docker exec namenode_name bash -c "
# Add Kerberos KDC hostname 
echo $'
##
# Kerberos KDC
##
172.25.0.2	cluster-172-25-0-2 \n
172.25.0.3	cluster-172-25-0-3 \n
172.25.0.4	cluster-172-25-0-4 \n
' >> /etc/hosts
";

	@docker exec datanode1_name bash -c "
# Add Kerberos KDC hostname 
echo $'
##
# Kerberos KDC
##
172.25.0.2	cluster-172-25-0-2 \n
172.25.0.3	cluster-172-25-0-3 \n
172.25.0.4	cluster-172-25-0-4 \n
' >> /etc/hosts
";

	@docker exec datanode2_name bash -c "
# Add Kerberos KDC hostname 
echo $'
##
# Kerberos KDC
##
172.25.0.2	cluster-172-25-0-2 \n
172.25.0.3	cluster-172-25-0-3 \n
172.25.0.4	cluster-172-25-0-4 \n
' >> /etc/hosts
";

```