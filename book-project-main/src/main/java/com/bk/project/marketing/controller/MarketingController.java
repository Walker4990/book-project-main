package com.bk.project.marketing.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.claim.dto.ClaimPagingDTO;
import com.bk.project.claim.vo.Claim;
import com.bk.project.marketing.dto.MarketingDTO;
import com.bk.project.marketing.dto.PagingDTO;
import com.bk.project.marketing.service.MarketingService;
import com.bk.project.marketing.vo.Marketing;
import com.bk.project.marketing.vo.MarketingExpired;
import com.bk.project.member.vo.Member;
import com.bk.project.salary.dto.SalaryPagingDTO;
import com.bk.project.salary.vo.Salary;


@Controller
public class MarketingController {

	@Autowired
	private MarketingService service;
	
	//마케팅 등록
	@ResponseBody
	@PostMapping("/newMarketing")
	public String newMarketing(Marketing marketing)
	{
		System.out.println("createdBy = " + marketing.getCreatedBy());
		System.out.println("department = " + marketing.getDepartment());
		
		Member m = service.checkManager(marketing);
		if(m == null)
		{
			System.out.println("담당 직원이 존재하지 않습니다.");
			return "notMem";
		}
		
		
		LocalDate startDate = marketing.getDurationStart();
		LocalDate endDate = marketing.getDurationEnd();
		if(startDate.isAfter(endDate))
		{
			System.out.println("시작 날짜는 종료 날짜보다 이전이어야 합니다.");
			return "dateError";
		}
		
		
		
		int check = service.newMarketing(marketing);
		if(check > 0)
		{
			return "success";
		}
		return "fail";
	}

	/*
	// 전체 조회
	@GetMapping("/allMarketing")
	public String allMarketing(Model model, MarketingDTO dto)
	{
		model.addAttribute("marketingList",service.allMarketing(dto));
		model.addAttribute("page", "marketingPage/allMarketing.jsp");
		return "common/layout"; 
	}
*/

	@ResponseBody
	@PostMapping("updateMarketing")
	public String updateMarketing(Marketing marketing) {
		Member m = service.checkManager(marketing);
		if(m == null)
		{
			System.out.println("담당 직원이 존재하지 않습니다.");
			return "notMem";
		}
		int result = service.updateMarketing(marketing);
		if(result > 0) return "success";
		else return "fail";
	}

	// 정보 삭제
		@ResponseBody
		@PostMapping("/deleteMarketing")
		public String deleteMarketing(int eventNo)
		{
			
			int result = service.deleteMarketing(eventNo);
			if(result > 0) return "success";
			else return "fail";
		}
		
		@GetMapping("/allMarketing")
		public String allMarketing(Model model, PagingDTO paging) {
			   int total;
			   if (paging.getKeyword() != null && !paging.getKeyword().trim().isEmpty()) {
			        total = service.total(paging);
			    } else {
			        total = service.totalAll();
			    }

			    PagingDTO fixedPaging = new PagingDTO(paging.getPage(), total);
			    fixedPaging.setKeyword(paging.getKeyword());
			    fixedPaging.setSelect(paging.getSelect());

			    List<MarketingDTO> marketingList;
			    if (paging.getKeyword() != null && !paging.getKeyword().isEmpty()) {
			        marketingList = service.searchMarketing(fixedPaging);
			    } else {
			        marketingList = service.allMarketing(fixedPaging);
			    }

			    model.addAttribute("marketingList", marketingList);
			    model.addAttribute("paging", fixedPaging);
			    model.addAttribute("page", "marketingPage/allMarketing.jsp");
			    model.addAttribute("param", paging);
			return "common/layout"; 
		}
		
		@GetMapping("/marketingExpiredList")
		 public String marketingExpiredList(Model model, PagingDTO paging) {
			 int total;
			 if(paging.getKeyword() !=null && paging.getKeyword().isEmpty()) {
				 total = service.countMarketingExpired(paging);
			 }else {
				 total = service.countAllMarketingExpired();
			 }
			 PagingDTO fixedPaging = new PagingDTO(paging.getPage(), total);
			 fixedPaging.setKeyword(paging.getKeyword());
			 
			 List<MarketingExpired> expiredList;
			 if(paging.getKeyword() !=null && paging.getKeyword().isEmpty()) {
				 expiredList = service.searchMarketingExpired(fixedPaging);
			 } else {
				 expiredList = service.allMarketingExpiredList(fixedPaging);
			 }
			 model.addAttribute("expiredList", expiredList);
			 model.addAttribute("page", "marketingPage/marketingExpiredList.jsp");
			 model.addAttribute("paging", fixedPaging);
			 model.addAttribute("param", paging);
			 
			return "common/layout"; 
		   }
		
		
		@GetMapping("/SearchmarketingExpiredList")
		public String SearchmarketingExpiredList(Model model, PagingDTO paging)
		{
			List<MarketingDTO> marketingList = service.allMarketingExpired(paging);
			int total = service.total(paging);
			model.addAttribute("marketingList", marketingList);
			model.addAttribute("paging", new PagingDTO(paging.getPage(), total));
			model.addAttribute("page", "marketingPage/marketingExpiredList.jsp");
			return "common/layout";
		}
		
		@ResponseBody
		@GetMapping("/getMarketing")
		public Marketing getMarketing(int eventNo) {
			return service.getMarketingByNo(eventNo);
		}
	
	
}
