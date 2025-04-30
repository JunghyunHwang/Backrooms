package com.backrooms.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.PayDTO;

@Repository
public class PayDAO {

    @Autowired
    SqlSession session;

    public void insertPay(PayDTO dto) {
        session.insert("PayMapper.insertPay", dto);
    }

    public void updateReservationState(int reservationNum) {
        session.update("PayMapper.updateReservationState", reservationNum);
    }
}
