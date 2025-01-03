gen-certs:
	@openssl genrsa -out ./nginx/certs/PrivateKey.key
	# tạo Certificate Signing Request (CSR). là một yêu cầu kí chứng chỉ được gửi tới một cơ quan
	# nó sẽ yêu cầu một số thông tin như Quốc gia (C=),Tên tổ chức (O=),Tên miền (CN=).
	@openssl req -new -key ./nginx/certs/PrivateKey.key -out ./nginx/certs/request.csr
	# đáng lẽ chỗ ./nginx/certs/PrivateKey.key là phải 1 bên thứ 3 kí, nhưng mà dev thì thế này thôi
	@openssl x509 -req -days 365 -in ./nginx/certs/request.csr -signkey ./nginx/certs/PrivateKey.key -out ./nginx/certs/PublicKey.crt
	@rm ./nginx/certs/request.csr

build: 
	@docker build -f ./spark-delta/Dockerfile -t longpt233/spark-delta:0.0.1 .

get-lib: 
	@cd ./spark-delta && wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.375/aws-java-sdk-bundle-1.11.375.jar
	@cd ./spark-delta && wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar 
	@cd ./spark-delta && wget https://repo1.maven.org/maven2/io/delta/delta-core_2.12/1.0.0/delta-core_2.12-1.0.0.jar

run: 
	@docker run -it -p 18080:18080 -v ./spark-delta:/home longpt233/spark-delta:0.0.1

