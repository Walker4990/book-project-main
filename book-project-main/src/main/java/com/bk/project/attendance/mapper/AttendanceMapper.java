package com.bk.project.attendance.mapper;

import java.time.Duration;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.attendance.dto.AttendanceDTO;
import com.bk.project.attendance.dto.AttendancePagingDTO;
import com.bk.project.attendance.vo.Attendance;
import com.bk.project.attendance.vo.AttendanceInfo;
import com.bk.project.attendance.vo.AttendanceSave;

@Mapper
public interface AttendanceMapper {

	AttendanceInfo searchInfo(int memberNo);
	int addAttendanceInfo(int memberNo);
	Attendance searchAttendance(Attendance attendance);
	
	List<AttendanceDTO> allAttendance();
	
	// attendance의 출/퇴근
	int addAttendance(Attendance attendance);
	int updateAttendance(Attendance attendance);
	
	//attendance_info의 출근 퇴근
	void checkin(Attendance attendance);
	void checkout(Attendance attendance);
	void late(Attendance attendance);
	
	//날짜별 업데이트
	
	//테스트용
	void deleteStatus();
	
	//1월마다 업데이트
	void monthStatus();
	void saveStatus(AttendanceSave info);
	List<AttendanceInfo> getInfo();
	List<Attendance> getAttendance(Attendance getDate);
	
	//휴가 관리
	void annualSet(int memberNo);
	void annualSetFull(int memberNo);
	AttendanceInfo annualInfo(int memberNo);
	
	//자정마다 업데이트
	void resetStatus(int memberNo);
	void notCheck(Attendance getAttendance);
	//총 근무시간 저강
	void setTotalTime(Attendance li);
	void overTime(Attendance li);
	void notCheckout(Attendance li);
	void goVacation(int memberNo);
	
	// 초과근무 시간 계산
	void setOverTime(Attendance li);
	// 한달 초과근무 시간 합계
	String findMonthlyOvertime(int memberNo, String yearMonth);
	
	// 휴가가 아닌 직원 정보 가져오기
	List<AttendanceInfo> getNotVacation();
	
	// 오늘이 휴가날짜이면 '휴가중'으로 바꾸기
	void changeVacation(int memberNo);
	
	int minusAnnual(AttendanceInfo info);
	
	int total();
	
	List<AttendanceDTO> allAttendance(AttendancePagingDTO paging);
	List<AttendanceDTO> searchAttendanceInfo(AttendancePagingDTO paging);
	int countAttendance(AttendancePagingDTO paging);
	
	
	
}
