package com.bk.project.attendance.service;

import java.time.Duration;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.attendance.dto.AttendanceDTO;
import com.bk.project.attendance.dto.AttendancePagingDTO;
import com.bk.project.attendance.mapper.AttendanceMapper;
import com.bk.project.attendance.vo.Attendance;
import com.bk.project.attendance.vo.AttendanceInfo;
import com.bk.project.attendance.vo.AttendanceSave;

@Service
public class AttendanceService implements AttendanceMapper{

	@Autowired
	private AttendanceMapper mapper;

	//출석 계산 테이블에 해당 직원이 존재하는지 확인
	@Override
	public AttendanceInfo searchInfo(int memberNo) {
		return mapper.searchInfo(memberNo);
	}
	// 출석 계산 테이블 생성
	@Override
	public int addAttendanceInfo(int memberNo) {
		return mapper.addAttendanceInfo(memberNo);
		
	}
	//출석 체크 여부 확인
	@Override
	public Attendance searchAttendance(Attendance attendance) {
		
		return mapper.searchAttendance(attendance);
	}
	
	//출석 체크
	@Override
	public int addAttendance(Attendance attendance) {
	
		return mapper.addAttendance(attendance);
	}
	@Override
	public int updateAttendance(Attendance attendance) {

		return mapper.updateAttendance(attendance);
	}

	@Override
	public void checkin(Attendance attendance) {
		mapper.checkin(attendance);
		
	}
	@Override
	public void checkout(Attendance attendance) {
		mapper.checkout(attendance);
	}
	@Override
	public void late(Attendance attendance) {
		mapper.late(attendance);
	}
	
	
	//테스트
	@Override
	public void deleteStatus() {
		mapper.deleteStatus();
	}
	//info 정보 초기화
	@Override
	public void resetStatus(int memberNo) {
		mapper.resetStatus(memberNo);
	}
	
	//하달간 정보 초기화
	@Override
	public void monthStatus() {
		mapper.monthStatus();
	}
	
	//한달간 정보 저장
	@Override
	public void saveStatus(AttendanceSave info) {
		mapper.saveStatus(info);
		
	}
	
	//근무 시간 저장
	@Override
	public List<AttendanceInfo> getInfo() {
		return mapper.getInfo();
	}
	@Override
	public List<Attendance> getAttendance(Attendance getDate) {
		return mapper.getAttendance(getDate);
	}
	@Override
	public void setTotalTime(Attendance li) {
		mapper.setTotalTime(li);
	}
	@Override
	public void setOverTime(Attendance li) {
		mapper.setOverTime(li);
	}
	@Override
	public String findMonthlyOvertime(int memberNo, String yearMonth) {
		return mapper.findMonthlyOvertime(memberNo, yearMonth);
	}
	
	// 연차 관리
	@Override
	public void annualSet(int memberNo) {
		mapper.annualSet(memberNo);
	}
	@Override
	public void annualSetFull(int memberNo) {
		mapper.annualSetFull(memberNo);;
	}
	@Override
	public AttendanceInfo annualInfo(int memberNo) {
		return mapper.annualInfo(memberNo);
	}
	@Override
	public void overTime(Attendance li) {
		mapper.overTime(li);
	}
	
	@Override
	public void notCheck(Attendance getAttendance) {
		mapper.notCheck(getAttendance);
	}
	@Override
	public List<AttendanceInfo> getNotVacation() {
		return mapper.getNotVacation();
	}
	@Override
	public void changeVacation(int memberNo) {
		mapper.changeVacation(memberNo);
	}
	@Override
	public void notCheckout(Attendance li) {
		mapper.notCheckout(li);
	}
	@Override
	public void goVacation(int memberNo) {
		mapper.goVacation(memberNo);
	}
	@Override
	public int minusAnnual(AttendanceInfo info) {
		return mapper.minusAnnual(info);
	}
	@Override
	public List<AttendanceDTO> allAttendance() {
		return mapper.allAttendance();
	}
	@Override
	public List<AttendanceDTO> searchAttendanceInfo(AttendancePagingDTO paging) {
		return mapper.searchAttendanceInfo(paging);
	}
	
	public int total() {
		return mapper.total();
	}
	
	@Override
	public List<AttendanceDTO> allAttendance(AttendancePagingDTO paging){ 
		return mapper.allAttendance(paging);
	}
	
	public int countAttendance(AttendancePagingDTO paging) {
		return mapper.countAttendance(paging);
	}
	
	
}
