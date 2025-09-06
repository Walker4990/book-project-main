package com.bk.project.contract.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.author.mapper.AuthorMapper;
import com.bk.project.author.vo.Author;
import com.bk.project.book.mapper.BookMapper;
import com.bk.project.book.vo.Book;
import com.bk.project.contract.dto.ContractDTO;
import com.bk.project.contract.dto.ContractPagingDTO;
import com.bk.project.contract.dto.ContractExpiredDTO;
import com.bk.project.contract.dto.ContractPagingDTO;
import com.bk.project.contract.mapper.ContractMapper;
import com.bk.project.contract.vo.Contract;
import com.bk.project.contract.vo.ContractExpired;
import com.bk.project.defect.mapper.DefectMapper;
import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;
import com.bk.project.inventory.mapper.InventoryMapper;
import com.bk.project.printorder.mapper.PrintOrderMapper;
import com.bk.project.royalty.mapper.RoyaltyMapper;
import com.bk.project.tax.mapper.TaxMapper;
import com.bk.project.tax.vo.Tax;

@Service
public class ContractService {
	
	@Autowired
	private ContractMapper mapper;

	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private FinancialMapper financeMapper;
	
	@Autowired
	private TaxMapper taxMapper;
	
	@Autowired
	private InventoryMapper inventoryMapper;
	
	@Autowired
	private DefectMapper defectMapper;
	
	@Autowired
	private PrintOrderMapper printOrderMapper;
	
	@Autowired
	private AuthorMapper authorMapper;
	@Autowired
	
	private RoyaltyMapper royaltyMapper;
	@Transactional
	public void newContract(Contract contract) {
		
		mapper.newContract(contract);
		
		// 계약서에 작성된 작가 등록
		Author author = new Author();
		author.setAuthorName(contract.getAuthorName());
		author.setNationality(contract.getNationality());
		author.setGender(contract.getGender());
		author.setBirthDate(contract.getBirthDate());
		author.setContractNo(contract.getContractNo());
		authorMapper.insertAuthor(author);
				
		// 계약서에 작성된 책 등록
		Book book = new Book();
		book.setTitle(contract.getBookTitle());
		book.setAuthor(contract.getAuthorName());
		book.setPublishDate(contract.getPublishDate());
		book.setPrice(contract.getPrice());
		book.setGenre(contract.getGenre());
		book.setContractNo(contract.getContractNo());
		int result = bookMapper.newBook(book);
		
		Financial fi = new Financial();
		fi.setType("EXPENSE");
		fi.setCategory("작가 계약금 지급");
		fi.setRelatedNo(contract.getContractNo());
		fi.setTotalPrice(contract.getContractAmount());
		fi.setTransactionDate(LocalDate.now());
		fi.setDescription("계약 번호 : " + contract.getContractNo() + " 작가 계약금 지급");
		financeMapper.insertFinance(fi);
		
		int taxAmount = (int) Math.round(contract.getContractAmount() * 0.033);
		
		Tax tax = new Tax();
		tax.setCategory("원천세");
		tax.setRelatedTable("Contract");
		tax.setRelatedNo(contract.getContractNo());
		tax.setTaxAmount(taxAmount);
		tax.setTaxRate(3.3);
		tax.setTaxDate(LocalDate.now());
		tax.setDescription("계약 번호 : " + contract.getContractNo() + " 작가 원천세");
		taxMapper.insertTax(tax);
		
	}
	
	public List<Contract> allContract(ContractPagingDTO fixedPaging) {
		return mapper.allContract(fixedPaging);
	}
	
	public List<Contract> searchContract(ContractPagingDTO paging) {
		return mapper.searchContract(paging);
	}
	
	public int countContract(ContractPagingDTO paging) {
		return mapper.countContract(paging);
	}
	
