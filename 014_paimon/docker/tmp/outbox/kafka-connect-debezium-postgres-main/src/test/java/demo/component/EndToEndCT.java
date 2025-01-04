package demo.component;

import java.time.Duration;
import java.util.List;

import demo.rest.api.CreateItemRequest;
import demo.util.TestRestData;
import dev.lydtech.component.framework.client.debezium.DebeziumClient;
import dev.lydtech.component.framework.client.kafka.KafkaClient;
import dev.lydtech.component.framework.client.service.ServiceClient;
import dev.lydtech.component.framework.extension.ComponentTestExtension;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.kafka.clients.consumer.Consumer;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.http.HttpStatus;
import org.springframework.test.context.ActiveProfiles;

import static io.restassured.RestAssured.given;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.notNullValue;

/**
 * Demonstrates the Transactional Outbox pattern with Kafka Connect using Debezium for CDC.
 */
@Slf4j
@ExtendWith(ComponentTestExtension.class)
@ActiveProfiles("component-test")
public class EndToEndCT {

    private static final String GROUP_ID = "EndToEndCT";
    private Consumer consumer;

    @BeforeEach
    public void setup() {
        String serviceBaseUrl = ServiceClient.getInstance().getBaseUrl();
        log.info("Service base URL is: {}", serviceBaseUrl);
        RestAssured.baseURI = serviceBaseUrl;

        // Configure the test Kafka consumer to listen to the outbox topic.
        consumer = KafkaClient.getInstance().createConsumer(GROUP_ID, "outbox.event.item");

        // Configure the debezium source connector.
        DebeziumClient.getInstance().createConnector("connector/debezium-postgres-source-connector.json");

        // Clear the topic.
        consumer.poll(Duration.ofSeconds(1));
    }

    @AfterEach
    public void tearDown() {
        DebeziumClient.getInstance().deleteConnector("debezium-postgres-source-connector");
        consumer.close();
    }

    /**
     * A REST request is POSTed to the v1/item endpoint in order to create a new Item entity.
     *
     * An outbound event is emitted using the transactional outbox pattern, with Debezium writing the event to Kafka.
     *
     * The outbound event should have the new item id and name in its payload (as JSON).  The item id is also returned
     * in the REST request to create the item, so is available for comparison.
     */
    @Test
    public void testTransactionalOutbox() throws Exception {
        CreateItemRequest request = TestRestData.buildCreateItemRequest(RandomStringUtils.randomAlphabetic(12));
        Response createItemResponse = given()
                .header("Content-type", "application/json")
                .and()
                .body(request)
                .when()
                .post("/v1/item")
                .then()
                .assertThat()
                .statusCode(HttpStatus.CREATED.value())
                .extract()
                .response();
        String location = createItemResponse.header("Location");
        assertThat(location, notNullValue());
        log.info("Create item response location header: "+location);
        List<ConsumerRecord<String, String>> outboundEvents = KafkaClient.getInstance().consumeAndAssert("TransactionalOutbox", consumer, 1, 3);
        assertThat(outboundEvents.size(), equalTo(1));
        log.info("Outbox event: "+outboundEvents.get(0));
        assertThat(outboundEvents.get(0).value(), containsString(request.getName()));
        assertThat(outboundEvents.get(0).value(), containsString(location));
    }
}
