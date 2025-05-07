package com.backrooms.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backrooms.dao.MemberDAO;
import com.backrooms.dto.MemberDTO;
import com.util.Utility;

@Service
public class MemberService {
	@Autowired
	MemberDAO dao;
	public MemberDTO signIn(String memberId, String passwd){		
	 var dto = dao.SignIn(memberId);
	 if(dto==null) return null;
	 
	 
	 if(passwd.equals(dto.getPasswd()) == false) {
		 return null;
	 }
	 return dto;
	}
	public int signUp(MemberDTO dto)
	{
		int count = dao.signUp(dto);
		return count;
	}
	public String findAccount(HashMap<String, String> map)
	{
		if(map.get("memberId") == null)
		{
			return findId(map);
		}
		return findPw(map);
	}
	
	public String findId(HashMap<String, String> map)
	{
		String memberId = dao.findId(map);
		
		return memberId;
		
	}
	public String findPw(HashMap<String, String> map)
	{
		String password = dao.findPW(map);
		return password;
	}
	public void updatePw(HashMap<String, String> map)
	{
		dao.updatePw(map);
	}

	public void modifyProfile(HashMap<String, String> map)
	{
	    // TODO Auto-generated method stub
	    dao.modifyProfile(map);
	}
	
}
