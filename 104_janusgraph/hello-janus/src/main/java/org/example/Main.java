package org.example;

import org.apache.tinkerpop.gremlin.process.traversal.Order;
import org.apache.tinkerpop.gremlin.process.traversal.dsl.graph.GraphTraversal;
import org.apache.tinkerpop.gremlin.structure.Direction;
import org.apache.tinkerpop.gremlin.structure.Edge;
import org.apache.tinkerpop.gremlin.structure.T;
import org.apache.tinkerpop.gremlin.structure.Vertex;
import org.janusgraph.core.*;
import org.janusgraph.core.attribute.Geoshape;
import org.janusgraph.core.schema.ConsistencyModifier;
import org.janusgraph.core.schema.JanusGraphIndex;
import org.janusgraph.core.schema.JanusGraphManagement;
import org.janusgraph.example.GraphOfTheGodsFactory;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.HashMap;

public class Main {
    public static void main(String[] args) {

        JanusGraphFactory.Builder config = JanusGraphFactory.build();
//        config.set("storage.backend", "hbase");
//        config.set("storage.port", 2181);
//        config.set("storage.hostname", Arrays.asList("192.168.23.37","192.168.23.39","192.168.23.41"));
//        config.set("storage.hbase.table", "longpt_test_composite_index");

        config.set("storage.backend", "inmemory");

        JanusGraph graph = config.open();

//        JanusGraph g = JanusGraphFactory.open(args[0]);


        //Create Schema
        JanusGraphManagement management = graph.openManagement();
        final PropertyKey name = management.makePropertyKey("name").dataType(String.class).make();
        JanusGraphManagement.IndexBuilder nameIndexBuilder = management.buildIndex("name", Vertex.class).addKey(name);
        nameIndexBuilder.buildCompositeIndex();

        management.makeVertexLabel("pii").make();
        management.commit();

        HashMap<String, Object> properties = new HashMap<>();
        properties.put("name", "long");

        GraphTraversal<Vertex, Vertex> t = graph.traversal().addV("pii");
        properties.forEach(t::property);
        t.next();

        Vertex v = graph.traversal().V().has("name","long").next();
        System.out.println(v);

        graph.close();
    }
}