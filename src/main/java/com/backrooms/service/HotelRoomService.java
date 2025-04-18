package com.backrooms.service;

import com.backrooms.dao.HotelRoomDAO;
import com.backrooms.dao.ImageDAO;
import com.backrooms.dto.HotelDetailRequestDTO;
import com.backrooms.dto.HotelRoomDTO;
import com.backrooms.dto.ImageKind;
import com.backrooms.dto.ImageRequestDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HotelRoomService {
    @Autowired
    private HotelRoomDAO hotelRoomDao;

    @Autowired
    private ImageDAO imgDao;

    public List<HotelRoomDTO> getAvailableRooms(HotelDetailRequestDTO filter) {
        List<HotelRoomDTO> availableRooms = hotelRoomDao.getAvailableRooms(filter);

        ImageRequestDTO imgFilter = new ImageRequestDTO(ImageKind.HOTEL.getValue());
        imgFilter.addUse(filter.getHotelNum());
        int hotelImagesCount = imgDao.getImageCount(imgFilter).get(0);

        imgFilter.clear();
        imgFilter.setKind(ImageKind.ROOM);
        for (HotelRoomDTO r : availableRooms) {
            imgFilter.addUse(r.getRoomNum());
        }

        List<Integer> roomImageCounts = imgDao.getImageCount(imgFilter);
        for (int i = 0; i < availableRooms.size(); ++i) {
            availableRooms.get(i).setHotelImageCount(hotelImagesCount);
            availableRooms.get(i).setRoomImageCount(roomImageCounts.get(i));
        }

        return availableRooms;
    }

    public HotelRoomDTO selectRoom(int roomNum) {
        return hotelRoomDao.selectRoom(roomNum);
    }
}
