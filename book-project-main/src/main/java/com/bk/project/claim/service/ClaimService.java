package com.bk.project.claim.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.bk.project.book.mapper.BookMapper;
import com.bk.project.book.vo.Book;
import com.bk.project.claim.dto.ClaimPagingDTO;
import com.bk.project.claim.mapper.ClaimMapper;
import com.bk.project.claim.vo.Claim;
import com.bk.project.inventory.mapper.InventoryMapper;
import com.bk.project.inventory.vo.Inventory;
import com.bk.project.partner.mapper.PartnerMapper;
import com.bk.project.partner.vo.Partner;

@Service
public class ClaimService{

	@Autowired
	private ClaimMapper mapper;
	
	@Autowired
	private InventoryMapper invenMapper;
	
	@Autowired
	private PartnerMapper partnerMapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	// 도서 리스트 
	public List<Book> getBookList() {
        return bookMapper.allBooks();
    }
	
	// 업체 리스트
    public List<Partner> getPartnerList() {
    	return partnerMapper.allPartner();
    }

	// 신규 클레임 등록
	@Transactional
	public int newClaim(Claim claim) {
		
		if(claim.getDefectTypeList() != null && !claim.getDefectTypeList().isEmpty()) {
			claim.setDefectType(String.join(",", claim.getDefectTypeList()));
		} 
		
		 // 업체명 
        Partner partner = partnerMapper.findPartnerNo(claim.getPartnerNo());
        if (partner != null) {
            claim.setName(partner.getName());
        }

        // 도서명
        Book book = bookMapper.selectUpdate(claim.getBookNo());
        if (book != null) {
            claim.setTitle(book.getTitle());
            if(claim.getPrice() == null) claim.setPrice(book.getPrice());
        }
        
        Integer qty = claim.getQuantity();
        Integer price = claim.getPrice();
        claim.setTotalAmount((qty == null || price == null) ? 0 : qty * price);
        
        return mapper.newClaim(claim);
    }
	
	// 클레임 조회
	public List<Claim> searchClaim(ClaimPagingDTO dto) {
		return mapper.searchClaim(dto);
	}

	// 클레임 전체 조회
	public List<Claim> allClaim() {
		return mapper.allClaim();
	}
	
	public Integer countClaim(ClaimPagingDTO dto) {
		return mapper.countClaim(dto);
	}
	
    // 클레임 선택 수정버튼 이동
	public Claim selectClaim(int claimNo) {
		Claim claim = mapper.selectClaim(claimNo);

		if (claim.getDefectType() != null && !claim.getDefectType().equals("")) {
			claim.setDefectTypeList(Arrays.asList(claim.getDefectType().split(",")));
		}
		return claim;
	}
	
	// 클레임 수정
	public int updateClaim(Claim claim) {
		if(claim.getDefectTypeList() != null && !claim.getDefectTypeList().isEmpty()) {
			claim.setDefectType(String.join(",", claim.getDefectTypeList()));
		}
		if(claim.getQuantity() != null && claim.getPrice() != null) {
			claim.setTotalAmount(claim.getQuantity() * claim.getPrice());
		}
		return mapper.updateClaim(claim);
	}
	
	// 회수 상태 -> 완료 -> 수정 버튼 클릭 시 재고에 자동 반영
	@Transactional
	public void returnInven(Claim claim) {
		
	Claim origin = mapper.selectClaim(claim.getClaimNo());
	boolean complete = "완료".equals(claim.getRecallStatus());
	boolean notComplete = !"완료".equals(origin.getRecallStatus());

	// 클레임 업데이트
	mapper.updateClaim(claim);

	if (complete && notComplete) {
	Inventory inven = new Inventory();
	inven.setBookNo(claim.getBookNo());
	inven.setQuantity(claim.getQuantity());
	inven.setLocation(claim.getLocation());
	inven.setEndContractDate(null);
	inven.setActionType("RETURN");
	inven.setActionDate(claim.getClaimDate());
	inven.setReason(claim.getReason());

	invenMapper.insertInven(inven);
	}
}

	// 클레임 삭제
	public int deleteClaim(int claimNo) {
		return mapper.deleteClaim(claimNo);
	}

	// bookNo로 북 정보 하나
	public Book cSelectBook(int bookNo) {
		return mapper.cSelectBook(bookNo);
	}
	public int countAll(ClaimPagingDTO dto) {
		return mapper.countAll(dto);
	}

	

	
}
