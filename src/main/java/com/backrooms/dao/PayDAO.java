package com.backrooms.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.MailDTO;
import com.backrooms.dto.PayDTO;

@Repository
public class PayDAO {

    @Autowired
    SqlSession session;

    public void insertPay(PayDTO dto) {
        session.insert("PayMapper.insertPay", dto);
    }

    public void updateReservationState(int reservationNum) {
        session.update("PayMapper.updateReservationState", reservationNum);
    }

	public MailDTO sendMail(HashMap<String, Integer> map) {
		HashMap<String, Object> MailInfo = session.selectOne("PayMapper.SendMail", map);
		HashMap<String, Object> hotelmap = session.selectOne("PayMapper.HotelInfo",map.get("reservationNum"));
		MailDTO dto = new MailDTO();
		dto.setName((String)MailInfo.get("MEMBERNAME"));
		dto.setEmail((String)MailInfo.get("EMAIL"));
		dto.setCheckIn((String)MailInfo.get("CHECKIN"));
		dto.setCheckOut((String)MailInfo.get("CHECKOUT"));
		dto.setHotelName((String)hotelmap.get("HOTELNAME"));
		dto.setHoteladdress((String)hotelmap.get("HOTELADDRESS"));
		dto.setRoomName((String)hotelmap.get("ROOMNAME"));
		return dto;
	}
    
}
