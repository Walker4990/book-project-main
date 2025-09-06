package com.bk.project.defect.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.book.vo.Book;
import com.bk.project.defect.dto.DefectPagingDTO;
import com.bk.project.defect.dto.QualityCheckDTO;
import com.bk.project.defect.service.DefectService;
import com.bk.project.defect.vo.Defect;
import com.bk.project.defect.vo.QualityCheck;
import com.bk.project.marketing.dto.PagingDTO;
import com.bk.project.printorder.dto.PrintOrderPagingDTO;
import com.bk.project.printorder.service.PrintOrderService;
import com.bk.project.printorder.vo.PrintOrder;
import com.bk.project.printorder.vo.PrintOrderDetailVO;

@Controller
public class DefectController {
	
	@Autowired
	private DefectService service;
    
	@Autowired
	private PrintOrderService printOrderService;
	// 신규 품질 보고 등록
	@PostMapping("/newDefect")
	public String newDefect(Defect defect) {
		service.newDefect(defect);
		return "redirect:/allDefect";
	}
	

	
	// 품질 보고 전체 조회
	@GetMapping("/allDefect")
    public String allDefect(Model model, DefectPagingDTO paging) {
		
		// 전체 개수 먼저 조회
		int total;
		if (paging.getKeyword() != null && !paging.getKeyword().trim().isEmpty()) {
		    total = service.countDefect(paging);
		} else {
		    total = service.countAll();   // ✅ 전체 건수만 구하는 쿼리 따로
		}

		DefectPagingDTO fixedPaging = new DefectPagingDTO(paging.getPage(), total);
		fixedPaging.setKeyword(paging.getKeyword());  // 검색 키워드 유지
		fixedPaging.setSelect(paging.getSelect());    // 검색 조건 유지

		List<Defect> defectList;
		if (paging.getKeyword() != null && !paging.getKeyword().trim().isEmpty()) {
		    defectList = service.searchDefect(fixedPaging);
		} else {
		    defectList = service.allDefect(fixedPaging); // ✅ 전체 조회 쿼리 따로
		}

		// 도서 목록 조회
		List<Book> bookList = service.getBookList();

		// 상태 리스트 → 문자열 변환
		for (Defect defect : defectList) {
		    if (defect.getStatusList() != null) {
		        defect.setStatus(String.join(", ", defect.getStatusList()));
		    }
		}

		// 모델에 담기
		model.addAttribute("bookList", bookList);
		model.addAttribute("page", "/qualityPage/allDefect.jsp");
		model.addAttribute("defectList", defectList);
		model.addAttribute("paging", fixedPaging);
		model.addAttribute("param", paging);
		
	    return "common/layout";
    }
	
	// 선택한 보고서 값 넘기기
	@GetMapping("/updateDefect")
	public String selectUpdate(int defectNo ,Model model) {
		model.addAttribute("page", "/qualityPage/updateDefect.jsp");
		Defect defect = service.selectDefect(defectNo);
		
		if(defect.getStatusList() != null) {
			defect.setStatus((String.join(", ", defect.getStatusList())));
		}
		
		model.addAttribute("defect", defect);		
		return "common/layout";
		//return"/page/qualityPage/updateDefect";	
	}
		
	// 품질 보고 수정
	@ResponseBody
	@PostMapping("/updateDefect")
	public String updateDefect(Defect defect) {
		System.out.println("controller defect값 : "+ defect);
		if(defect.getStatusList() != null) {
			defect.setStatus((String.join(", ", defect.getStatusList())));
		}
		
		int updated = service.updateDefect(defect);
		return updated > 0 ? "success" : "fail";
	}
	
	 // 보고서 삭제	
	 @ResponseBody
	 @PostMapping("/deleteDefect")
	 public String deleteDefect(int defectNo) {
	        service.deleteDefect(defectNo);
	        return "/page/qualityPage/allDefect";
	    }
       
	 @GetMapping("/selectDefectStats")
	 @ResponseBody
	 public List<Map<String, Object>> selectDefectStats() {
		 return service.selectDefectStats();
	 }
	 
	 // 화면단에 보여져야 하는 북 값들
	 @ResponseBody
	 @GetMapping("/selectBook")
	 public Book selectBook(int bookNo) {
		 return service.selectBook(bookNo);
	 }
	 
	 @GetMapping("/qualityCheckTarget")
	 public String qualityCheckTarget(PrintOrderPagingDTO paging, Model model){
		 int total;
			if (paging.getKeyword() != null && !paging.getKeyword().trim().isEmpty()) {
			    total = printOrderService.countQualityCheckTarget(paging);
			} else {
			    total = printOrderService.countAllQualityCheckTarget();   // ✅ 전체 건수만 구하는 쿼리 따로
			}
			PrintOrderPagingDTO fixedPaging = new PrintOrderPagingDTO(paging.getPage(), total);
			fixedPaging.setKeyword(paging.getKeyword());  // 검색 키워드 유지
			fixedPaging.setSelect(paging.getSelect());    // 검색 조건 유지
			
			List<PrintOrder> targetList;
			if (paging.getKeyword() != null && !paging.getKeyword().trim().isEmpty()) {
				targetList = printOrderService.qualityCheckTarget(fixedPaging);
			} else {
				targetList = printOrderService.allQualityCheckTarget(fixedPaging); // ✅ 전체 조회 쿼리 따로
			}
		    // 모델 바인딩
		    model.addAttribute("targetList", targetList);
		    model.addAttribute("paging", fixedPaging);
		    model.addAttribute("param", paging);
		    model.addAttribute("page", "/qualityPage/qualityCheckTarget.jsp");
		    
		    System.out.println("1" + targetList);
		    
		    System.out.println("2" + fixedPaging);
		    
		    System.out.println("3" + paging);
		    return "common/layout";
	 }
	 
	 //품질 보고 등록
	 @PostMapping("/insertQualityCheck")
	 @ResponseBody
	 public String insertQualityCheck(@RequestBody QualityCheckDTO dto) {
		 System.out.println("dto : "+dto);
		 List<PrintOrderDetailVO> reasonList = dto.getDetailList();
		 for(PrintOrderDetailVO vo: reasonList)
		 {
			 if(vo.getDefectReasons() != null)
			 {
				 String word = String.join(" ", vo.getDefectReasons());
				 vo.setDefectReason(word);
				 dto.setDefectReason(word);
			 }
		 }
		 service.insertQualityCheck(dto);
	     return "success";
	 }
	 
	 @ResponseBody
	 @GetMapping("/getDefect")
	 public Defect getDefect (int defectNo) {
		 return service.selectDefect(defectNo);
	 }

}

