package com.backrooms.dao;

// 예약 정보 구간에서 호텔 번호를 기억하기 위해 기존 hotel 기능과 분리한 DAO입니다.


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.HotelDTO;

@Repository
public class HotelQueryDAO {

    @Autowired
    SqlSession session;

    public HotelDTO selectHotelByRoomNum(int roomNum) {
        return session.selectOne("HotelMapper.selectHotelByRoomNum", roomNum);
    }
}