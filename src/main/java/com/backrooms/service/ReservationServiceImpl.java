package com.backrooms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backrooms.dao.ReservationDAO;
import com.backrooms.dto.ReservationDTO;

@Service
public class ReservationServiceImpl implements ReservationService {

    @Autowired
    private ReservationDAO dao;

    @Override
    public int insertReservationAndGetId(ReservationDTO dto) {
    	  dao.insertReservation(dto);
          return dto.getReservationNum(); // selectKey로 세팅된 예약 번호 반환
    }
}
