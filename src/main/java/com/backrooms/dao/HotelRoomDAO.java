package com.backrooms.dao;

import com.backrooms.dto.HotelDetailRequestDTO;
import com.backrooms.dto.HotelRoomDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class HotelRoomDAO {
    private final SqlSessionTemplate template;

    @Autowired
    public HotelRoomDAO(SqlSessionTemplate template) {
        this.template = template;
    }

    public List<HotelRoomDTO> getAvailableRooms(HotelDetailRequestDTO filter) {
        return template.selectList("HotelRoomMapper.getAvailableRooms", filter);
    }

    public HotelRoomDTO selectRoom(int roomNum) {
        HotelRoomDTO dto = new HotelRoomDTO();
        dto.setRoomNum(roomNum);
        return template.selectOne("HotelRoomMapper.selectRoom", roomNum);
    }
}
