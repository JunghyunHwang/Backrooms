package com.backrooms.dao;

// 예약 정보 구간에서 호텔 번호를 기억하기 위해 기존 hotel 기능과 분리한 DAO입니다.


import com.backrooms.dto.HotelInsert;
import com.backrooms.dto.RoomInsert;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.HotelDTO;

import java.util.List;

@Repository
public class HotelQueryDAO {
    private final SqlSessionTemplate template;

    @Autowired
    public HotelQueryDAO(SqlSessionTemplate template) {
        this.template = template;
    }

    public HotelDTO selectHotelByRoomNum(int roomNum) {
        return template.selectOne("HotelMapper.selectHotelByRoomNum", roomNum);
    }

    public int getHotelCount() {
        return template.selectOne("HotelMapper.selectHotelCount");
    }

    public int insertHotel(HotelInsert hotel) {
        return template.insert("HotelMapper.insertHotel", hotel);
    }

    public int insertHotels(List<HotelInsert> hotels) {
        return template.insert("HotelMapper.insertHotels", hotels);
    }

    public int insertRooms(HotelInsert hotel) {
        int result = -1;
        int hotelNum = template.selectOne("HotelMapper.selectHotelNumByName", hotel);

        for (RoomInsert r : hotel.getRoomInserts()) {
            r.setHotelNum(hotelNum);
            result = template.insert("HotelMapper.insertRoom", r);

            if (result <= 0) {
                result = -1;
                break;
            }
        }

        return result;
    }

    public int selectRoomNum(RoomInsert room) {
        return template.selectOne("HotelRoomMapper.selectRoomNum", room);
    }
}