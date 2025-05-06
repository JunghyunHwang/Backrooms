package com.backrooms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backrooms.dao.MyReservationDAO;
import com.backrooms.dto.MyReservationDTO;

@Service
public class MyReservationServiceImpl implements MyReservationService {

    @Autowired
    private MyReservationDAO dao;

    @Override
    public List<MyReservationDTO> getReservationsByMemberNum(int memberNum) {
        return dao.getReservationsByMemberNum(memberNum);
    }
    
    @Override
	public int cancelReservation(int reservationNum) {
	    return dao.updateReservationStateToCancel(reservationNum);
	}
}
