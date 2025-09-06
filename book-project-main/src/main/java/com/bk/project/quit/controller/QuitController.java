package com.bk.project.quit.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.attendance.vo.Attendance;
import com.bk.project.attendance.vo.AttendanceInfo;
import com.bk.project.attendance.vo.AttendanceSave;
import com.bk.project.evaluation.vo.Evaluation;
import com.bk.project.member.service.MemberService;
import com.bk.project.member.vo.Member;
import com.bk.project.payroll.vo.Payroll;
import com.bk.project.quit.dto.QuitDTO;
import com.bk.project.quit.dto.QuitPagingDTO;
import com.bk.project.quit.service.QuitService;
import com.bk.project.quit.vo.Quit;
import com.bk.project.request.vo.Request;
import com.bk.project.salary.vo.Salary;

@Controller
public class QuitController {

	@Autowired
	private QuitService service;
	
	
	@GetMapping("/allQuit")
	public String allQuit(Model model, QuitPagingDTO paging)
	{
		System.out.println("paging : "+ paging);
		List<QuitDTO> quitList;
		int total = service.total(paging);
		if(paging.getKeyword() == null || paging.getKeyword().trim().isEmpty())
		{
			quitList = service.allQuit(paging);
		}
		else
		{
			quitList = service.searchQuit(paging);
		}
		System.out.println("list : "+ quitList);
		model.addAttribute("quitList",quitList);
	    model.addAttribute("page", "quitPage/allQuit.jsp");
	    model.addAttribute("paging", new QuitPagingDTO(paging.getPage(), total));
	    return "common/layout";
	}
	
	
	//퇴사 사원 테이블에 추가
	public int addQuit(int m)
	{
		//퇴사 날짜 : 버튼 클릭한 순간
		LocalDate date = LocalDate.now();
		//멤버 정보 가져오기
		Member member = service.findMemberNo(m);
		AttendanceInfo info = service.getAttendanceInfo(m);
		Salary salary = service.getSalary(m);
		
		//quit값 집어넣기
		Quit quitMember = new Quit();
		quitMember.setDeptNo(member.getDeptNo());
		quitMember.setName(member.getName());
		quitMember.setPosition(member.getPosition());
		quitMember.setAddr(member.getAddr());
		quitMember.setEmail(member.getEmail());
		quitMember.setJoinDate(member.getJoinDate());
		quitMember.setQuitDate(date);
		if(salary != null)
		{
			quitMember.setOtRate(salary.getOtRate());
			quitMember.setBaseSalary(salary.getBaseSalary());
			quitMember.setPositionAllowance(salary.getPositionAllowance());
			quitMember.setTax(salary.getTax());
			quitMember.setTotalSalary(salary.getTotalSalary());
			quitMember.setBonus(salary.getBonus());
		}
		if(info != null)
		{
			quitMember.setAttendance(info.getAttendance());
		}
		
		System.out.println(quitMember);
		
		return service.addQuitMember(quitMember);
		
	}

	
	
	//퇴사 등록
		@Transactional
		@ResponseBody
		@PostMapping("/quitMember")
		public String quitMember(@RequestBody List<Integer> memberNo)
		{
			
			System.out.println(memberNo);
			for(Integer m: memberNo)
			{
				//테이블 투가
				int addCheck = addQuit(m);
				int deleteCheck = 0;
				if(addCheck > 0)
				{
					deleteCheck = service.quitMember(m);
				}
				else {
					System.out.println("추가 실패");
				}
				
				if(addCheck <= 0 || deleteCheck <= 0)
				{
					System.out.println("삭제 실패");
					return "fail";
				}
				
			}
			return "success";
		}
}
