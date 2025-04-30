package com.backrooms.service;

import com.backrooms.dto.ReservationDTO;

public interface ReservationService {
    int insertReservationAndGetId(ReservationDTO dto);
}
