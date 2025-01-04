package demo.util;

import java.util.UUID;

import demo.domain.Item;
import demo.domain.Outbox;

public class TestDomainData {

    public static Item buildItem(UUID id, String name) {
        return Item.builder()
                .id(id)
                .name(name)
                .build();
    }

    public static Outbox buildOutbox(UUID id) {
        return Outbox.builder()
                .id(id)
                .destination("outbox")
                .timestamp(100L)
                .payload("payload")
                .version("1")
                .build();
    }
}
