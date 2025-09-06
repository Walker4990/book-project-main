package com.bk.project.royalty.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.book.mapper.BookMapper;
import com.bk.project.contract.mapper.ContractMapper;
import com.bk.project.royalty.mapper.RoyaltyMapper;

@Service
public class RoyaltyService {
	
	@Autowired
	private ContractMapper contractMapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private RoyaltyMapper royaltyMapper;
	
}
