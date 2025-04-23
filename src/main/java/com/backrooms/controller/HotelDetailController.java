package com.backrooms.controller;

import com.backrooms.dto.Hotel;
import com.backrooms.dto.HotelDetailRequestDTO;
import com.backrooms.dto.HotelRoomDTO;
import com.backrooms.dto.ReviewDTO;
import com.backrooms.service.HotelRoomService;
import com.backrooms.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class HotelDetailController {
    private final HotelRoomService hotelRoomService;
    private final ReviewService reviewService;

    @Autowired
    public HotelDetailController(HotelRoomService hotelRoomService, ReviewService reviewService) {
        this.hotelRoomService = hotelRoomService;
        this.reviewService = reviewService;
    }

    @RequestMapping(value = "/HotelDetail", method = RequestMethod.POST)
    public ModelAndView getHotelDetail(@ModelAttribute HotelDetailRequestDTO filter) {
        ModelAndView mav = new ModelAndView("hotelDetail");

        Hotel hotel = hotelRoomService.getHotelWithRooms(filter);
        List<ReviewDTO> roomReviews = reviewService.reviewSelectRoom(hotel);

        mav.addObject("hotel", hotel);
        mav.addObject("roomReviews", roomReviews);
        mav.addObject("checkIn", filter.getCheckIn());
        mav.addObject("checkOut", filter.getCheckOut());

        return mav;
    }
}
