package com.backrooms.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.MyReservationDTO;

@Repository
public class MyReservationDAO {

    @Autowired
    SqlSession session;

    public List<MyReservationDTO> getReservationsByMemberNum(int memberNum) {
        return session.selectList("MyReservationMapper.selectByMemberNum", memberNum);
    }
    public int updateReservationStateToCancel(int reservationNum) {
        return session.update("MyReservationMapper.updateReservationStateToCancel", reservationNum);
    }
}
