package com.bk.project.tax.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.tax.mapper.TaxMapper;
import com.bk.project.tax.vo.Tax;

@Service
public class TaxService {

	@Autowired
	private TaxMapper mapper;
	
	public void insertTax(Tax tax) {
		mapper.insertTax(tax);
	}
}
