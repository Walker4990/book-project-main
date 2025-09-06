package com.bk.project.attendance.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.attendance.dto.AttendanceDTO;
import com.bk.project.attendance.dto.AttendancePagingDTO;
import com.bk.project.attendance.service.AttendanceService;
import com.bk.project.attendance.vo.Attendance;
import com.bk.project.attendance.vo.AttendanceInfo;
import com.bk.project.member.vo.Member;
import com.bk.project.overtime.service.OverTimeService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AttendanceController {


    @Autowired
	private OverTimeService overIimeService;

	@Autowired
	private AttendanceService service;

	// 출/퇴근 관리
	@GetMapping("/attendance")
	public String attendance(Model model, AttendancePagingDTO paging) {
		
		List<AttendanceDTO> allAttendance =service.allAttendance(paging);
		int total = service.total();
	  

		model.addAttribute("paging", new AttendancePagingDTO(paging.getPage(), total));
	    model.addAttribute("allAttendance", allAttendance);
	    model.addAttribute("page", "attendancePage/attendance.jsp");	
	    
	    System.out.println(total);
	    System.out.println(paging.getPage());
	    
	    return "common/layout";
	}
	
	
	@GetMapping("/searchAttendanceInfo")
	public String searchAttendance(Model model, AttendancePagingDTO paging) {
	    List<AttendanceDTO> searchAttendanceInfo = service.searchAttendanceInfo(paging);
	    int total = service.countAttendance(paging);
	    
	    model.addAttribute("paging", new AttendancePagingDTO(paging.getPage(), total));
	    model.addAttribute("allAttendance", searchAttendanceInfo);
	    model.addAttribute("page", "attendancePage/attendance.jsp");

	    return "common/layout";
	}
    
	@ResponseBody
	@PostMapping("/checkIn")
	public int checkIn(HttpServletRequest request) {
		// 로그인 직원 정보 받기
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    // info 테이블에 직원 정보 추가하기 
	    AttendanceInfo info = service.searchInfo(member.getMemberNo());
	    if(info == null)
	    {
	    	System.out.println("info 테이블에 값이 없습니다.");
	    	service.addAttendanceInfo(member.getMemberNo());
	    }
	    
	    // 오늘 출근 체크 했는지 확인
	    LocalDate today = LocalDate.now();
	    System.out.println(today);
	    
	    Attendance attendance = new Attendance();
	    attendance.setDate(today);
	    attendance.setMemberNo(member.getMemberNo());
	    Attendance check = service.searchAttendance(attendance);
	    
	    //이미 버튼을 눌렀을 시
	    if(check != null)
	    {
	    	System.out.println("이미 출근 버튼을 클릭하였습니다.");
	    	return -1;
	    }
	    
	    //출근 버튼을 클릭 한했을 시 

	    LocalTime time = LocalTime.now().withNano(0); // HH:mm:ss
	    attendance.setDate(today);              // 날짜만 저장
	    attendance.setCheckIn(time);     // 시간만 저장
	    
	    //기준 출근 시간 09:00
	    LocalTime checkInTime = LocalTime.of(9, 10); // 09:10:00

	    
	   	int checkIn = service.addAttendance(attendance);	    
	    Attendance memberInfo = service.searchAttendance(attendance);
	    //지각 여부 판별
	    boolean isLate = time.isAfter(checkInTime);
		if(isLate)
		{
			   service.late(attendance);
		}
		else
		{
			service.checkin(memberInfo);			
		}
		
	    if(checkIn > 0)
	    {
	    	//출근 했을 시 Attendance에 출근날짜 + 1
	    	System.out.println("출석체크 완료");
	    	return checkIn;
	    }
	    return -2;
	   }

	@ResponseBody
	@PostMapping("/checkOut")
	public int checkOut(HttpServletRequest request) {
		// 로그인 직원 정보 받기
		 Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		LocalTime startTime = LocalTime.of(0, 0);
		LocalTime endTime = LocalTime.of(5, 0);
		LocalTime now = LocalTime.now();

		//야근 시간일 경우
		if(!now.isBefore(startTime)&& now.isBefore(endTime))
		{
			LocalDate date = LocalDate.now();
			System.out.println("현재 야근 시간 입니다.");
			String time = date.toString();
			List<Integer> overTimeList = overIimeService.todayOverTime(time);
			System.out.println("list 값 : "+ overTimeList);
			if(overTimeList != null)
			{

				int memberNo = member.getMemberNo();

				System.out.println("memberNo : "+ memberNo);
				//야근 신청한 직원인지 여부
				if(overTimeList.contains(memberNo))
				{
					System.out.println("야근을 신청한 직원입니다.");
					//퇴근시간 작성 후 넣기
					Attendance attendance = new Attendance();
					attendance.setDate(date.minusDays(1));
					attendance.setMemberNo(memberNo);
					
					LocalTime currentTime = LocalTime.now().withNano(0);
					attendance.setCheckOut(currentTime);
					int checkOut = service.updateAttendance(attendance);
					
					//info 상태 '퇴근'으로 변경
					Attendance memberInfo = service.searchAttendance(attendance);
					service.checkout(memberInfo);
					return checkOut;
					
				}
			}
		}//야근 시간대가 아닌 경우
		else 
		{
			LocalDate today = LocalDate.now();
			System.out.println(today);
			
			Attendance attendance = new Attendance();
			attendance.setDate(today);
			attendance.setMemberNo(member.getMemberNo());
			
			//퇴근시간 작성 후 넣기
			LocalTime currentTime = LocalTime.now().withNano(0);
			attendance.setCheckOut(currentTime);
			int checkOut = service.updateAttendance(attendance);
			
			//해당 직원의 출석체크 테이블을 찾아서 퇴근 시간 업데이트
			Attendance memberInfo = service.searchAttendance(attendance);
			service.checkout(memberInfo);
			if(checkOut > 0)
			{
				return checkOut;
			}
			
		}
		return -2;
	}
		
}

