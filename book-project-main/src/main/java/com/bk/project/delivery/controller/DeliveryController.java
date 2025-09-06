package com.bk.project.delivery.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.contract.vo.Contract;
import com.bk.project.delivery.dto.DeliveryPagingDTO;
import com.bk.project.delivery.service.DeliveryService;
import com.bk.project.delivery.vo.Delivery;
import com.bk.project.taxPayment.dto.TaxPagingDTO;

@Controller
public class DeliveryController {

	@Autowired 
	private DeliveryService service;
	
	
	@ResponseBody
	@PostMapping("/newDelivery")
	public String newDelivery(Delivery delivery)
	{
		
		int result = service.newDelivery(delivery);
		if(result > 0) {
			return "success";
		}else if(result == -3)
		{
			return "duplicate";
		}
		else {
			return "fail";
		}
	}
	
	
//	//전체 조회
//	@GetMapping("/searchDelivery")
//	public String printAllDelivery(Model model, DeliveryDTO dto)
//	{
//		if(dto.getKeyword() == null || dto.getKeyword() == "")
//		{
//			model.addAttribute("deliveryList", service.allDelivery());
//		}
//		else {
//			model.addAttribute("deliveryList", service.searchDelivery(dto.getKeyword()));
//		}
//		model.addAttribute("page", "/deliveryPage/allDelivery.jsp");
//		
//		return "common/layout";
//		//return "/page/deliveryPage/allDelivery";
//	}
	
	
	
	// 정보 삭제
	@ResponseBody
	@PostMapping("/deleteDelivery")
	public String deleteDelivery(int deliveryNo)
	{
		
		int result = service.deleteDelivery(deliveryNo);
		if(result > 0) return "success";
		else return "fail";
	}
	
	
	@ResponseBody
	@PostMapping("/updateDelivery")
	public String updateDelivery(Delivery delivery) {
		int result = service.updateDelivery(delivery);
		if(result > 0) return "success";
		else return "fail";
	}
	

	@GetMapping("/allDelivery")
	public String printAllDelivery(Model model, DeliveryPagingDTO paging) {
	    List<Delivery> list = service.searchDelivery(paging);
	    int total = service.countDelivery(paging);

	    model.addAttribute("page", "/deliveryPage/allDelivery.jsp");
	    model.addAttribute("deliveryList", list);
	    model.addAttribute("paging", new DeliveryPagingDTO(paging.getPage(), total));
	    model.addAttribute("param", paging);

	    return "common/layout";
	}
	
	@ResponseBody
	@GetMapping("/getDelivery")
	public Delivery getDelivery (int deliveryNo) {
		return service.getDeliveryByNo(deliveryNo);
	}
	


	
	
}
