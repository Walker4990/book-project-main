package com.bk.project.tax.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.tax.vo.Tax;

@Mapper
public interface TaxMapper {
	void insertTax(Tax tax);

}