	public int updateContract(Contract contract) {
		   // 날짜 유효성 검사 (null 방지 포함)
	    if (contract.getManuscriptDue() != null && contract.getPrintDate() != null &&
	        contract.getManuscriptDue().isAfter(contract.getPrintDate())) {
	        throw new IllegalArgumentException("원고 마감일은 인쇄일보다 늦을 수 없습니다.");
	    }

	    if (contract.getPublishDate() != null && contract.getPrintDate() != null &&
	        contract.getPublishDate().isBefore(contract.getPrintDate())) {
	        throw new IllegalArgumentException("출판일은 인쇄일보다 빠를 수 없습니다.");
	    }
	    
		return mapper.updateContract(contract);
	}

	public Contract getContractByNo(Integer contractNo) {
		return mapper.getContractByNo(contractNo);
	}
	
	@Transactional
	public int deleteContract(int contractNo) {
		 // 1. contractNo로 연결된 bookNo 조회
	    List<Integer> bookNoList = mapper.findBookNoByContract(contractNo);

	    // 2. inventory 먼저 삭제
	    for (int bookNo : bookNoList) {
	    	royaltyMapper.deleteRoyaltyByBookNo(bookNo);
	    	mapper.deleteQualityCheckByBookNo(bookNo);
	    	printOrderMapper.deleteByBookNo(bookNo);
	    	defectMapper.deleteByBookNo(bookNo);
	        inventoryMapper.deleteByBookNo(bookNo);
	        
	    }
	    
	    // 3. book 삭제
	    mapper.deleteContractByBook(contractNo);

	    // 4. author 삭제
	    mapper.deleteContractByAuthor(contractNo);

	    // 5. contract 삭제
	    return mapper.deleteContract(contractNo);
	}
	
	public boolean confirmContract(String bookTitle) {
		return mapper.confirmContract(bookTitle) > 0;
	}
	
	@Transactional
	@Scheduled(cron = "0 00 00 * * * ", zone = "Asia/Seoul")
	public void moveExpiredContractsDaily() {
	    int ins = mapper.insertExpiredAuto();
	    int upd = mapper.markContractsExpired();
	    int del = mapper.deleteExpiredContracts();
	    System.out.println("[ExpiredJob] inserted=" + ins + ", updated=" + upd+ ", deleted=" + del);
	    
	    
	}
	// 테스트용
	@Transactional
	public int insertExpired(int contractNo, String closeType, String closeReason) {
	    int moved = mapper.insertExpiredByContractNo(contractNo, closeType, closeReason);
	    if (moved == 0) return 0;
	    royaltyMapper.deleteRoyaltyByBookNo(contractNo);
	    List<Integer> bookNoList = mapper.findBookNoByContract(contractNo);

	    for (int bookNo : bookNoList) {
	      ;
	        mapper.deleteQualityCheckByBookNo(bookNo);
	        printOrderMapper.deleteByBookNo(bookNo);
	        defectMapper.deleteByBookNo(bookNo);
	        inventoryMapper.deleteByBookNo(bookNo);
	    }

	    // book 삭제
	    mapper.deleteContractByBook(contractNo);

	    // contract 삭제
	    int deleted = mapper.deleteContract(contractNo);

	    // contract 삭제된 이후 author 삭제
	    if (deleted > 0) {
	        mapper.deleteContractByAuthor(contractNo);
	    }

	    return (deleted > 0) ? moved : 0;
	}
	

	
	public List<Contract> selectContractDate(){
		return mapper.selectContractDate();
	}

	public int insertContractCalendar(Map<String, Object> param) {
		return mapper.insertContractCalendar(param);
	}
	
	public List<ContractExpired> expiredList(@Param("paging") ContractPagingDTO paging){
		return mapper.expiredList(paging);
	}
	
	public int total() {
		return mapper.total();
	}
	public Contract selectContractDetail(int contractNo) {
		return mapper.selectContractDetail(contractNo);
	}
	public int countAll() {
		return mapper.countAll();
	}
}


