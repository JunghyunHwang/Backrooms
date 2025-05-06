package com.backrooms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backrooms.dao.ReservationDAO;
import com.backrooms.dto.ReservationDTO;

@Service
public class ReservationServiceImpl implements ReservationService {

    @Autowired
    ReservationDAO dao;

    @Override
    public int insertReservationAndGetId(ReservationDTO dto) {
        return dao.insertReservationAndGetId(dto);
    }

    @Override
    public ReservationDTO getReservationById(int reservationNum) {
        return dao.selectReservationById(reservationNum);
    }
    
    
 
}