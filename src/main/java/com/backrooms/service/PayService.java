package com.backrooms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backrooms.dao.PayDAO;
import com.backrooms.dto.PayDTO;

@Service
public class PayService {

    @Autowired
    private PayDAO dao;

    public void insertPay(PayDTO dto) {
        dao.insertPay(dto);
    }

    public void updateReservationState(int reservationNum) {
        dao.updateReservationState(reservationNum);
    }
}
