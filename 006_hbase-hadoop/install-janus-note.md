
## 1. download 

```
350  wget https://github.com/JanusGraph/janusgraph/releases/download/v0.6.0/janusgraph-0.6.0.zip
351  unzip janusgraph-0.6.0.zip 
352  cd janusgraph-0.6.0/
```

## 2. conf 

- cai java home 
```
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/
```

- cấu hình cho server (on hbase - có thể trên es nứa). chú ý những conf sau

```
nano conf/gremlin-server/gremlin-server-configuration-hbase.yaml 

host: 0.0.0.0
port: 8182
scriptEngines: {
  gremlin-groovy: {
    plugins: { org.apache.tinkerpop.gremlin.jsr223.ScriptFileGremlinPlugin: {files: [script/init.groovy]}}}}
channelizer: org.apache.tinkerpop.gremlin.server.channel.WsAndHttpChannelizer
graph: conf/my-janusgraph.properties
```

- file cấu hình trên cần trỏ tới file conf graph sau nữa

```
nano conf/my-janusgraph.properties 

gremlin.graph=org.janusgraph.core.JanusGraphFactory
storage.backend=hbase
storage.hostname=10.3.107.203,10.3.105.185,10.3.105.61
storage.hbase.table=my_graph
cache.....

```

- và trỏ tới script init 

```
def globals = [:]
globals << [g : graph.traversal()]
```

## 3. run 

- run server
```
bin/janusgraph-server.sh conf/gremlin-server/gremlin-server-configuration-hbase.yaml
```

- tạo schema

```
bin/gremlin.sh -e  script/create.groovy conf/my-janusgraph.properties
```

- test 

```
bin/gremlin.sh conf/my-janusgraph.properties

gremlin> :remote connect tinkerpop.server conf/remote.yaml
==>Configured internship-hadoop107203/10.3.107.203:8182  
gremlin> :remote console                     
==>All scripts will now be sent to Gremlin Server - [internship-hadoop107203/10.3.107.203:8182]
gremlin> g.V().count()                
==>0             
gremlin> :remote console  
```

- file config cho cái connect bên trên.
```
cat conf/remote.yaml

hosts: [10.3.107.203]
port: 8182
serializer: { className: org.apache.tinkerpop.gremlin.driver.ser.GryoMessageSerializerV3d0, config: { serializeResultToString: true }}

```

- cách conect khác (cho thêm java chẳng hạn)

```
g = traversal().withRemote('conf/remote-graph.properties')
```

```
cat conf/remote-graph.properties
gremlin.remote.remoteConnectionClass=org.apache.tinkerpop.gremlin.driver.remote.DriverRemoteConnection
gremlin.remote.driver.clusterFile=conf/remote-objects.yaml
gremlin.remote.driver.sourceName=g

```

```
cat conf/remote-objects.yaml 
hosts: [10.3.107.203]
port: 8182
serializer: { className: org.apache.tinkerpop.gremlin.driver.ser.GryoMessageSerializerV3d0, config: { ioRegistries: [org.janusgraph.graphdb.tinkerpop.JanusGraphIoRegistry] }}
```


## 4. ui 

