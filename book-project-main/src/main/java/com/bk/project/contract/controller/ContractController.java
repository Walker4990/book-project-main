package com.bk.project.contract.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bk.project.author.service.AuthorService;
import com.bk.project.author.vo.Author;
import com.bk.project.book.service.BookService;
import com.bk.project.book.vo.Book;
import com.bk.project.contract.dto.ContractDTO;
import com.bk.project.contract.dto.ContractPagingDTO;
import com.bk.project.contract.dto.ContractExpiredDTO;
import com.bk.project.contract.dto.ContractPagingDTO;
import com.bk.project.contract.service.ContractService;
import com.bk.project.contract.vo.Contract;
import com.bk.project.contract.vo.ContractExpired;

@Controller
public class ContractController {

	@Autowired
	private AuthorService authorService;
	@Autowired
	private BookService bookService;
	@Autowired
	private ContractService service;
	

private boolean isValidContract(Contract contract) {
    LocalDate startDate     = contract.getStartDate();
    LocalDate endDate       = contract.getEndDate();
    LocalDate manuscriptDue = contract.getManuscriptDue();
    LocalDate printDate     = contract.getPrintDate();
    LocalDate publishDate   = contract.getPublishDate();

    if (startDate != null && endDate != null && startDate.isAfter(endDate)) return false;
    if (manuscriptDue != null && endDate != null && manuscriptDue.isAfter(endDate)) return false;
    if (manuscriptDue != null && printDate != null && manuscriptDue.isAfter(printDate)) return false;
    if (printDate != null && publishDate != null && publishDate.isBefore(printDate)) return false;

    return true;
}
	
	

	@ResponseBody
	@PostMapping("/newContract")
	public String newContract(Contract contract){
		
		  System.out.println(">>> birthDate: " + contract.getBirthDate());
		    System.out.println(">>> gender: " + contract.getGender());
		if(!isValidContract(contract)) {
			return "fail";
		}
		service.newContract(contract);
		return "success";
	}
	
	@GetMapping("/allContract")
	public String allContract(ContractPagingDTO paging, Model model) {
		int total;
		if(paging.getKeyword()!=null && !paging.getKeyword().isEmpty()) {
			total = service.countContract(paging);
		} else {
			total = service.countAll();
		}
		ContractPagingDTO fixedPaging = new ContractPagingDTO(paging.getPage(), total);
		fixedPaging.setKeyword(paging.getKeyword());

		List<Contract> list;
		if (paging.getKeyword()!=null&& !paging.getKeyword().isEmpty()) {
			list = service.searchContract(fixedPaging);
		} else {
			list = service.allContract(fixedPaging);
		}
		model.addAttribute("list", list);
		model.addAttribute("param", paging);
		model.addAttribute("paging", fixedPaging);
		model.addAttribute("page", "/contractPage/allContract.jsp");
		
		return "common/layout";
	}
	
	
	
	@ResponseBody
	@PostMapping("/updateContract")
	public String updateContract(@RequestBody ContractDTO dto) {
		 Contract contract = new Contract();
		    contract.setContractNo(dto.getContractNo());
		    contract.setBookTitle(dto.getBookTitle());
		    contract.setContractAmount(dto.getContractAmount());
		    contract.setRoyaltyRate(dto.getRoyaltyRate());
		    contract.setGenre(dto.getGenre());
		    contract.setEndDate(dto.getEndDate() != null ? LocalDate.parse(dto.getEndDate()) : null);
		    contract.setManuscriptDue(dto.getManuscriptDue() != null ? LocalDate.parse(dto.getManuscriptDue()) : null);
		    contract.setPrintDate(dto.getPrintDate() != null ? LocalDate.parse(dto.getPrintDate()) : null);
		    contract.setPublishDate(dto.getPublishDate() != null ? LocalDate.parse(dto.getPublishDate()) : null);
		    
		    System.out.println(dto);
		    if (!isValidContract(contract)) return "fail";
		    return service.updateContract(contract) > 0 ? "success" : "fail";
		}

	@ResponseBody
	@PostMapping("/deleteContract")
	public String deleteContract(int contractNo) {
		int result = service.deleteContract(contractNo);
		if(result > 0) return "success";
		else return "fail";
	}
	
	@ResponseBody
	@PostMapping("/insertExpired")
	public String insertExpired(@RequestParam int contractNo,
	                            @RequestParam String closeType,
	                            @RequestParam String closeReason) {
		System.out.println("contractNo=" + contractNo 
			    + ", closeType=" + closeType 
			    + ", closeReason=" + closeReason);
	    int expired = service.insertExpired(contractNo, closeType, closeReason);
	    return expired > 0 ? "success" : "fail";
	}
	
//    @GetMapping("/insertExpired")
//	@ResponseBody
//	public String insertExpired(int contractNo) {
//	    // closeType / closeReason 은 테스트니까 고정값 넣기
//	    int expired = service.insertExpired(contractNo, "EXPIRE", "테스트 만료 처리");
//	    return expired > 0 ? "success" : "fail";
//	}

	
	// 만료/해지 계약 조회
	@GetMapping("/expiredList")
	public String expiredLists(Model model, ContractPagingDTO paging) {
		List<ContractExpired> expiredList = service.expiredList(paging);
		int total = service.total();
		ContractPagingDTO contractPaging = new ContractPagingDTO(paging.getPage(), total);
		
	
		model.addAttribute("expiredList", expiredList);
		model.addAttribute("paging", contractPaging);
		model.addAttribute("page", "/contractPage/contractExpiredList.jsp");
		
	
		return "common/layout";
	}
	
	
	@GetMapping("/allContractExpired")
    public String showAllExpiredContracts(Model model, ContractExpiredDTO dto, ContractPagingDTO paging) {
		int total = service.countContract(paging);
        List<ContractExpired> expiredList = service.expiredList(paging);
       
        model.addAttribute("paging", new ContractPagingDTO(paging.getPage(), total));
        model.addAttribute("expiredList", expiredList);
        model.addAttribute("page", "contractPage/contractExpiredList.jsp");
        System.out.println("ㅎㅇ2" + total);
        System.out.println("ㅎㅇ3" + expiredList);
        return "common/layout"; 
    }
	
	@ResponseBody
	@GetMapping("/getContract")
	public Contract getContract(int contractNo) {
	    return service.getContractByNo(contractNo);
	}
	
}
