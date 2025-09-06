package com.bk.project.marketing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bk.project.contract.vo.ContractExpired;
import com.bk.project.marketing.dto.MarketingDTO;
import com.bk.project.marketing.dto.PagingDTO;
import com.bk.project.marketing.vo.Marketing;
import com.bk.project.marketing.vo.MarketingExpired;
import com.bk.project.member.vo.Member;

@Mapper
public interface MarketingMapper {
	//	전체 리스트 조회 List<MarketingDTO> allMarketing(MarketingDTO dto);
	int newMarketing(Marketing marketing);	
	int updateMarketing(Marketing marketing);
	Marketing getMarketingByNo(int eventNo);
	int deleteMarketing(int eventNo);
	List<Marketing> allMarketing(PagingDTO paging);
	List<Marketing> allMarketingExpired(PagingDTO paging);
	
	Marketing select(int eventNo);
	int total(PagingDTO paging);
	int totalAll();
	Member checkManager(Marketing marketing);
	
    // 만료 이벤트 insert(marketing_expired)
    int syncExpiredEvents(@Param("eventNo") int eventNo, @Param("closedAt") String closedAt);
    // 모든 만료 이벤트 조회
    List<Marketing> getAllExpired();
  
    
    // 마감된 이벤트 번호들 조회
    List<Integer> findExpiredEventNos();
	List<MarketingDTO> searchMarketing(PagingDTO paging);

	// 만료된 이벤트 페이징 처리
	List<MarketingExpired> allMarketingExpiredList(PagingDTO paging);
	List<MarketingExpired> searchMarketingExpired(PagingDTO paging);

	int countMarketingExpired(PagingDTO paging);
	int countAllMarketingExpired();
}
