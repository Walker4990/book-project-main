package com.bk.project.vacation.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.vacation.dto.VacationDTO;
import com.bk.project.vacation.dto.VacationPagingDTO;
import com.bk.project.vacation.mapper.VacationMapper;
import com.bk.project.vacation.vo.Vacation;

@Service
public class VacationService implements VacationMapper{

	@Autowired
	private VacationMapper vacationMapper;

	@Override
	public void addVacation(Vacation vacation) {
		vacationMapper.addVacation(vacation);
	}

	@Override
	public List<VacationDTO> allVacation() {
		return vacationMapper.allVacation();
	}

	@Override
	public Vacation getVacation(int vacationNo) {
		return vacationMapper.getVacation(vacationNo);
	}

	@Override
	public int approveVacation(Vacation vacation) {
		return vacationMapper.approveVacation(vacation);
	}

	@Override
	public int notApprove(Vacation vacation) {
		return vacationMapper.notApprove(vacation);
	}

	@Override
	public List<Vacation> getVacationInfo() {
		return vacationMapper.getVacationInfo();
	}

	@Override
	public List<Vacation> getApproveVacation() {
		return vacationMapper.getApproveVacation();
	}

	@Override
	public List<Vacation> notCheckApprove() {
		return vacationMapper.notCheckApprove();
	}

	@Override
	public List<VacationDTO> searchVacationInfo(String keyword) {
		return vacationMapper.searchVacationInfo(keyword);
	}

	/*
	@Override
	public List<VacationDTO> beforeVacation() {
		return vacationMapper.beforeVacation();
	}

	@Override
	public List<VacationDTO> afterVacation(VacationPagingDTO paging) {
		return vacationMapper.afterVacation(paging);
	}
	*/
	
	
	/*
	@Override
	public List<VacationDTO> searchBefore(String keyword) {
		return vacationMapper.searchBefore(keyword);
	}


	@Override
	public List<VacationDTO> searchAfter(VacationPagingDTO paging) {
		return vacationMapper.searchAfter(paging);
	}
	*/
	
	
	@Override
	public List<Map<String, Object>> vacationCalendar() {
		return vacationMapper.vacationCalendar();
	}
	public int total() {
		return vacationMapper.total();	
	}
	
	public int searchTotal(String keyword) {
		return vacationMapper.searchTotal(keyword);
	}
	
	
	//---------------------------------------------------------------------
	
	
	
	@Override
	public List<VacationDTO> searchBefore(VacationPagingDTO pagingBefore) {
		return vacationMapper.searchBefore(pagingBefore);
	}

	@Override
	public List<VacationDTO> searchAfter(VacationPagingDTO pagingAfter) {
		return vacationMapper.searchAfter(pagingAfter);
	}
	
	

	@Override
	public List<VacationDTO> beforeVacation(VacationPagingDTO pagingBefore) {
		return vacationMapper.beforeVacation(pagingBefore);
	}

	@Override
	public List<VacationDTO> afterVacation(VacationPagingDTO pagingAfter) {
		return vacationMapper.afterVacation(pagingAfter);
	}

	public int totalBefore() {
		return vacationMapper.totalBefore();
	}

	public int totalAfter() {
		return vacationMapper.totalAfter();
	}

	public int searchTotalBefore(String keyword) {
	
		return vacationMapper.searchTotalBefore(keyword);
	}

	public int searchTotalAfter(String keyword) {
		return vacationMapper.searchTotalAfter(keyword);
	}

	public List<Vacation> checkDuplicationVacation(Vacation vacation) {
		return vacationMapper.checkDuplicationVacation(vacation);
	}



	
}
