package com.backrooms.service;

import com.backrooms.dao.HotelRoomDAO;
import com.backrooms.dao.ImageDAO;

import com.backrooms.dto.*;

import com.backrooms.external.ApiKeyProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HotelRoomService {
    private final HotelRoomDAO hotelRoomDao;
    private final ImageDAO imageDAO;

    @Autowired
    public HotelRoomService(HotelRoomDAO hotelRoomDao, ImageDAO imageDAO) {
        this.hotelRoomDao = hotelRoomDao;
        this.imageDAO = imageDAO;
    }

    public Hotel getHotelWithRooms(HotelDetailRequestDTO filter) {
        List<HotelRoomDTO> availableRooms = hotelRoomDao.getAvailableRooms(filter);
        assert(availableRooms != null) : "Available rooms is null";

        Hotel hotel = new Hotel(filter.getHotelNum(),
                availableRooms.get(0).getHotelName(),
                availableRooms.get(0).getHotelAddress(),
                availableRooms.get(0).getHotelRating(),
                availableRooms.get(0).getHotelGrade(),
                availableRooms.get(0).getLatitude(),
                availableRooms.get(0).getLongitude(),
                availableRooms.get(0).getBreakfastPrice());

        ImageFileQueryDTO hotelImgFilter = new ImageFileQueryDTO(filter.getHotelNum(), ImageKind.HOTEL.getValue());
        List<ImageFileNamesDTO> hotelImages = imageDAO.getUploadAndStoreFileNames(hotelImgFilter);

        for (ImageFileNamesDTO hotelImage : hotelImages) {
            hotel.addImageUrl(hotelImage.getImageStoreFileName());
        }

        for (HotelRoomDTO availableRoom : availableRooms) {
            Room room = new Room(
                    availableRoom.getRoomNum(),
                    availableRoom.getRoomName(),
                    availableRoom.getRoomPrice(),
                    availableRoom.getCapacity(),
                    availableRoom.getRoomInfo().split("/"));

            hotel.addRoom(room);

            List<ImageFileNamesDTO> roomsImages = imageDAO.getUploadAndStoreFileNames(
                    new ImageFileQueryDTO(room.getRoomNum(), ImageKind.ROOM.getValue()));

            for (ImageFileNamesDTO roomImage : roomsImages) {
                room.addImageUrl(roomImage.getImageStoreFileName());
            }
        }

        return hotel;
    }

    public HotelRoomDTO selectRoom(int roomNum) {
        return hotelRoomDao.selectRoom(roomNum);
    }
}
