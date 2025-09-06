package com.bk.project.partner.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.book.vo.Book;
import com.bk.project.contract.vo.Contract;
import com.bk.project.partner.dto.PartnerPagingDTO;
import com.bk.project.partner.service.PartnerService;
import com.bk.project.partner.vo.Partner;
import com.bk.project.printorder.vo.PrintOrder;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PartnerController {

	@Autowired
	private PartnerService service;

	//수정 버튼클릭 시 클릭한 라디오 버튼의 값과 함께 이동
	@GetMapping("/updatePartner")
	public String selectUpdate(int partnerNo, Model model) {
		System.out.println(partnerNo);
		Partner partnerVO = service.selectUpdate(partnerNo);
		model.addAttribute("partner", partnerVO); 
		
		System.out.println(partnerVO.getEndDate());
		model.addAttribute("page", "/partnerPage/updatePartner.jsp");
		return "common/layout";
		
		//return "page/partnerPage/updatePartner";
	}
	

	private boolean isValidPartner(Partner partner) {
	    LocalDate startDate     = partner.getStartDate();
	    LocalDate endDate       = partner.getEndDate();
	  

	    if (startDate != null && endDate != null && startDate.isAfter(endDate)) return false;
	  
	    return true;
	}
	
	@ResponseBody
	@PostMapping("/newPartner")
	public String newPartner(Partner partner)
	{
		if(!isValidPartner(partner)) {
			return "fail";
		}
		
		int result = service.newPartner(partner);
		return result>0 ? "success" : "fail";
		
	}


	
	@GetMapping("/allPartner")
	public String searchPartner(PartnerPagingDTO paging, Model model)
	{
		List<Partner> partnerList = service.searchPartner(paging);
		int total = service.countPartner(paging);
		
		model.addAttribute("partnerList", partnerList);
		model.addAttribute("paging", new PartnerPagingDTO(paging.getPage(), total));		
		model.addAttribute("page", "partnerPage/allPartner.jsp");
		   System.out.println("======= 파라미터 =======");
		    System.out.println(paging);
		return "common/layout";
		//return "/page/partnerPage/allPartner";
	}
	
	@ResponseBody
	@PostMapping("/deletePartner")
	public String deletePartner(int partnerNo)
	{
		System.out.println(partnerNo);
		int isDelete = service.deletePartner(partnerNo);
		if(isDelete>0)
		{
			return "success";
		}
		return "fail";
	}
	
	@ResponseBody
	@PostMapping("/updatePartner")
	public String updatePartner(Partner partner)
	{
		int result = service.updatePartner(partner);
		if(result >= 0)
		{
			return "success";
		}
		return "fail";
	}
	
	@ResponseBody
	@GetMapping("/getPartner")
	public Partner getPartner (int partnerNo) {
	    return service.getPartner(partnerNo);
	}
}
