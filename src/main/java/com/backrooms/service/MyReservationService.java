package com.backrooms.service;

import java.util.List;
import com.backrooms.dto.MyReservationDTO;

public interface MyReservationService {
    List<MyReservationDTO> getReservationsByMemberNum(int memberNum);
}
