package com.bk.project.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.bk.project.member.dto.MemberDTO;
import com.bk.project.member.dto.MemberPagingDTO;
import com.bk.project.member.dto.SearchDTO;
import com.bk.project.member.mapper.MemberMapper;
import com.bk.project.member.vo.Member;

@Service
public class MemberService implements UserDetailsService{

	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private PasswordEncoder bcpe;

	// 회원가입
	public boolean duplicateId(String id) {
		return mapper.duplicateId(id) != null;
	}

	public boolean duplicateEmail(String email) {
		return mapper.duplicateEmail(email) != null;
	}

	public int register(Member member) {
		
		System.out.println("암호화 전 : "+ member.getPassword());
		System.out.println("암호화 후 : "+ bcpe.encode(member.getPassword()));
		member.setPassword(bcpe.encode(member.getPassword()));
		
		return mapper.register(member);
	}

	// 로그인
	public Member login(Member member) {
		System.out.println("service: bcpe 들어옴");
		
		Member vo = mapper.login(member.getUsername());
		System.out.println("vo : "+ vo);
		System.out.println("member : "+ member.getPassword());
		System.out.println("vo : "+ vo.getPassword());
		if(vo!=null && bcpe.matches(member.getPassword(), vo.getPassword()))
		{
			System.out.println("Service : " + vo);
			return vo;
		}
		System.out.println("bcpe 작동 안함");
		return null;
	}


	// 회원 정보 수정
	public void updateInfo(Member member) {
		
		member.setPassword(bcpe.encode(member.getPassword()));
		System.out.println("주소 : "+member.getAddr());
		System.out.println("비번 : "+member.getPassword());
		System.out.println("이메일 : "+member.getEmail());
		mapper.updateInfo(member);
	}
	
	// 사원 전체 조회
	public List<Member> allMember(MemberPagingDTO paging) {
		return mapper.allMember(paging);
	}
	

	
	// 사원 선택 조회
	public List<Member> searchMember(MemberPagingDTO paging){
		return mapper.searchMember(paging);
	}
	// 업데이트 후 사원 조회
	public Member updateMember(Member member)
	{
		return mapper.updateMember(member);
	}
	
	public Member test(Member member)
	{
		return mapper.test(member);
	}
	
	// 품의서 등록 시 멤버 이름 가져오기
	public Member findMemberNo(int memberNo) {
		return mapper.findMemberNo(memberNo);
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("username = "+username);
		
		//유저가 넘어오는지 확인
		  if (username == null || username.isBlank()) {
		        throw new UsernameNotFoundException("Username is null or empty");
		    }
		
		Member member = mapper.login(username);
		 if (member == null) {
		        throw new UsernameNotFoundException("User not found with username: " + username);
		    }
		
		
		System.out.println("member : "+ member);
		return member;
	}
	
	public Member getMemberInfo(String id)
	{
		return mapper.getMemberInfo(id);
	}	
	public int total() {
		return mapper.total();
	}
	
	
	public List<Member> pagingMember(MemberPagingDTO paging) {
	    return mapper.allMember(paging); // LIMIT #{offset}, #{limit} 사용
	}
	
	
	public List<Member> allMembers(){
		return mapper.allMembers();
	}
	
	public List<MemberDTO> searchMemberModal(String keyword){
		return mapper.searchMemberModal(keyword);
	}
	
	public int searchTotal(SearchDTO dto) {
		return mapper.searchTotal(dto);
	}
}
