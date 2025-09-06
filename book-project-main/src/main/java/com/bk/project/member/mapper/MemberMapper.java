package com.bk.project.member.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.member.dto.MemberDTO;
import com.bk.project.member.dto.MemberPagingDTO;
import com.bk.project.member.dto.SearchDTO;
import com.bk.project.member.vo.Member;
import com.bk.project.salary.dto.SalaryPagingDTO;
import com.bk.project.salary.vo.Salary;

@Mapper
public interface MemberMapper {
	//로그인
	Member login(String username);
	//회원가입 
	Member duplicateId(String id);
	Member duplicateEmail(String email);
	int register(Member member); 

	void updateInfo(Member member);
	
	List<Member> allMember(MemberPagingDTO paging);
	
	List<Member> searchMember(MemberPagingDTO paging);
	
	Member updateMember(Member member);
	
	Member test(Member member);
	
	Member findMemberNo(int memberNo);
	
	Member getMemberInfo(String id);
	int total();
	
	List<MemberDTO> searchMemberModal(String keyword);
	//연차
	List<Member> allMembers();
	
	int searchTotal(SearchDTO dto);
	
	
	
	//퇴사 테이블 추가
//	int addQuitMember(Member member);
//	AttendanceInfo getAttendanceInfo(int memberNo);
//	Payroll getPayRoll(int memberNo);
//	Salary getSalary(int memberNo);
//	
//	int qultMember(int memberNo);
}
