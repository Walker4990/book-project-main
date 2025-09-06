package com.bk.project.claim.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.book.vo.Book;
import com.bk.project.claim.dto.ClaimPagingDTO;
import com.bk.project.claim.service.ClaimService;
import com.bk.project.claim.vo.Claim;
import com.bk.project.inventory.service.InventoryService;
import com.bk.project.partner.service.PartnerService;

@Controller
public class ClaimController {

	@Autowired
	private ClaimService service;
	
	@Autowired
	private InventoryService inventoryService;
	
	@Autowired
	private PartnerService partnerService;
	
	
	
	// 신규 클레임 등록
	@ResponseBody
	@PostMapping("/newClaim")
	public String newClaim(Claim claim) {
		if (claim.getPartnerNo() == 0) return "partnerNoError";
	    if (claim.getBookNo() == 0) return "bookNoError";
	    if (claim.getQuantity() <= 0) return "quantityError";
	    if (claim.getContent() == null || claim.getContent().trim().isEmpty()) return "contentError";
	    if (claim.getRecall() == null || claim.getRecall().trim().isEmpty()) return "recallError";
	    if (claim.getRecallStatus() == null || claim.getRecallStatus().trim().isEmpty()) return "recallStatusError";
	    if (claim.getClaimDate() == null) return "dateError";
	    if (claim.getDefectTypeList() == null || claim.getDefectTypeList().isEmpty()) return "defectTypeError";

		
	    int row = service.newClaim(claim);
	    return row > 0 ? "success" : "fail";
	}
	
	// 클레임 조회
	

	
	// 클레임 전체 조회
	@GetMapping("/allClaim")
	public String allClaim(Model model, ClaimPagingDTO paging) {
		
		 int total = service.countClaim(paging);
		 ClaimPagingDTO fixedPaging = new ClaimPagingDTO(paging.getPage(), total);
		 fixedPaging.setKeyword(paging.getKeyword());  // 검색 키워드 유지 (있을 경우)
		 fixedPaging.setSelect(paging.getSelect());    // 검색 조건 유지 (있을 경우)

		 List<Claim> list = service.searchClaim(fixedPaging);
		 
	    model.addAttribute("bookList", service.getBookList());
	    model.addAttribute("partnerList", service.getPartnerList());
	    model.addAttribute("claimList", list);
	    model.addAttribute("paging", fixedPaging);
	    model.addAttribute("param", paging);
	    model.addAttribute("page", "/claimPage/allClaim.jsp");
		return "common/layout";
		}
	


    
    
	// 선택한 클레임 값 넘기기
	@GetMapping("/updateClaim")
	public String selectClaim(int claimNo, Model model) {
		model.addAttribute("page", "claimPage/updateClaim.jsp");
		Claim claim = service.selectClaim(claimNo);
		if (claim == null) {
		    System.out.println("DEBUG claim is NULL for claimNo=" + claimNo);
		} else {
		    System.out.println("DEBUG recall = " + claim.getRecall());
		}
	    // defectTypeList → defectType 문자열 변환
	    if (claim.getDefectTypeList() != null) {
	        claim.setDefectType(String.join(", ", claim.getDefectTypeList()));
	    }

	    model.addAttribute("selectedClaim", claim);
	    return "common/layout";
	    //return "/page/claimPage/updateClaim";
	}
	
	
	// 클레임 수정
	@ResponseBody
	@PostMapping("/updateClaim")
	public String updateClaim(Claim claim) {
		 if (claim.getPartnerNo() == null || claim.getPartnerNo() == 0) return "partnerNoError";
		    if (claim.getBookNo() == null || claim.getBookNo() == 0) return "bookNoError";
		    if (claim.getQuantity() == null || claim.getQuantity() <= 0) return "quantityError";
		    if (claim.getContent() == null || claim.getContent().trim().isEmpty()) return "contentError";
		    if (claim.getRecall() == null || claim.getRecall().trim().isEmpty()) return "recallError";
		    if (claim.getRecallStatus() == null || claim.getRecallStatus().trim().isEmpty()) return "recallStatusError";
		    if (claim.getClaimDate() == null) return "dateError";
		    if (claim.getDefectTypeList() == null || claim.getDefectTypeList().isEmpty()) return "defectTypeError";
		 // defectTypeList → defectType 문자열 변환
	    if (claim.getDefectTypeList() != null) {
	        claim.setDefectType(String.join(", ", claim.getDefectTypeList()));
	    }

	    // 1. 클레임 업데이트는 항상 실행
	    int updated = service.updateClaim(claim);

	    // 2. 회수 가능 && 완료일 때만 재고 반영
	    if ("회수 가능".equals(claim.getRecall()) &&
	    	    ("완료".equals(claim.getRecallStatus()) || "회수 완료".equals(claim.getRecallStatus()))) {
	    	    service.returnInven(claim);
	    	}

	    return updated > 0 ? "success" : "fail";
	}
	
	// 클레임 삭제
	@ResponseBody
	@PostMapping("/deleteClaim")
	public String deleteClaim(int claimNo) {
		service.deleteClaim(claimNo);
		return "/page/claimPage/allClaim";
	}
	
	// 화면단에 보여져야 하는 북 값들
	@ResponseBody
	@GetMapping("/cSelectBook")
	public Book cSelectBook(int bookNo) {
	return service.cSelectBook(bookNo);
    }
	
	@ResponseBody
	@GetMapping("/getClaim")
	public Claim getClaim(int claimNo) {
		return service.selectClaim(claimNo);
	}
}
