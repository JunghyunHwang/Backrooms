package com.backrooms.config;

import com.backrooms.service.BackroomsData;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class StartupChecker {
    private final BackroomsData backroomsData;

    public StartupChecker(BackroomsData backroomsData) {
        this.backroomsData = backroomsData;
    }

    @EventListener(ApplicationReadyEvent.class)
    public void onApplicationReady() {
        backroomsData.checkAndLoadData();
    }
}
