package com.bk.project.budget.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.budget.dto.BudgetPagingDTO;
import com.bk.project.budget.service.BudgetService;
import com.bk.project.budget.vo.BudgetExecution;
import com.bk.project.budget.vo.BudgetPlan;
import com.bk.project.department.service.DepartmentService;
import com.bk.project.financial.dto.PagingDTO;
import com.bk.project.financial.vo.Financial;
import com.bk.project.member.service.MemberService;

@Controller
public class BudgetController {

	@Autowired
	private BudgetService service;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private BudgetService budgetService;
	@Autowired
	private MemberService memberService;
	
	@ResponseBody
	@PostMapping("/insertBudgetPlan")
	public String insertBudgetPlan(BudgetPlan bp) {
	    if (service.existsByMonth(bp.getDeptNo(), bp.getBudgetMonth())) {
	        return "fail";  // 중복일 경우 등록 안 함
	    }
	    service.insertBudgetPlan(bp); // 여기서 실제 등록 실행
	    return "success";
	}
	
	
	@ResponseBody
	@PostMapping("/insertBudgetPlanModal")
	public String insertBudgetPlanModal(BudgetPlan bp) {
		  if (service.existsByMonth(bp.getDeptNo(), bp.getBudgetMonth())) {
		        return "fail";  // 중복일 경우 등록 안 함
		    }
		service.insertBudgetPlan(bp);
		return "success";
	}
	
	@GetMapping("/allBudgetPlan")
	public String allBudgetPlan(Model model, BudgetPagingDTO paging, String month) {
		// 기본값: 이번 달
		
		if (month == null || month.isEmpty()) {
			month = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));
			}
		paging.setNowMonth(month);
		int total = service.budgetCountByMonth(month);
		List<BudgetPlan> budgetList = service.budgetSelectByMonth(paging);
		
		model.addAttribute("deptList", departmentService.allDepartment());
	  	model.addAttribute("budgetList", budgetList);
	  	model.addAttribute("paging", new BudgetPagingDTO(paging.getPage(), total));
	  	model.addAttribute("selectedMonth", month);
		model.addAttribute("page", "/budgetPage/allBudgetPlan.jsp");
		
		return "common/layout";
	}
	@ResponseBody
	@PostMapping("/insertBudgetExecution")
	public String insertBudgetExecution(BudgetExecution be) {
		String result = service.insertBudgetExecution(be);
		if(result.equals("success"))
		{
			return "success";
		}
		else if(result.equals("failDate"))
		{
			return "failDate";
		}
		else if(result.equals("failAmount"))
		{
			return "failAmount";
		}
		
		return "fail";
	}
	@ResponseBody
	@PostMapping("/insertBudgetExecuteModal")
	public String insertBudgetExecuteModal(BudgetExecution be) {
		  System.out.println("👉 받은 execDate = " + be.getExecDate());
		service.insertBudgetExecution(be);
		return "success";
	}
	 @GetMapping("/executionRate")
	    @ResponseBody
	    public List<Map<String, Object>> getMonthlyBudget() {
	        return service.getMonthlyBudget();
	    }
}
