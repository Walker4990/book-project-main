package com.bk.project.payroll.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.payroll.dto.PayrollPagingDTO;
import com.bk.project.payroll.service.PayrollService;
import com.bk.project.payroll.vo.Payroll;
import com.bk.project.salary.service.SalaryService;
import com.bk.project.salary.vo.Salary;

@Controller
public class PayrollController {

	@Autowired
	private PayrollService service;
	
	@Autowired
	private SalaryService salService;
	
	@GetMapping("/insertPayroll")
	public String insertPayroll(Model model, PayrollPagingDTO paging) {
		int total = service.countAll();
	    PayrollPagingDTO fixedPaging = new PayrollPagingDTO(paging.getPage(), total);

	    List<Salary> salaryList = service.getLatestSalaryList(fixedPaging);
	    model.addAttribute("paging", fixedPaging);
	    model.addAttribute("salaryList", salaryList);
	    model.addAttribute("page", "payrollPage/insertPayroll.jsp");
	    return "common/layout";
	}
	
	@ResponseBody
	@PostMapping("/insertPayroll")
	public String insertPayroll(@RequestBody List<Payroll> list, Model model) {
	    boolean success = service.insertPayroll(list);
        if (!success) {
            return "이미 이번 달 급여가 지급되었습니다.";
        }
        return "급여가 정상 지급되었습니다.";
	}
		
	}

