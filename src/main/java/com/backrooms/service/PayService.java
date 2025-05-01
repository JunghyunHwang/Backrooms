package com.backrooms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import java.util.HashMap;

import com.backrooms.dao.PayDAO;
import com.backrooms.dto.PayDTO;
import com.backrooms.dto.MailDTO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PayService {

    @Autowired
    private PayDAO dao;
    
    private final JavaMailSender javaMailSender;
	  
    public void sendSimpleMailMessage(PayDTO dto) {
    	SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
    	System.out.println("Mail paydto >>>>>>>>>>>>> "+dto);
    	HashMap<String,Integer> map = new HashMap(); 
    	map.put("memberNum", dto.getMemberNum());
    	map.put("reservationNum", dto.getReservationNum());
    	MailDTO mdto = dao.sendMail(map);
    	System.out.println("Mail Maildto >>>>>>>>>>>>> "+mdto);
    	try {
    		// 메일 받을 수신자 설정
    		simpleMailMessage.setTo(mdto.getEmail());
    		// 메일 제목 설정
   		    simpleMailMessage.setSubject("backrooms에서 보내는 예약 완료 확인 메일입니다.");
   		    //메일의 내용 설정
   		    simpleMailMessage.setText(mdto.getName()+"님, 안녕하세요.\r\n"
   		    		+ "\r\n"
   		    		+ "고객님께서 예약해주신 내역이 아래와 같이 정상적으로 완료되었습니다. 저희 "+mdto.getHotelName()+"을 선택해주셔서 감사합니다.\r\n"
   		    		+ "\r\n"
   		    		+ "==========================================================\r\n"
   		    		+ "🛎 예약 정보\r\n"
   		    		+ "\r\n"
   		    		+ "예약자명: "+mdto.getName()+"\r\n"
   		    		+ "예약번호: "+dto.getReservationNum()+"\r\n"
   		    		+ "체크인: "+mdto.getCheckIn()+"\r\n"
   		    		+ "체크아웃: "+mdto.getCheckIn()+"\r\n"
   		    		+ "객실 타입: "+mdto.getRoomName()+"\r\n"
   		    		+ "결제방법: "+dto.getPayMethod()+"\r\n"
   		    		+ "요금: "+dto.getPayment()+" (세금 및 봉사료 포함 여부 명시)\r\n"
   		    		+ "\n"
   		    		+ "📍 호텔 정보\r\n"
   		    		+ "호텔명: "+mdto.getHotelName()+"\r\n"
   		    		+ "주소: "+mdto.getHoteladdress()+"\r\n"
   		    		+ "✅ 유의사항\r\n"
   		    		+ "체크인은 3시 이후부터 가능합니다.\r\n"
   		    		+ "다시 한번 저희 호텔을 선택해주셔서 감사드리며, 편안하고 즐거운 여행 되시길 바랍니다.\r\n"
   		    		+ mdto.getHotelName()+" 드림\r\n"
   		    		+ "==========================================================\r\n");
   		    		
   		    
   		    javaMailSender.send(simpleMailMessage); 
   		    
   		    System.out.println("메일 발송 성공");
		} catch (Exception e) {
			System.out.println("메일 발송 오류"); 
			e.printStackTrace();
		}
		/*
		 * try { // 메일 받을 수신자 설정 simpleMailMessage.setTo(mail); // 메일 제목 설정
		 * simpleMailMessage.setSubject("backrooms에서 보내는 예약 완료 확인 메일입니다."); //메일의 내용 설정
		 * simpleMailMessage.setText("");
		 * 
		 * javaMailSender.send(simpleMailMessage); System.out.println("메일 발송 성공");
		 * }catch(Exception e) { System.out.println("메일 발송 오류"); e.printStackTrace(); }
		 */
    }

    public void insertPay(PayDTO dto) {
        dao.insertPay(dto);
    }

    public void updateReservationState(int reservationNum) {
        dao.updateReservationState(reservationNum);
        
    }
    
}
