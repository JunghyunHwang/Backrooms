package com.backrooms.service;

import com.backrooms.dao.HotelRoomDAO;
import com.backrooms.dao.ImageDAO;
import com.backrooms.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HotelRoomService {
    private final HotelRoomDAO hotelRoomDao;
    private final ImageDAO imgDao;

    @Autowired
    public HotelRoomService(HotelRoomDAO hotelRoomDao, ImageDAO imgDao) {
        this.hotelRoomDao = hotelRoomDao;
        this.imgDao = imgDao;
    }

    public Hotel getHotelWithRooms(HotelDetailRequestDTO filter) {
        List<HotelRoomDTO> availableRooms = hotelRoomDao.getAvailableRooms(filter);
        ImageRequestDTO hotelImgFilter = new ImageRequestDTO(ImageKind.HOTEL.getValue());
        hotelImgFilter.addUse(filter.getHotelNum());
        int hotelImagesCount = imgDao.getImageCount(hotelImgFilter).get(0);

        ImageRequestDTO roomImgFilter = new ImageRequestDTO(ImageKind.ROOM.getValue());
        for (HotelRoomDTO r : availableRooms) {
            roomImgFilter.addUse(r.getRoomNum());
        }
        List<Integer> roomImageCounts = imgDao.getImageCount(roomImgFilter);

        Hotel hotel = new Hotel(filter.getHotelNum(),
                availableRooms.get(0).getHotelName(),
                availableRooms.get(0).getHotelAddress(),
                availableRooms.get(0).getHotelRating(),
                availableRooms.get(0).getHotelGrade(),
                availableRooms.get(0).getLatitude(),
                availableRooms.get(0).getLongitude(),
                hotelImagesCount,
                availableRooms.get(0).getBreakfastPrice());

        assert(availableRooms.size() == roomImageCounts.size());
        for (int i = 0; i < availableRooms.size(); ++i) {
            hotel.addRoom(new Room(
                    availableRooms.get(i).getHotelNum(),
                    availableRooms.get(i).getRoomName(),
                    availableRooms.get(i).getRoomPrice(),
                    availableRooms.get(i).getCapacity(),
                    availableRooms.get(i).getRoomInfo().split("/"),
                    roomImageCounts.get(i)
                    ));
        }

        return hotel;
    }

    public HotelRoomDTO selectRoom(int roomNum) {
        return hotelRoomDao.selectRoom(roomNum);
    }
}
