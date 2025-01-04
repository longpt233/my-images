package demo.integration;

import demo.DemoConfiguration;
import demo.repository.ItemRepository;
import demo.repository.OutboxRepository;
import demo.rest.api.CreateItemRequest;
import demo.util.TestRestData;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ActiveProfiles;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.notNullValue;

@Slf4j
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT, classes = { DemoConfiguration.class } )
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
@ActiveProfiles("test")
public class EndToEndIntegrationTest {

    @Autowired
    private ItemRepository itemRepository;

    @Autowired
    private OutboxRepository outboxRepository;

    @Autowired
    private TestRestTemplate restTemplate;

    public void setUp() {
        outboxRepository.deleteAll();
    }

    /**
     * Send a request to create an item and verify the item and outbox entities are persisted.
     */
    @Test
    public void testCreateItem()  {
        CreateItemRequest request = TestRestData.buildCreateItemRequest(RandomStringUtils.randomAlphabetic(8));

        ResponseEntity<String> response = restTemplate.postForEntity("/v1/item", request, String.class);
        assertThat(response.getStatusCode(), equalTo(HttpStatus.CREATED));
        assertThat(response.getHeaders().getLocation(), notNullValue());

        assertThat(itemRepository.count(), equalTo(1L));
        assertThat(outboxRepository.count(), equalTo(1L));
    }
}
