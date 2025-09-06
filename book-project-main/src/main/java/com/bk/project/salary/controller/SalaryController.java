package com.bk.project.salary.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bk.project.book.controller.BookController;
import com.bk.project.member.dto.MemberDTO;
import com.bk.project.member.service.MemberService;
import com.bk.project.member.vo.Member;
import com.bk.project.salary.dto.SalaryForm;
import com.bk.project.salary.dto.SalaryPagingDTO;
import com.bk.project.salary.service.SalaryService;
import com.bk.project.salary.vo.Salary;



@Controller
public class SalaryController {
	

	@Autowired
	private MemberService memberService;
	@Autowired
	private SalaryService service;

   
	@GetMapping("/newSalary")
	public String newSalary(Model model, SalaryPagingDTO paging) {
		 int total;
		    if (paging.getKeyword() != null && !paging.getKeyword().trim().isEmpty()) {
		        total = service.total(paging);
		    } else {
		        total = service.totalAll();
		    }

		    SalaryPagingDTO fixedPaging = new SalaryPagingDTO(paging.getPage(), total);
		    fixedPaging.setKeyword(paging.getKeyword());  // ✅ 중요
		    fixedPaging.setSelect(paging.getSelect());
		    
		    List<Salary> memberList;
		    if (paging.getKeyword() != null && !paging.getKeyword().trim().isEmpty()) {
		        memberList = service.searchSalary(fixedPaging);
		    } else {
		        memberList = service.allSalary(fixedPaging); // ✅ 페이징 적용
		    }
		    System.out.println("memberList size: " + memberList.size());
		    for(Salary s : memberList){
		        System.out.println(s.getMemberNo() + " / " + s.getName());
		    }
		    model.addAttribute("memberList", memberList);
		    model.addAttribute("page", "salaryPage/newSalary.jsp");
		    model.addAttribute("paging", fixedPaging);
		    model.addAttribute("param", paging);
	    
		return "common/layout";
	}
	
	
	
	
	@PostMapping("/insertSalary")
	public String insertSalary(@ModelAttribute SalaryForm form,
            RedirectAttributes rttr, Model model) {
		for (Salary s : form.getMemberList()) {
	        System.out.println("넘어온 memberNo=" + s.getMemberNo() + ", bonus=" + s.getBonus());
	    }
		boolean ok = service.insertSalary(form.getMemberList()); // service가 넘어온 bonus/otRate로 계산
		rttr.addAttribute("result", ok ? "success" : "fail");
		model.addAttribute("page", "salaryPage/newSalary.jsp");
		return "common/layout";
	}
	
	
//	@GetMapping("/searchSalary")
//	public String allSalary(Model model) {
//	    List<Salary> salaryList = service.allSalary();
//	    model.addAttribute("salaryList", salaryList);
//	    model.addAttribute("page", "salaryPage/allSalary.jsp");
//	    return "common/layout";
//	}
	
	@GetMapping("/updateSalary")
	public String updateSalary(Model model, int salaryNo) {
		model.addAttribute("salary", service.getSalaryByNo(salaryNo));
		model.addAttribute("page", "salaryPage/updateSalary.jsp");
		return "common/layout";
	}
	
	
	@PostMapping("/updateSalary")
	public String updateSalary(Salary s) {
		System.out.println("들어온 정보 : "+ s);
		service.updateSalary(s);
		return "success";
	}
	
	@ResponseBody
	@PostMapping("/deleteSalary")
	public String deleteSalary(int salaryNo) {
    int result = service.deleteSalary(salaryNo);
	if(result > 0) return "success";
	else return "fail";
	}
	
	// 급여 1건 조회(모달 오픈 시 사용)
	@ResponseBody
	@GetMapping("/getSalary")
	public Salary getSalary(int salaryNo) {
	    return service.getSalaryByNo(salaryNo);
	}

	// 모달 저장 (AJAX)
	@ResponseBody
	@PostMapping("/editSalaryAtNewSalary")
	public String updateSalaryAjax(Salary s) {
		System.out.println("들어온 정보 : "+ s);
	    try {
	        int updated = service.updateSalary(s);
	        return updated > 0 ? "success" : "fail";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
	    }
	}

	
}
