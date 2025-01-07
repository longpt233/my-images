#!/bin/bash

# Create jars directory if it doesn't exist
mkdir -p jars

# Base URLs for the repositories
MAVEN_CENTRAL="https://repo1.maven.org/maven2"
APACHE_REPO="https://repository.apache.org/content/repositories/releases"

# Function to download file if it doesn't exist
download_file() {
    local url=$1
    local output=$2
    
    if [ ! -f "$output" ]; then
        echo "Downloading: $output"
        wget -q --show-progress "$url" -O "$output"
        if [ $? -eq 0 ]; then
            echo "Successfully downloaded: $output"
        else
            echo "Failed to download: $output"
            rm -f "$output"
            return 1
        fi
    else
        echo "File already exists: $output"
    fi
}

# Download Hadoop uber jar
download_file \
    "${MAVEN_CENTRAL}/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar" \
    "jars/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar"

# Download Flink S3 filesystem jar
download_file \
    "${MAVEN_CENTRAL}/org/apache/flink/flink-s3-fs-hadoop/1.20.0/flink-s3-fs-hadoop-1.20.0.jar" \
    "jars/flink-s3-fs-hadoop-1.20.0.jar"

# Download Paimon Flink jar
download_file \
    "${MAVEN_CENTRAL}/org/apache/paimon/paimon-flink-1.20/0.9.0/paimon-flink-1.20-0.9.0.jar" \
    "jars/paimon-flink-1.20-0.9.0.jar"

# Download Paimon S3 jar
download_file \
    "${MAVEN_CENTRAL}/org/apache/paimon/paimon-s3/0.9.0/paimon-s3-0.9.0.jar" \
    "jars/paimon-s3-0.9.0.jar"

# Download Flink Hive connector jar
download_file \
    "${MAVEN_CENTRAL}/org/apache/flink/flink-sql-connector-hive-3.1.3_2.12/1.20.0/flink-sql-connector-hive-3.1.3_2.12-1.20.0.jar" \
    "jars/flink-sql-connector-hive-3.1.3_2.12-1.20.0.jar"

echo "All downloads completed!"