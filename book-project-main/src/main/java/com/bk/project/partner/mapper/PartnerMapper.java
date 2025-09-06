package com.bk.project.partner.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bk.project.partner.dto.PartnerPagingDTO;
import com.bk.project.partner.vo.Partner;

@Mapper
public interface PartnerMapper {
	int newPartner(Partner partner);
	List<Partner> allPartner();
	List<Partner> searchPartner(PartnerPagingDTO paging);
	int deletePartner(int partnerNo);
	int updatePartner(Partner partner);
	Partner selectUpdate(int partnerNo);
	Partner findPartnerNo(int partnerNo);
	int countPartner(PartnerPagingDTO paging);
	Partner getPartner(@Param("partnerNo") int partnerNo);
}

