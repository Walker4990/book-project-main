package com.bk.project.royalty.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.royalty.vo.Royalty;

@Mapper
public interface RoyaltyMapper {
	
	void insertRoyalty(Royalty r);
	
	int deleteRoyaltyByBookNo(int contractNo);
}
