package com.bk.project.marketing.service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.bk.project.overtime.controller.OverTimeController;
import com.bk.project.tax.mapper.TaxMapper;
import com.bk.project.tax.vo.Tax;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.contract.vo.ContractExpired;
import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;
import com.bk.project.marketing.dto.MarketingDTO;
import com.bk.project.marketing.dto.PagingDTO;
import com.bk.project.marketing.mapper.MarketingMapper;
import com.bk.project.marketing.vo.Marketing;
import com.bk.project.marketing.vo.MarketingExpired;
import com.bk.project.member.vo.Member;

@Service
public class MarketingService {

    private final OverTimeController overTimeController;

	@Autowired
	private MarketingMapper mapper;
	
	@Autowired
	private FinancialMapper financeMapper;
	



    MarketingService(OverTimeController overTimeController) {
        this.overTimeController = overTimeController;
    }
	
	@Transactional
	public int newMarketing(Marketing marketing) {
		int result =  mapper.newMarketing(marketing);
		
		 Financial fi = new Financial();
		fi.setType("EXPENSE");
		fi.setCategory("마케팅 비용 지급");
		fi.setRelatedNo(marketing.getEventNo());
		fi.setTotalPrice(marketing.getCost());
		fi.setTransactionDate(LocalDate.now());
		fi.setDescription("마케팅 비용 : " + marketing.getEventNo() + " 마케팅 비용 납부");
		financeMapper.insertFinance(fi);
		
		
		
		return result;
	}
	
	
	/*
	 *전체 리스트 조회
	public List<MarketingDTO> allMarketing(MarketingDTO dto)
	{
		return mapper.allMarketing(dto);
	}
	*/
	
	public int updateMarketing(Marketing marketing) {
		return mapper.updateMarketing(marketing);
	}
	
	
	public Marketing getMarketingByNo(Integer eventNo) {
		return mapper.getMarketingByNo(eventNo);
	}

	public int deleteMarketing(int eventNo)
	{
		return mapper.deleteMarketing(eventNo);
	}

	
	
	public List<MarketingDTO> allMarketing(PagingDTO paging){
		
		  paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		    List<MarketingDTO> list = mapper.searchMarketing(paging);

		    
		    List<MarketingDTO> dtoList = new ArrayList<>();
		    for (MarketingDTO m : list) {
		        MarketingDTO dto = new MarketingDTO();
		        dto.setEventNo(m.getEventNo());
		        dto.setCompanyName(m.getCompanyName());
		        dto.setCreatedAt(m.getCreatedAt());
		        dto.setCreatedBy(m.getCreatedBy());
		        dto.setDepartment(m.getDepartment());
		        dto.setEventType(m.getEventType());
		        dto.setEventName(m.getEventName());
		        dto.setDurationStart(m.getDurationStart());
		        dto.setDurationEnd(m.getDurationEnd());
		        dto.setCost(m.getCost());
		        dtoList.add(dto);
		    }
		    return dtoList;
	}
	public List<MarketingDTO> allMarketingExpired(PagingDTO paging)
	{
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		List<Marketing> list = mapper.allMarketingExpired(paging);
		List<MarketingDTO> dtoList = new ArrayList<MarketingDTO>();
		for(Marketing m : list) {
			MarketingDTO dto = new MarketingDTO();
			dto.setEventNo(m.getEventNo());
	        dto.setCompanyName(m.getCompanyName());
	        dto.setCreatedAt(m.getCreatedAt());
	        dto.setCreatedBy(m.getCreatedBy());
	        dto.setDepartment(m.getDepartment());
	        dto.setEventType(m.getEventType());
	        dto.setEventName(m.getEventName());
	        dto.setDurationStart(m.getDurationStart());
	        dto.setDurationEnd(m.getDurationEnd());
	        dto.setCost(m.getCost());
			dtoList.add(dto);
		}
		return dtoList;
	}
	
	public Member checkManager(Marketing marketing)
	{
		return mapper.checkManager(marketing);
	}
	
	
	public Marketing select(int eventNo) {
		return mapper.select(eventNo);
	}
	
	public int total(PagingDTO paging) {
		return mapper.total(paging);
	}
	public int totalAll() {
		return mapper.totalAll();
	}
	
//	public void syncExpiredEvents() {
//		 List<Integer> expiredEventNos = mapper.findExpiredEventNos();
//		 for (Integer eventNo : expiredEventNos) {
//		        mapper.syncExpiredEvents(eventNo, LocalDate.now().toString());
//		    }
//	}; // 마감된 이벤트를 expired 테이블로 동기화

    public List<Marketing> getExpiredEvents(PagingDTO paging) {
    	 return mapper.getAllExpired();
    }
    @Transactional
    @Scheduled(cron = "0 0 0 * * *", zone = "Asia/Seoul") // 매일 자정
//    @Scheduled(fixedRate = 3000)
    public void moveExpiredMarketingDaily() {
    	 List<Integer> expiredEventNos = mapper.findExpiredEventNos();
    	    int ins = 0, del = 0;

    	    for (Integer eventNo : expiredEventNos) {
    	        ins += mapper.syncExpiredEvents(eventNo, LocalDate.now().toString());
    	        del += mapper.deleteMarketing(eventNo);
    	    }

    	    System.out.println("[MarketingExpiredJob] inserted=" + ins + ", deleted=" + del);
    }

	public List<MarketingDTO> searchMarketing(PagingDTO fixedPaging) {
		return mapper.searchMarketing(fixedPaging);
	};
	
	public List<MarketingExpired> allMarketingExpiredList(PagingDTO paging){
		return mapper.allMarketingExpiredList(paging);
	}
	public List<MarketingExpired> searchMarketingExpired(PagingDTO paging){
		return mapper.searchMarketingExpired(paging);
	}
	public int countMarketingExpired(PagingDTO paging) {
		return mapper.countMarketingExpired(paging);
	}
	public int countAllMarketingExpired() {
		return mapper.countAllMarketingExpired();
	}

} 
