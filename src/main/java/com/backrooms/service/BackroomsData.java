package com.backrooms.service;

import com.backrooms.dao.HotelQueryDAO;
import com.backrooms.external.HotelDataFetcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BackroomsData {
    private final HotelDataFetcher hotelDataFetcher;
    private final HotelQueryService hotelQueryService;

    @Autowired
    public BackroomsData(HotelDataFetcher hotelDataFetcher, HotelQueryService hotelQueryService) {
        this.hotelDataFetcher = hotelDataFetcher;
        this.hotelQueryService = hotelQueryService;
    }

    public void checkAndLoadData() {
        System.out.println("Checking hotel data...");
        if (hotelQueryService.getHotelCount() == 0) {
            System.out.println("Insert hotel data...");
            hotelDataFetcher.fetchHotelData("서울", 10000);
        }
    }
}
