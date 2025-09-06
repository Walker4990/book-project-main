package com.bk.project.taxPayment.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.contract.dto.ContractPagingDTO;
import com.bk.project.financial.vo.Financial;
import com.bk.project.tax.vo.Tax;
import com.bk.project.taxPayment.dto.TaxPagingDTO;
import com.bk.project.taxPayment.service.TaxPaymentService;
import com.bk.project.taxPayment.vo.TaxPayment;

@Controller
public class TaxPaymentController {

	@Autowired
	private TaxPaymentService service;
	
	@GetMapping("/insertTaxPayment")
	public String insertTaxPayment(Model model) {
		model.addAttribute("unpaidTaxes", service.selectUnpaidTaxes());
		model.addAttribute("page", "taxPage/insertTaxPayment.jsp");
		
		return "common/layout";
	}
	@ResponseBody
	@PostMapping("/insertTaxPayment")
	public String insertTaxpayment(TaxPayment tp) {
		//전체 금액
		Tax tax = service.selectOneUnpaidTaxes(tp.getTaxNo());
		System.out.println("tax : "+ tax);
		//지금까지 낸 금액
		int total =tp.getAmount();
		System.out.println("total : "+ total);

		//만약 전체 납부할 금액이 남은 금액 보다 크면
		if(total > tax.getRemainingAmount())
		{
			return "overfullAmount";
		}
		
		
		int result = service.insertTaxPayment(tp);
		if(result > 0)
		{
			return "success";
		}
		
		return "fail";
	}
	
	
	@GetMapping("/taxPaidList")
	public String selectPaidTaxes(Model model, TaxPagingDTO paging, String month) {
		int total;
		if(month != null) {
			total = service.countSearchTaxPaidList(month);
		} else {
			total = service.countAllTaxPaidList();
		}
		
		TaxPagingDTO fixedPaging = new TaxPagingDTO(paging.getPage(), total);
		fixedPaging.setMonth(month);
		
		List<TaxPayment> taxList;
		if (month != null) {
			taxList = service.searchTaxPaidList(fixedPaging);
		} else {
			taxList = service.allTaxPaidList(fixedPaging);
		}
		model.addAttribute("unpaidTaxes", service.selectUnpaidTaxes());
		model.addAttribute("taxList", taxList);
		model.addAttribute("paging", new TaxPagingDTO(paging.getPage(), total));
		model.addAttribute("page", "taxPage/taxPaidList.jsp");
		model.addAttribute("selectedMonth", month);
		return "common/layout";
	}
}
