package com.backrooms.service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.backrooms.dao.HotelSearchDAO;
import com.backrooms.dto.SeachResultDTO;
import com.backrooms.dto.SearchArrDTO;
import com.backrooms.dto.SearchCheckDTO;

@Service
public class HotelSearchService {
	@Autowired
	private HotelSearchDAO dao;

	public List<SeachResultDTO> getAvailableRooms(SearchCheckDTO map) {
		return dao.getAvailableRooms(map);
	}

	public String replace_date(String[] s) {
		String t = s[0];
    	String tt = s[1];
    	s[0] = s[2];
    	s[1] = t;
    	s[2] = tt;
    	
    	String result="";
    	for(int i=0;i<s.length;i++) {
    		result+=s[i];
    	}
    	return result;
	}
	public List<String> HotelName(List<SeachResultDTO> list){
		List<String> hotel = new ArrayList<String>();
		for(int i=0; i<list.size();i++) {
			SeachResultDTO dto = list.get(i);
			String name = dto.getHotelName();
			if(hotel.size() == 0) {
				hotel.add(name);
			}else {
				int n = 1;
				for(int j=0;j<hotel.size();j++) {
					String str = hotel.get(j);
					if(str.equals(name)) {
						n=0;
					}
				}
				if(n == 1) {
					hotel.add(name);
				}
			}
		}
		return hotel;
	}
	public List<SearchArrDTO> DataProcess(List<SeachResultDTO> list) {
		List<SearchArrDTO> result = new ArrayList<SearchArrDTO>();
		List<String> hotel = HotelName(list);
		
		for(int i=0;i<hotel.size();i++){
      		String rnum ="";
      		String hprice  ="";
      		int grade=0;
      		int hnum =0;
      		double rating = 0;
      		String name = hotel.get(i);
      		for(int j=0; j<list.size();j++) {
      			SeachResultDTO arr = list.get(j);
      			String hname = arr.getHotelName();
      			if(name.equals(hname)) {
      				hprice += arr.getRoomPrice()+"/";
      				rating = arr.getHotelRating();
      				grade = arr.getHotelGrade();
      				hnum = arr.getHotelNum();
      			}
      		}
      		String[] p = hprice.split("/");
      		
      		for (int k= 0; k<p.length-1;k++) {
      			int one = Integer.parseInt(p[k]);
      			for(int j = k; j<p.length; j++) {
      				int two = Integer.parseInt(p[j]);
      				if(one>two) {
      					int t = one;
      					one = two;
      					two = t;
      				}
      			}
      		}
      		// DecimalFormat을 활용한 포멧 형식 선언
      		DecimalFormat df = new DecimalFormat("#,###원");
      		int one = Integer.parseInt(p[0]);
      		int two = Integer.parseInt(p[p.length-1]);
      		String price=df.format(one)+"~"+df.format(two);
      		
      		SearchArrDTO dto = new SearchArrDTO(name,price,hnum,grade,rating);
      		result.add(i, dto);
      		
		}
		return result;
	}

	public List<SeachResultDTO> conditionValue(List<SeachResultDTO> list, Map<String, String> map) {
		ArrayList<SeachResultDTO> result = new ArrayList<SeachResultDTO>();
		if(map.containsKey("grade")) {
	      	for(int i=0;i<list.size();i++){
	     		int r = list.get(i).getHotelGrade();
	     		int value = Integer.parseInt(map.get("grade"));
	      		if(r == value) {
	      			result.add(list.get(i));
	      		}
	      	}
		}else if(map.containsKey("star")) {
			for(int i=0;i<list.size();i++){
	     		Double r = list.get(i).getHotelRating();
	     		Double value = Double.valueOf(map.get("star"));
	      		if(r >= value) {
	      			result.add(list.get(i));
	      		}
			}
		}
		return result;
	}

	public ModelAndView send(ModelAndView mav, List<SeachResultDTO> list, SearchCheckDTO chDTO) {
		List<SearchArrDTO> dto = DataProcess(list);
		mav.addObject("hotelList", dto);
		mav.addObject("condition",chDTO);
		return mav;
	}
}
