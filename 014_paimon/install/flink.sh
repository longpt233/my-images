
    log4j-cli.properties: used by the command line interface (e.g., flink run, sql-client)
    log4j-session.properties: used by the command line interface when starting a Kubernetes/Yarn session cluster (i.e., kubernetes-session.sh/yarn-session.sh)
    log4j-console.properties: used for Job-/TaskManagers if they are run in the foreground (e.g., Kubernetes)
    log4j.properties: used for Job-/TaskManagers by default


chán, log flink run phải set trong log4j-cli.properties
chán, log nó output không hết, phải xem trong file mới có nhiều

flink run ....
.... 
2025-01-07 10:25:35,023 DEBUG org.apache.hadoop.fs.s3a.Invoker                             [] - Starting: create credentials
2025-01-07 10:25:35,024 DEBUG org.apache.hadoop.fs.s3a.Invoker                             [] - create credentials: duration 0:00.001s
2025-01-07 10:25:35,025 DEBUG org.apache.hadoop.fs.s3a.AWSCredentialProviderList           [] - No credentials from TemporaryAWSCredentialsProvider: org.apache.hadoop.fs.s3a.auth.NoAwsCredentialsException: Session credentials in Hadoop configuration: No AWS Credentials
2025-01-07 10:25:35,025 DEBUG org.apache.hadoop.fs.s3a.AWSCredentialProviderList           [] - No credentials from SimpleAWSCredentialsProvider: org.apache.hadoop.fs.s3a.auth.NoAwsCredentialsException: SimpleAWSCredentialsProvider: No AWS credentials in the Hadoop configuration
2025-01-07 10:25:35,025 DEBUG org.apache.hadoop.fs.s3a.AWSCredentialProviderList           [] - Using credentials from EnvironmentVariableCredentialsProvider


trong log có nhiều

flink@77a05d432318:~$ tail -n 1000 log/flink--client-77a05d432318.log 
...
2025-01-07 10:30:39,086 DEBUG org.apache.http.impl.conn.DefaultHttpClientConnectionOperator [] - Connecting to s3.amazonaws.com/52.217.196.80:443
2025-01-07 10:30:39,086 DEBUG com.amazonaws.http.conn.ssl.SdkTLSSocketFactory              [] - connecting to s3.amazonaws.com/52.217.196.80:443
2025-01-07 10:30:39,086 DEBUG com.amazonaws.http.conn.ssl.SdkTLSSocketFactory              [] - Connecting socket to s3.amazonaws.com/52.217.196.80:443 with timeout 5000
2025-01-07 10:30:44,091 DEBUG org.apache.http.impl.conn.DefaultHttpClientConnectionOperator [] - Connect to s3.amazonaws.com/52.217.196.80:443 timed out. Connection will be retried using another IP address
2025-01-07 10:30:44,091 DEBUG org.apache.http.impl.conn.DefaultHttpClientConnectionOperator [] - Connecting to s3.amazonaws.com/16.15.184.20:443
2025-01-07 10:30:44,091 DEBUG com.amazonaws.http.conn.ssl.SdkTLSSocketFactory              [] - connecting to s3.amazonaws.com/16.15.184.20:443
2025-01-07 10:30:44,091 DEBUG com.amazonaws.http.conn.ssl.SdkTLSSocketFactory              [] - Connecting socket to s3.amazonaws.com/16.15.184.20:443 with timeout 5000
