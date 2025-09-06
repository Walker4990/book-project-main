package com.bk.project.vacation.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.Provider.Service;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.attendance.mapper.AttendanceMapper;
import com.bk.project.attendance.service.AttendanceService;
import com.bk.project.attendance.vo.AttendanceInfo;
import com.bk.project.member.vo.Member;
import com.bk.project.vacation.dto.VacationDTO;
import com.bk.project.vacation.dto.VacationPagingDTO;
import com.bk.project.vacation.service.VacationService;
import com.bk.project.vacation.vo.Vacation;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class VacationController {
	@Autowired
	private VacationService vacationService;
	@Autowired
	private AttendanceService attendanceService;
	
	
	/*
		//휴가 조회
		@GetMapping("/allVacation")
		public String allVacation(Model model, String keyword, VacationPagingDTO paging) {
			int total;
			
			
			if(keyword == null)
			{
				model.addAttribute("beforeVacationList", vacationService.beforeVacation());
				model.addAttribute("afterVacationList", vacationService.afterVacation(paging));
				total = vacationService.total();
			}
			else
			{
				model.addAttribute("afterVacationList", vacationService.searchAfter(paging));
				total = vacationService.searchTotal(keyword);
			}
			
			model.addAttribute("paging", new VacationPagingDTO(paging.getPage(), total));
			model.addAttribute("page", "vacationPage/allVacation.jsp");
			
			return "common/layout";
		}
		*/
		/*
		//휴가 검색
		@PostMapping("/searchVacation")
		public String searchVacation(String keyword)
		{
			String encord= URLEncoder.encode(keyword,StandardCharsets.UTF_8);
			return "redirect:/allVacation?keyword=" + encord;
		}
		
		*/
	// 휴가 캘린더
	@GetMapping("/vacationCalendarPage") // 여기만 변경
	public String vacationCalendar(Model model) {
		model.addAttribute("page", "/vacationPage/vacationCalendar.jsp");
		return "common/layout"; // JSP 경로
	}
	// FullCalendar 이벤트 JSON 내려주기
	@GetMapping("/vacationCalendarData")
	@ResponseBody
	public List<Map<String, Object>> getCalendarVacations() {
	    List<Map<String,Object>> list = vacationService.vacationCalendar();

	    // FullCalendar가 이해할 수 있는 구조로 가공
	    List<Map<String,Object>> events = new ArrayList<>();
	    for (Map<String,Object> row : list) {
	        Map<String,Object> event = new HashMap<>();
	        event.put("title", "[휴가] " + row.get("dept_name") + " - " + row.get("name"));
	        event.put("start", row.get("start_date").toString());
	        LocalDate endDate = ((java.sql.Date) row.get("end_date")).toLocalDate();
	        event.put("end", endDate.plusDays(1).toString());
	        event.put("dept_name", row.get("dept_name")); // 색상 구분용
	        events.add(event);
	    }
	    return events;
	}
	
		//휴가 승인
		@ResponseBody
		@PostMapping("/approveVacation")
		public String approveVacation(int vacationNo)
		{
			LocalDate today = LocalDate.now();
			
			
			Vacation vacation = vacationService.getVacation(vacationNo);
			AttendanceInfo info = attendanceService.annualInfo(vacation.getMemberNo());
			//Vacation vacation = vacationService
			
			LocalDate startDate = vacation.getStartDate();
			LocalDate endDate = vacation.getEndDate();
			
			int annual = info.getAnnual();
			int count = 0;
			while(!startDate.isAfter(endDate))
			{
				count += 1;
				startDate = startDate.plusDays(1);
			}
			info.setAnnual(count);
			int check = vacationService.approveVacation(vacation);
			int check2 = attendanceService.minusAnnual(info);
			
			if(check > 0 && check2 > 0)
			{
				System.out.println("승인이 완료되었습니다.");
				return "success";
			}
			System.out.println("승인에 실패하였습니다.");
			return "fail";
		}
		
		//휴가 미승인
		@ResponseBody
		@PostMapping("/notApprove")
		public String notApprove(int vacationNo)
		{
			Vacation vacation = vacationService.getVacation(vacationNo);
			int check = vacationService.notApprove(vacation);
			if(check > 0)
			{
				System.out.println("미승인 완료되었습니다.");
				return "success";
			}
			System.out.println("미승인에 실패하였습니다.");
			return "fail";
		}
		
	
	
	// 휴가 신청
	
	@ResponseBody
	@PostMapping("/vacation")
	public String vacation(Vacation vacation) {
		
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		vacation.setMemberNo(member.getMemberNo());
		System.out.println("휴가 신청 정보: "+ vacation);
		LocalDate date = LocalDate.now();
		LocalDate startDate = vacation.getStartDate();
		LocalDate endDate = vacation.getEndDate();
		vacation.setDate(date);
		
		List<Vacation> duplicationVacation = vacationService.checkDuplicationVacation(vacation);
		
		if(duplicationVacation != null && !duplicationVacation.isEmpty())
		{
			for(Vacation va: duplicationVacation)
			{
				LocalDate vaStartDate = va.getStartDate();
				LocalDate vaEndDate = va.getEndDate();
					
					if (!(endDate.isBefore(vaStartDate) || startDate.isAfter(vaEndDate))) 
					{
						return "duplicationDate"; 
					}
			}
		}
		
		if(vacation.getReason() == null || vacation.getEndDate() == null
				|| vacation.getReason() == "")
		{
			System.out.println("값이 없습니다");
			return "empty";
		}
		
		if(startDate.isAfter(endDate))
		{
			 System.out.println("시작 날짜가 끝 날짜보다 뒤에 있습니다.");
			 return "startDateAfter";
		}
		if(date.isAfter(startDate))
		{
			System.out.println("휴가 날짜가 이미 지났습니다.");
			return "dateAfter";
		}
		
		AttendanceInfo info = attendanceService.annualInfo(vacation.getMemberNo());
		if(info == null)
		{
			System.out.println("값이 없습니다");
			return "empty";
		}
		if(info.getAnnual() == 0)
		{
			System.out.println("연차 개수가 0개 입니다.");
			return "zero";
		}
		int count = 0;
		//날짜 세기
		while(!startDate.isAfter(endDate))
		{
			count += 1;
			startDate = startDate.plusDays(1);
		}
		
		
		//만약 날짜개수가 연차 개수보다 많으면
		if(info.getAnnual() < count)
		{
			System.out.println("연차가 부족합니다.");
			return "enough";
		}
	
		//신청 완료
		vacationService.addVacation(vacation);
		
		return "success";
	}
	
	/*
	//휴가 조회
	@GetMapping("/allVacation")
	public String allVacation(Model model, String keyword, VacationPagingDTO paging) {
		int total;
		
		
		if(keyword == null)
		{
			model.addAttribute("beforeVacationList", vacationService.beforeVacation());
			model.addAttribute("afterVacationList", vacationService.afterVacation(paging));
			total = vacationService.total();
		}
		else
		{
			model.addAttribute("afterVacationList", vacationService.searchAfter(paging));
			total = vacationService.searchTotal(keyword);
		}
		
		model.addAttribute("paging", new VacationPagingDTO(paging.getPage(), total));
		model.addAttribute("page", "vacationPage/allVacation.jsp");
		
		return "common/layout";
	}
	*/
	/*
	//휴가 검색
	@PostMapping("/searchVacation")
	public String searchVacation(String keyword)
	{
		String encord= URLEncoder.encode(keyword,StandardCharsets.UTF_8);
		return "redirect:/allVacation?keyword=" + encord;
	}
	
	*/

	
  
	@GetMapping("/allVacation")
	public String allVacation(Model model,
			@RequestParam(value = "keywordBefore", required = false) String keywordBefore,
			@RequestParam(value = "keywordAfter", required = false) String keywordAfter,
	        @RequestParam(value = "pagingBefore", defaultValue = "1") int pagingBeforePage,
	        @RequestParam(value = "pagingAfter", defaultValue = "1") int pagingAfterPage) {

	    int totalBefore;
	    int totalAfter;

	    List<VacationDTO> beforeVacationList;
	    List<VacationDTO> afterVacationList;

	    if (keywordBefore == null || keywordBefore.isEmpty()) {
	        totalBefore = vacationService.totalBefore();

	        VacationPagingDTO pagingBefore = new VacationPagingDTO(pagingBeforePage, totalBefore);

	        beforeVacationList = vacationService.beforeVacation(pagingBefore);
	        
	        model.addAttribute("pagingBefore", pagingBefore);
	        //model.addAttribute("pagingAfter", pagingAfter);
	    } else {
	        totalBefore = vacationService.searchTotalBefore(keywordBefore);
	    
	        VacationPagingDTO pagingBefore = new VacationPagingDTO(pagingBeforePage, totalBefore);
	        pagingBefore.setKeyword(keywordBefore);

	        beforeVacationList = vacationService.searchBefore(pagingBefore);
	        
	        System.out.println(pagingBefore);
	        
	        model.addAttribute("pagingBefore", pagingBefore);
	    }
	    
	    if(keywordAfter == null || keywordAfter.isEmpty()) {
	    	 totalAfter = vacationService.totalAfter();
	    	 VacationPagingDTO pagingAfter = new VacationPagingDTO(pagingAfterPage, totalAfter);
	    	 afterVacationList = vacationService.afterVacation(pagingAfter);
	    	 model.addAttribute("pagingAfter", pagingAfter);
	    } else {
	    	totalAfter = vacationService.searchTotalAfter(keywordAfter);
	    	VacationPagingDTO pagingAfter = new VacationPagingDTO(pagingAfterPage, totalAfter);
	        pagingAfter.setKeyword(keywordAfter);
	        afterVacationList = vacationService.searchAfter(pagingAfter);
	        model.addAttribute("pagingAfter", pagingAfter);
	    }

	    model.addAttribute("beforeVacationList", beforeVacationList);
	    model.addAttribute("afterVacationList", afterVacationList);
	    model.addAttribute("keywordBefore", keywordBefore); 
	    model.addAttribute("keywordAfter", keywordAfter);
	    model.addAttribute("page", "vacationPage/allVacation.jsp");
	    

	 
	    return "common/layout";
	}
	
	
	
	/*
	//휴가 검색
	@PostMapping("/searchVacation")
	public String searchVacation(@RequestParam String keyword)
	{
		String encord= URLEncoder.encode(keyword,StandardCharsets.UTF_8);
		return "redirect:/allVacation?keyword=" + encord;
	}
	
	*/



}
