package com.bk.project.partner.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;
import com.bk.project.partner.dto.PartnerPagingDTO;
import com.bk.project.partner.mapper.PartnerMapper;
import com.bk.project.partner.vo.Partner;
import com.bk.project.tax.mapper.TaxMapper;
import com.bk.project.tax.vo.Tax;

@Service
public class PartnerService {

	@Autowired
	private PartnerMapper mapper;
	
	
	//거래처 등록
	public int newPartner(Partner partner) {
		
		
		return mapper.newPartner(partner);
	}
	//거래처 정보 변경
	public int updatePartner(Partner partner)
	{
		return mapper.updatePartner(partner);
	}
	//거래처 전체  조회
	public List<Partner> allPartner()
	{
		return mapper.allPartner();
	}
	//거래처 정보 조회
	public List<Partner> searchPartner(PartnerPagingDTO dto)
	{
		return mapper.searchPartner(dto);
	}
	//수정화면 이동 시 라디오 값과 함께 이동
	public Partner selectUpdate(int partnerNo)
	{
		return mapper.selectUpdate(partnerNo);
	}
	
	//거래처 정보 삭제
	public int deletePartner(int partnerNo)
	{
		return mapper.deletePartner(partnerNo);
	}
	
	// 클레임 등록 시 거래처 이름 가져오기
	public Partner findPartnerNo(int partnerNo) {
		return mapper.findPartnerNo(partnerNo);
	}
	// 거래처 조회 페이징
	public int countPartner(PartnerPagingDTO paging) {
		return mapper.countPartner(paging);
	}
	// 거래처 정보 수정 모달 값 가져오기
	public Partner getPartner(int partnerNo) {
		return mapper.getPartner(partnerNo);
	}
}
