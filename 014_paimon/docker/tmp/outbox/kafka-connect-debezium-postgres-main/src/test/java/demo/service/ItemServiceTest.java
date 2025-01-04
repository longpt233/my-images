package demo.service;

import java.util.UUID;

import demo.domain.Item;
import demo.domain.Outbox;
import demo.repository.ItemRepository;
import demo.repository.OutboxRepository;
import demo.rest.api.CreateItemRequest;
import demo.util.TestDomainData;
import demo.util.TestRestData;
import org.apache.commons.lang3.RandomStringUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static java.util.UUID.randomUUID;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class ItemServiceTest {

    private ItemRepository itemRepositoryMock;
    private OutboxRepository outboxRepositoryMock;
    private ItemService service;

    @BeforeEach
    public void setUp() {
        itemRepositoryMock = mock(ItemRepository.class);
        outboxRepositoryMock = mock(OutboxRepository.class);
        service = new ItemService(itemRepositoryMock, outboxRepositoryMock, "destination");
    }

    /**
     * Ensure the item and outbox entities are persisted.
     */
    @Test
    public void testProcess() throws Exception {
        UUID itemId = randomUUID();
        CreateItemRequest request = TestRestData.buildCreateItemRequest(RandomStringUtils.randomAlphabetic(8));
        when(itemRepositoryMock.save(any(Item.class))).thenReturn(TestDomainData.buildItem(itemId, request.getName()));
        when(outboxRepositoryMock.save(any(Outbox.class))).thenReturn(TestDomainData.buildOutbox(randomUUID()));

        UUID newItemId = service.process(request);

        assertThat(itemId, equalTo(newItemId));
        verify(itemRepositoryMock, times(1)).save(any(Item.class));
        verify(outboxRepositoryMock, times(1)).save(any(Outbox.class));
    }
}
