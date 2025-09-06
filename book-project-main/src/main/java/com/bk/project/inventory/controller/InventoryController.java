package com.bk.project.inventory.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.book.service.BookService;
import com.bk.project.book.vo.Book;
import com.bk.project.delivery.service.DeliveryService;
import com.bk.project.delivery.vo.Delivery;
import com.bk.project.inventory.dto.InventoryDTO;
import com.bk.project.inventory.service.InventoryService;
import com.bk.project.inventory.vo.Inventory;
import com.bk.project.partner.service.PartnerService;
import com.bk.project.partner.vo.Partner;
import com.bk.project.printorder.vo.PrintOrder;

@Controller
public class InventoryController { 

	@Autowired
	private InventoryService service;
	
	
	
	
	
//	@PostMapping("/newOutInven")
//	@ResponseBody
//	public String outInventory(@RequestBody List<Inventory> outList) {
//	    boolean result = service.insertInven(outList);
//	    if (!result) return "fail";
//	    return "success";
//	}
	@ResponseBody
	@GetMapping("/allInven")
	public String allInven(Model model, InventoryDTO paging) {
		int total;
		if(paging.getKeyword()!=null && !paging.getKeyword().isEmpty()) {
			total = service.countInventory(paging);
		} else {
			total = service.countAllInventory();
		}
		
		InventoryDTO fixedPaging = new InventoryDTO(paging.getPage(), total);
		fixedPaging.setKeyword(paging.getKeyword());
		fixedPaging.setSelect(paging.getSelect());
		
		List<Inventory> invenList;
		if(paging.getKeyword()!=null && !paging.getKeyword().isEmpty()) {
			invenList = service.searchInventory(fixedPaging);
		} else {
			invenList = service.allInventory(fixedPaging);
		}
		model.addAttribute("paging", fixedPaging);
		model.addAttribute("param", paging);
		model.addAttribute("page", "invenPage/allInven.jsp");
		model.addAttribute("invenList", invenList);
		
		return "common/layout";
		
		//return "/page/invenPage/allInven";
	}
	
	@PostMapping("/searchInven")
	public String searchInven(InventoryDTO dto, Model model) {
		List<Inventory> list = new ArrayList<>();
		String select = dto.getSelect();
		String keyword = dto.getKeyword();
		
		if(keyword == null || keyword.trim().isEmpty()) {
			list = service.allInven();
		} else {
			list = service.searchInvenTest(dto);
		}
		model.addAttribute("page", "/invenPage/allInven.jsp");
		model.addAttribute("invenList", list);
		model.addAttribute("dto", dto);
		model.addAttribute("page", "invenPage/allInven.jsp");
		return "common/layout";
	}
	
	@ResponseBody
	 @GetMapping("/getInventoryBook")
	    public List<Map<String, Object>> getInventoryBook() {
	        return service.getInventoryBook();
	    }
}
