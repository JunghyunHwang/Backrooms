package com.backrooms.external;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Getter
@Component
public class ApiKeyProvider {
    @Value("${google.api.key}")
    private String googleApiKey;
}
