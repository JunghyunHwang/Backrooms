package com.backrooms.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.ReservationDTO;

@Repository
public class ReservationDAO {

    @Autowired
    private SqlSession session;

    public int insertReservation(ReservationDTO dto) {
        return session.insert("ReservationMapper.insertReservation", dto);
    }
    
    public int insertReservationAndGetId(ReservationDTO dto) {
        session.insert("ReservationMapper.insertReservationAndGetId", dto);
        return dto.getReservationNum(); 
    }

    public ReservationDTO selectReservationById(int reservationNum) {
        return session.selectOne("ReservationMapper.selectReservationById", reservationNum);
    }



    
    	
}
