package com.backrooms.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.MemberDTO;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSessionTemplate template;
	
	public MemberDTO SignIn(String memberId) {
		return template.selectOne("MemberMapper.signIn", memberId);
	}

	public int signUp(MemberDTO dto) {
		// TODO Auto-generated method stub
		int count = template.insert("MemberMapper.signUp", dto);
		return count;
	}
	public String findId(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return template.selectOne("MemberMapper.findId", map);	
	}
	public String findPW(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return template.selectOne("MemberMapper.findPw", map);	
	}

	public void updatePw(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		template.update("MemberMapper.updatePw", map);			
	}

	public void modifyProfile(HashMap<String, String> map)
	{
	    // TODO Auto-generated method stub
		template.update("MemberMapper.modifyProfile", map);				    
	}
	
}
