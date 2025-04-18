package com.backrooms.controller;

import com.backrooms.dto.HotelDetailRequestDTO;
import com.backrooms.dto.HotelRoomDTO;
import com.backrooms.service.HotelRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class HotelDetail {
    @Autowired
    private HotelRoomService hotelRoomService;

    @Autowired
    private ReviewService reviewService;

    @RequestMapping(value = "/HotelDetail", method = RequestMethod.POST)
    public ModelAndView getHotelDetail(@ModelAttribute HotelDetailRequestDTO filter) {
        ModelAndView mav = new ModelAndView("hotelDetail");

        List<HotelRoomDTO> avaliableRoomsList = hotelRoomService.getAvailableRooms(filter);
        List<ReviewDTO> roomReviews = reviewService.reviewSelectRoom(avaliableRoomsList);

        mav.addObject("avaliableRoomsList", avaliableRoomsList);
        mav.addObject("roomReviews", roomReviews);
        mav.addObject("checkIn", filter.getCheckIn());
        mav.addObject("checkOut", filter.getCheckOut());

        return mav;
    }
}
