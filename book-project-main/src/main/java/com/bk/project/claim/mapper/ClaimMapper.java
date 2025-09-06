package com.bk.project.claim.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.book.vo.Book;
import com.bk.project.claim.dto.ClaimPagingDTO;
import com.bk.project.claim.vo.Claim;
import com.bk.project.inventory.vo.Inventory;

@Mapper
public interface ClaimMapper {
	
	int newClaim(Claim claim);
	List<Claim> searchClaim(ClaimPagingDTO dto);
	List<Claim> allClaim();
	Claim selectClaim(int claimNo);
	int updateClaim(Claim claim);
	void returnInven(Inventory inventory);
	int deleteClaim(int claimNo);
	Book cSelectBook (int bookNo);
	Integer countClaim(ClaimPagingDTO dto);
	int countAll(ClaimPagingDTO dto);
}
