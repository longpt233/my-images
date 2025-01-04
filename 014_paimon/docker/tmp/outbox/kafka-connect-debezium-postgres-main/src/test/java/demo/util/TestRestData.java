package demo.util;

import demo.rest.api.CreateItemRequest;

public class TestRestData {

    public static CreateItemRequest buildCreateItemRequest(String name) {
        return CreateItemRequest.builder()
                .name(name)
                .build();
    }
}
