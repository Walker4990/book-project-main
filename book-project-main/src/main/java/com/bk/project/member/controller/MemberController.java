package com.bk.project.member.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.attendance.service.AttendanceService;
import com.bk.project.attendance.vo.AttendanceInfo;
import com.bk.project.member.config.TokenProvider;
import com.bk.project.member.dto.MemberDTO;
import com.bk.project.member.dto.MemberPagingDTO;
import com.bk.project.member.dto.SearchDTO;
import com.bk.project.member.service.MemberService;
import com.bk.project.member.vo.Member;
import com.bk.project.payroll.vo.Payroll;
import com.bk.project.salary.vo.Salary;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	@Autowired
	private TokenProvider tokenProvider;
	
	@Autowired
	private AttendanceService attendanceService;
	
	@GetMapping("/admin")
	public void admin() {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Member member = (Member) auth.getPrincipal();
		System.out.println(member);
		
	}
	
	
	//회원가입
	
	@ResponseBody
	@PostMapping("/register")
	public String register(Member member) {
		
	    boolean emailCheck = service.duplicateEmail(member.getEmail());
	    boolean idCheck = service.duplicateId(member.getId());

	    if (idCheck || emailCheck) {
	        return "duplicate";
	    }
	    service.register(member);
	    //출퇴근 정보 기록
	    
	    //attendance, attendance_info, attendance_save생성
	    Member attendanceMem = service.getMemberInfo(member.getId());
	    int result = attendanceService.addAttendanceInfo(attendanceMem.getMemberNo());
	    if(result >0)
	    {
	    	return "success";
	    }
	    
	    return "fail";
	}
	//회원 정보 수정
	@ResponseBody
	@PostMapping("/updateInfo")
	public String updateInfo(Member member, String newPwd, String newPwdCheck,HttpServletRequest request) {
		if(!newPwd.equals(newPwdCheck)) {
		return "differentPwd";
		} 
		boolean check = service.duplicateEmail(member.getEmail());
		if(check)
		{
			System.out.println();
			return "sameEmail";
		}
		 Member m = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		 
		
		member.setPassword(newPwd);
		service.updateInfo(member);
		
		Member updateMember = service.updateMember(member);
		//세션 강제 종료
		 SecurityContextHolder.clearContext();
		
		return "success";
	}
	
	
	@ResponseBody
	@GetMapping("/getMember")
	public Member getMemberNo() {
	    Member m = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    if (m == null) {
	        // 로그인 안 된 상태일 때는 -1 반환
	        return null;
	    }
	    
	    return m;
	}
	
	@GetMapping("/allMember")
	public String allMember(MemberPagingDTO paging, Model model, SearchDTO dto, String keyword) {
	    List<Member> list;
	    int total;
	
	    
	    if (dto.getKeyword() == null || dto.getKeyword().trim().isEmpty()) {
	        // 전체 목록
	        total = service.total();
	        list = service.pagingMember(paging);
	    } else {
	        // 검색 (페이징 적용)
	        total = service.searchTotal(dto); // 검색된 총 건수
	        list = service.searchMember(paging); // 페이징된 검색 결과
	    }

	    model.addAttribute("list", list);
	    model.addAttribute("page", "memberPage/allMember.jsp");
	    model.addAttribute("paging", new MemberPagingDTO(paging.getPage(), total));
	    model.addAttribute("param", dto); // 검색 유지용
	 
	    return "common/layout";
	}

		@GetMapping("/searchMember")
		@ResponseBody
		public List<MemberDTO> searchMemberModal(@RequestParam("keyword") String keyword, Model model) {
		    return service.searchMemberModal(keyword);
		 
		}
	




	
	
	
	
}
