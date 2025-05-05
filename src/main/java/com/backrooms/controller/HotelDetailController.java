package com.backrooms.controller;

import com.backrooms.dto.Hotel;
import com.backrooms.dto.HotelDetailRequestDTO;
import com.backrooms.dto.ReviewDTO;
import com.backrooms.external.ApiKeyProvider;
import com.backrooms.service.HotelRoomService;
import com.backrooms.service.ReviewService;
import com.backrooms.external.HotelDataFetcher;
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
    private final HotelDataFetcher hotelDataFetcher;
    private final ApiKeyProvider apiKeyProvider;

    @Autowired
    public HotelDetailController(HotelRoomService hotelRoomService, ReviewService reviewService, HotelDataFetcher hotelDataFetcher, ApiKeyProvider apiKeyProvider) {
        this.hotelRoomService = hotelRoomService;
        this.reviewService = reviewService;
        this.hotelDataFetcher = hotelDataFetcher;
        this.apiKeyProvider = apiKeyProvider;
    }

    @RequestMapping(value = "/HotelDetail", method = RequestMethod.POST)
    public ModelAndView getHotelDetail(@ModelAttribute HotelDetailRequestDTO filter) {
        ModelAndView mav = new ModelAndView("hotelDetail");

        Hotel hotel = hotelRoomService.getHotelWithRooms(filter);
        List<ReviewDTO> roomReviews = reviewService.reviewSelectRoom(hotel);
        int maxMainRoomImageCount = Math.min(hotel.getRooms().size(), 2);

        mav.addObject("hotel", hotel);
        mav.addObject("roomReviews", roomReviews);
        mav.addObject("checkIn", filter.getCheckIn());
        mav.addObject("checkOut", filter.getCheckOut());
        mav.addObject("embedMapKey", apiKeyProvider.getGoogleApiKey());
        mav.addObject("maxMainRoomImageCount", maxMainRoomImageCount);

        return mav;
    }

    @RequestMapping(value = "/setHotelData", method = RequestMethod.GET)
    public String setHotelData() {
        hotelDataFetcher.fetchHotelData("서울", 10000);

        return "redirect:/";
    }
}
