package com.bk.project.taxPayment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.financial.vo.Financial;
import com.bk.project.tax.vo.Tax;
import com.bk.project.taxPayment.dto.TaxPagingDTO;
import com.bk.project.taxPayment.vo.TaxPayment;

@Mapper
public interface TaxPaymentMapper {
	void insertTaxPayment(TaxPayment tp);
	int updateTaxStatus(int taxNo);
	List<Tax> selectUnpaidTaxes();
	List<Tax> selectPaidTaxes();
	List<TaxPayment> allTaxPaidList(TaxPagingDTO paging);
	List<TaxPayment> searchTaxPaidList(TaxPagingDTO paging);
	int countAllTaxPaidList();
	int countSearchTaxPaidList(String month);
	Tax taxAmonutSelectByNo(int taxNo);
	Integer selectSumPaymentByNo(int taxNo);
	int updatePaidTax(TaxPayment payment);
	Tax selectOneUnpaidTaxes(int taxNo);
}
