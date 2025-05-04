package com.backrooms.service;

import com.backrooms.dao.ImageDAO;
import com.backrooms.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backrooms.dao.HotelQueryDAO;

import java.util.List;

@Service
public class HotelQueryService {
    private final HotelQueryDAO hotelQueryDao;
    private final ImageDAO imageDao;

    @Autowired
    public HotelQueryService(HotelQueryDAO hotelQueryDao, ImageDAO imageDao) {
        this.hotelQueryDao = hotelQueryDao;
        this.imageDao = imageDao;
    }

    public HotelDTO selectHotelByRoomNum(int roomNum) {
        return hotelQueryDao.selectHotelByRoomNum(roomNum);
    }

    public boolean insertHotelsAndRooms(List<HotelInsert> hotels) {
        int result = - 1;

        for (HotelInsert h : hotels) {
            assert(!h.getRoomInserts().isEmpty()) : "Room list is empty";

            result = hotelQueryDao.insertHotel(h);
            assert(result > 0) : "Hotel insert failed";

            result = hotelQueryDao.insertRooms(h);
            assert(result > 0) : "Room insert failed";

            int hotelNum = h.getRoomInserts().get(0).getHotelNum();
            for (String imageUrl : h.getExteriorImageUrls()) {
                result = imageDao.insertFile(new ImageInsertDTO(ImageKind.HOTEL.getValue(), hotelNum, imageUrl, imageUrl));
            }

            // TODO: 한 번에 여러 객실 pk set할 수 있게
            for (RoomInsert r : h.getRoomInserts()) {
                r.setRoomNum(hotelQueryDao.selectRoomNum(r));

                for (String imageUrl : r.getRoomImageUrls()) {
                    result = imageDao.insertFile(new ImageInsertDTO(ImageKind.ROOM.getValue(), r.getRoomNum(), imageUrl, imageUrl));
                }
            }

            assert(result > 0) : "image insert failed";
        }

        return result > 0;
    }
}