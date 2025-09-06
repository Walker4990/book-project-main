package com.bk.project.financial.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.financial.dto.PagingDTO;
import com.bk.project.financial.service.FinancialService;
import com.bk.project.financial.vo.Financial;

@Controller

public class FinancialController {

	@Autowired
	private FinancialService service;

	@GetMapping("/revenue")
	public String revenueSelect(
	        Model model,
	        @RequestParam(value="revenuePage", defaultValue="1") int revenuePage,
	        @RequestParam(value="expensePage", defaultValue="1") int expensePage,
	        String month, String months) {
	    
	    if(month == null || month.isEmpty()) {
	        month = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));
	    }

	    // 수입 
	    PagingDTO revenuePaging = new PagingDTO(revenuePage, service.revenueCountByMonth(month));
	    revenuePaging.setIsMonth(month);

	    if(months == null || months.isEmpty()) {
	        months = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));
	    }

	    // 지출 
	    PagingDTO expensePaging = new PagingDTO(expensePage, service.expenseCountByMonth(months));
	    expensePaging.setIsMonth(months);

	    model.addAttribute("revenuepaging", revenuePaging);
	    model.addAttribute("expensepaging", expensePaging);
	    model.addAttribute("revenueList", service.revenueSelectByMonth(revenuePaging));
	    model.addAttribute("expenseList", service.expenseSelectByMonth(expensePaging, months));
	    model.addAttribute("selectedMonth", month);
	    model.addAttribute("selectMonth", months);

	    model.addAttribute("page", "/financialPage/revenue.jsp");
	    return "common/layout";
	}
	

		// 월별 수익/지출 JSON 반환
	    @GetMapping("/monthly")
	    @ResponseBody
	    public List<Map<String, Object>> getMonthlyFinance() {
	        return service.getMonthlyFinance();
	}
}
