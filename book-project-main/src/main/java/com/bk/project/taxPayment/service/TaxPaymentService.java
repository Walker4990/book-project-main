package com.bk.project.taxPayment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.financial.vo.Financial;
import com.bk.project.tax.vo.Tax;
import com.bk.project.taxPayment.dto.TaxPagingDTO;
import com.bk.project.taxPayment.mapper.TaxPaymentMapper;
import com.bk.project.taxPayment.vo.TaxPayment;

@Service
public class TaxPaymentService {

	@Autowired
	private TaxPaymentMapper mapper;
	
	public int insertTaxPayment(TaxPayment tp) {
		mapper.insertTaxPayment(tp);
		int result = mapper.updateTaxStatus(tp.getTaxNo());
		
		
		if(result > 0)
		{
			int taxNo = tp.getTaxNo();
			Tax tax = mapper.taxAmonutSelectByNo(taxNo);
			Tax tax1 = mapper.selectOneUnpaidTaxes(tp.getTaxNo());
			int amount = tax.getTaxAmount();
			Integer payment = mapper.selectSumPaymentByNo(taxNo);
			if(payment == null)
			{
				payment = 0;
			}
			if(amount == 0)
			{
				return -1;
			}
			
			if(amount <= payment)
			{
				int result2 = mapper.updatePaidTax(tp);
				if(result2 > 0)
				{
					return 1;
				}
				else
				{
					return -1;
				}
			}
			return 1;
		}
		return -1;
	}
	
	public List<Tax> selectUnpaidTaxes(){
		return mapper.selectUnpaidTaxes();
	}
	public List<Tax> selectPaidTaxes(){
		return mapper.selectPaidTaxes();
	}
	public List<TaxPayment> searchTaxPaidList(TaxPagingDTO paging){
		System.out.println(paging);
		return mapper.searchTaxPaidList(paging);
	}
	public int countSearchTaxPaidList(String month) {
		System.out.println(month);
		return mapper.countSearchTaxPaidList(month);
	}
	public List<TaxPayment> allTaxPaidList(TaxPagingDTO paging){
		System.out.println(paging);
		return mapper.allTaxPaidList(paging);
	}
	public int countAllTaxPaidList() {
		return mapper.countAllTaxPaidList();
	}
	public Tax taxAmonutSelectByNo(int taxNo)
	{
		return mapper.taxAmonutSelectByNo(taxNo);
	}
	public Integer selectSumPaymentByNo(int taxNo)
	{
		return mapper.selectSumPaymentByNo(taxNo);
	}
	public int updatePaidTax(TaxPayment payment)
	{
		return mapper.updatePaidTax(payment);
	}
	public Tax selectOneUnpaidTaxes(int taxNo)
	{
		return mapper.selectOneUnpaidTaxes(taxNo);
	}
}
