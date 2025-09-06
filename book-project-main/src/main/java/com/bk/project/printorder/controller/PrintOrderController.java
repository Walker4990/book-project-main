package com.bk.project.printorder.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.book.service.BookService;
import com.bk.project.book.vo.Book;
import com.bk.project.contract.service.ContractService;
import com.bk.project.contract.vo.Contract;
import com.bk.project.printorder.dto.PrintOrderPagingDTO;
import com.bk.project.printorder.dto.printOrderDTO;
import com.bk.project.printorder.service.PrintOrderService;
import com.bk.project.printorder.vo.PrintOrder;
import com.bk.project.printorder.vo.PrintOrderDetailVO;


@Controller
public class PrintOrderController {

	@Autowired
	private PrintOrderService service;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ContractService contractService;
	
	
//	let allValid = true;
//	$("input:required, select:required").each(function () {
//	  if (!this.checkValidity()) {
//	    this.reportValidity(); // 브라우저 기본 오류 표시
//	    allValid = false;
//	    return false; // break
//	  }
//	});
//	if (!allValid) return;
//    // 수량 유효성 검사
//    $(".quantity").each(function () {
//      if (parseInt($(this).val()) < 0) {
//        alert("수량은 0 이상이어야 합니다.");
//        isValid = false;
//        return false;
//      }
//    });
//
//    // 홍보 부수 유효성 검사
//    $(".promotionQuantity").each(function () {
//      if (parseInt($(this).val()) < 0) {
//        alert("홍보 부수는 0 이상이어야 합니다.");
//        isValid = false;
//        return false;
//      }
//    });
//
//    if (!isValid) return; // 유효성 실패 시 AJAX 중단
	
	
	@GetMapping("/newPrintOrder")
	public String newPrintOrder(Model model) {
		   List<Book> bookList = bookService.allBooks(); // 또는 bookMapper.getAllBooks()
		    model.addAttribute("bookList", bookList);
		    model.addAttribute("page", "poPage/newPrintOrder.jsp");
		   
	    return "common/layout";
	}
	
	@ResponseBody
	@PostMapping("/newPrintOrder")
	public String newPrintOrder(@RequestBody PrintOrder po){
		   if (!service.validatePrintOrder(po)) return "fail:validation";
	        service.newPrintOrder(po);
	        return "success";
	}
	
	@GetMapping("/allPrintOrder")
	public String searchPrintOrder(PrintOrderPagingDTO paging, Model model) {
		
		List<PrintOrder> list;
	    int total;

	    if (paging.getKeyword() == null || paging.getKeyword().isEmpty()) {
	        // 전체 조회
	        list = service.allPrintOrder(paging);
	        total = service.countAllPrintOrder();
	    } else {
	        // 검색 조회
	        list = service.searchPrintOrder(paging);
	        total = service.countPrintOrder(paging);
	    }

	    model.addAttribute("list", list);
	    model.addAttribute("bookList", bookService.allBooks());
	    model.addAttribute("paging", new PrintOrderPagingDTO(paging.getPage(), total));
	    model.addAttribute("page", "poPage/allPrintOrder.jsp");

	    return "common/layout";
	}
	
	
	@GetMapping("/updatePrintOrder")
	public String updatePrintOrder(Integer orderNo, Model model) {
		
		PrintOrder po = service.getPrintOrderByNo(orderNo);
		System.out.println("po : "+ po);
		model.addAttribute("po", po);
		model.addAttribute("page", "poPage/updatePrintOrder.jsp");
		
		return "common/layout";
	}
	
	@ResponseBody
	@PostMapping("/updatePrintOrder")
	public String updatePrintOrder(@RequestBody PrintOrder order) {
		System.out.println("/updatePrintOrder 들어옴");
		System.out.println("--------파라미터 값 체크--------");
		System.out.println("DeliveryDate:" + order.getDeliveryDate());
		System.out.println("DetailList: "+order.getDetailList());
		System.out.println("Category: "+order.getCategory());
		System.out.println("IssueDate: "+order.getIssueDate());
		System.out.println("OrderDate: "+order.getOrderDate());
		boolean isValid = service.validatePrintOrder(order);
		
		System.out.println("DetailList: "+order.getDetailList());
		if(!isValid) {
			return "fail";
		}
		int result = service.updatePrintOrder(order);
		
		return (result > 0) ? "success" : "fail"; 
	}
	
	@ResponseBody
	@PostMapping("/deletePrintOrder")
	public String deletePrintOrder(int orderNo) {
		int result = service.deletePrintOrder(orderNo);
		if(result > 0) return "success";
		else return "fail"; 
	}
	@PostMapping("/updateDeliveryStatus")
	@ResponseBody
	public String updateStatus( PrintOrderPagingDTO dto) {
		int result = service.updateStatus(dto);
		return result > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@GetMapping("/getPrintOrder")
	public  PrintOrder getPrintOrder (int orderNo) {
	    return service.getPrintOrderByNo(orderNo);
	}
}
