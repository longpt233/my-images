


keytab:
	@docker cp  dragonsecure:/hdfs.keytab ./hdfs.keytab
	@docker cp ./hdfs.keytab dragonstag1:/
	@docker exec dragonstag1 bash -c "chmod 777 /hdfs.keytab"
	@docker exec dragonstag1 bash -c "chown hadoop. /hdfs.keytab"

	@docker cp ./hdfs.keytab dragonstag2:/
	@docker exec dragonstag2 bash -c "chmod 777 /hdfs.keytab"
	@docker exec dragonstag2 bash -c "chown hadoop. /hdfs.keytab"

	@docker cp ./hdfs.keytab dragonstag3:/
	@docker exec dragonstag3 bash -c "chmod 777 /hdfs.keytab"
	@docker exec dragonstag3 bash -c "chown hadoop. /hdfs.keytab"

	@docker cp  dragonsecure:/nifi.keytab ./nifi.keytab
	@docker cp ./nifi.keytab dragonstag3:/
	@docker exec dragonstag3 bash -c "chmod 777 /nifi.keytab"
	@docker exec dragonstag3 bash -c "chown hadoop. /nifi.keytab"

	@docker cp ./nifi.keytab dragonstag2:/
	@docker exec dragonstag2 bash -c "chmod 777 /nifi.keytab"
	@docker exec dragonstag2 bash -c "chown hadoop. /nifi.keytab"

	@docker cp ./nifi.keytab dragonstag1:/
	@docker exec dragonstag1 bash -c "chmod 777 /nifi.keytab"
	@docker exec dragonstag1 bash -c "chown hadoop. /nifi.keytab"