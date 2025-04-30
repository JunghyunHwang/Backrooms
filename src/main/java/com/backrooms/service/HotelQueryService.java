package com.backrooms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backrooms.dao.HotelQueryDAO;
import com.backrooms.dto.HotelDTO;

@Service
public class HotelQueryService {

    @Autowired
    HotelQueryDAO dao;

    public HotelDTO selectHotelByRoomNum(int roomNum) {
        return dao.selectHotelByRoomNum(roomNum);
    }
}