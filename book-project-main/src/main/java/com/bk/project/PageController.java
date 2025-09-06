package com.bk.project;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.budget.service.BudgetService;
import com.bk.project.budget.vo.BudgetPlan;
import com.bk.project.claim.service.ClaimService;
import com.bk.project.contract.dto.ContractPagingDTO;
import com.bk.project.contract.dto.ContractDTO;
import com.bk.project.contract.dto.ContractExpiredDTO;
import com.bk.project.contract.dto.ContractPagingDTO;

import com.bk.project.contract.service.ContractService;
import com.bk.project.contract.vo.Contract;
import com.bk.project.defect.service.DefectService;
import com.bk.project.delivery.service.DeliveryService;
import com.bk.project.delivery.vo.Delivery;
import com.bk.project.department.service.DepartmentService;
import com.bk.project.marketing.dto.MarketingDTO;
import com.bk.project.marketing.dto.PagingDTO;
import com.bk.project.marketing.service.MarketingService;
import com.bk.project.marketing.vo.Marketing;
import com.bk.project.marketing.vo.MarketingExpired;
import com.bk.project.member.service.MemberService;
import com.bk.project.member.vo.Member;
import com.bk.project.partner.service.PartnerService;
import com.bk.project.request.service.RequestService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PageController {

    private final PartnerService partnerService;

	@Autowired
	private MemberService service;
	@Autowired
	private ContractService contractService;
	@Autowired
	private DeliveryService deliveryService;
	@Autowired
	private MarketingService marketingService;
	@Autowired
	private ClaimService claimservice;
	@Autowired
	private DefectService defectService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private BudgetService budgetService;
	@Autowired
	private RequestService requestService;


    PageController(PartnerService partnerService) {
        this.partnerService = partnerService;
    }
	
	
	@GetMapping("/")
	public String index() {
		return "login";
	}
	
	// 로그인
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	// 회원가입
	@GetMapping("/register")
	public String register() {
		return "page/register";
	}
	
	// 메인 화면
	@GetMapping("/main")
	public String main(Model model) {
		model.addAttribute("page", "main.jsp");
		return "common/layout";
	}
	
	
	// 회원정보 수정
	@GetMapping("/updateInfo")
	public String updateInfoForm(HttpSession session, Model model) {    
		 Member m = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    if (m == null) {
	        return "redirect:/";  // 로그인 안 된 경우 로그인 페이지로
	    }
	    model.addAttribute("loginUser", m);
	    model.addAttribute("page", "myPage/updateInfo.jsp");
	    return "common/layout";
	}
	
	/*
	// 인원 전체 조회
	@GetMapping("/allMember")
	public String allMember(Member member, Model model) {
		List<Member> list = service.allMember();
		System.out.println("list : "+list);
		model.addAttribute("list", list);
		model.addAttribute("page", "memberPage/allMember.jsp");
		return "common/layout";
	}
	*/
	
	// 신규 작가 등록
	@GetMapping("/newContract")
	public String newContract(Model model) {
		model.addAttribute("page","contractPage/newContract.jsp");
		return"common/layout";
	}
	

	// 거래처 등록
	@GetMapping("/newPartner")
	public String newPartner(Model model) {
		model.addAttribute("page", "partnerPage/newPartner.jsp");
		return "common/layout";
	}
	
	// 품질 검수 보고 등록
	@GetMapping("/newDefect")
	public String newDefect(Model model) {
		model.addAttribute("bookList", defectService.getBookList());
		model.addAttribute("page","qualityPage/newDefect.jsp");
		return "common/layout";
	}
	
	// 발주서 검색
	@GetMapping("/searchPrintOrder")
	public String searchPrintOrder(Model model) {
		model.addAttribute("page", "poPage/allPrintOrder.jsp");
		return "common/layout";
	}
	
	// 발주서 등록
	@GetMapping("/newPo")
	public String newPrintOrder(Model model) {
		model.addAttribute("page", "poPage/newPrintOrder.jsp");
	    return "common/layout";
	}
	
	// 출고 일정
	@GetMapping("/delivery")
	public String delivery(Model model) {
		model.addAttribute("page", "poPage/delivery.jsp");
		return "common/layout";
	}
	
	
	// 급여/상여금 관리
	@GetMapping("/salary")
	public String salary(Model model) {
		model.addAttribute("page", "financialPage/salary.jsp");
		return "common/layout";
	}
	
	// 클레임 등록
	@GetMapping("/newClaim")
	public String newClaim(Model model) {
	model.addAttribute("bookList", claimservice.getBookList());
    model.addAttribute("partnerList", claimservice.getPartnerList());
    model.addAttribute("page", "claimPage/newClaim.jsp");
		return "common/layout";
	}

	// 작가 수정
		@GetMapping("/updateContract")
		public String updateContract(@RequestParam("contractNo") Integer contractNo, Model model) {		
			 Contract contract = contractService.getContractByNo(contractNo);
			 model.addAttribute("contract", contract);
			 model.addAttribute("page", "contractPage/updateContract.jsp");
			return "common/layout";
		}
			
	// 운송사 수정
	@GetMapping("/updateDelivery")
	public String updateDelivery(@RequestParam("deliveryNo") Integer deliveryNo, Model model) {		
		Delivery delivery = deliveryService.getDeliveryByNo(deliveryNo);
		model.addAttribute("delivery", delivery);
		model.addAttribute("page", "/deliveryPage/updateDelivery.jsp");
		return "common/layout";
	}


	// 프로모션 수정
	@GetMapping("/updateMarketing")
	public String updateMarketing(@RequestParam("eventNo")Integer eventNo, Model model) {
		Marketing marketing = marketingService.getMarketingByNo(eventNo);
		model.addAttribute("marketing", marketing);
		model.addAttribute("page", "marketingPage/updateMarketing.jsp");
		return "common/layout";
	}
	
	/*
	// 외주 업체 조회
	@GetMapping("/allMarketing")
	public String allMarketing() {
		return "page/marketingPage/allMarketing";
	}
	*/
	
	// 운송사 등록
	@GetMapping("/newDelivery")
	public String newCarrier(Model model) {
		model.addAttribute("page", "/deliveryPage/newDelivery.jsp");
		return "common/layout";
	}

	
	

	// 신규 프로모션 등록
	@GetMapping("/newMarketing")
	public String newMarketing(Model model) {
		model.addAttribute("page", "marketingPage/newMarketing.jsp");
		return "common/layout";
	}
		
	// 운송사 수정
	@GetMapping("/updateCarrier")
	public String updateCarrier(Model model) {
		model.addAttribute("page", "carrierPage/updateCarrier.jsp");
		return "common/layout";
	}
	
	
	// 휴가 관리
	@GetMapping("/vacation")
	public String vacation(Model model) {
		model.addAttribute("page", "vacationPage/vacation.jsp");
		return "common/layout";
	}
	
	// 퇴사 관리
	@GetMapping("/quit")
	public String quit(Model model) {
		model.addAttribute("page", "page/quit.jsp");
		return "common/layout";
	}
	
	//프로필 화면
	@GetMapping("/myPage")
	public String myPage(Model model){
		model.addAttribute("page", "myPage/myPage.jsp");
		return "common/layout";
	}
	
	@GetMapping("/allInsertSalary")
	public String allInsertSalary(Model model) {
		model.addAttribute("page", "salaryPage/allSalary.jsp");
		return "common/layout";
	}

	
	@GetMapping("/overtime")
	public String overTime(Model model)
	{
		model.addAttribute("page", "/overTimePage/overtime.jsp");
		return "common/layout";
	}
	// 부서별 예산 등록화면
	@GetMapping("/insertBudgetPlan")
	public String insertBudgetPlan(Model model) {
		model.addAttribute("deptList", departmentService.allDepartment());
		model.addAttribute("page", "/budgetPage/insertBudgetPlan.jsp");
		return "common/layout";
	}

	  // 예산 집행 등록 화면
    @GetMapping("/insertBudgetExecution")
    public String execInsertForm(Model model) {
    	model.addAttribute("budgetList", budgetService.allBudgetPlan());
    	model.addAttribute("page", "/budgetPage/insertBudgetExecution.jsp");
        return "common/layout";
    }

	@GetMapping("/logout")
	public String logout(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		return "login";
	}
	
	// 품의 등록 페이지
	@GetMapping("/newRequest")
    public String form(Model model, HttpSession session) {
        Member writer = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("approvers", service.allMembers());
        model.addAttribute("writer", writer);
        model.addAttribute("page", "requestPage/newRequest.jsp");
        return "common/layout";
    }
	
	


	@GetMapping("/calendarPage") // 여기만 변경
	public String calendar(Model model) {
		model.addAttribute("page", "/calendar.jsp");
		return "common/layout"; // JSP 경로
	}
	
	
	
}

