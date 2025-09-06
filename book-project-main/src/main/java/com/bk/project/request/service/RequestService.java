package com.bk.project.request.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.member.mapper.MemberMapper;
import com.bk.project.member.vo.Member;
import com.bk.project.request.dto.RequestDTO;
import com.bk.project.request.dto.RequestPagingDTO;
import com.bk.project.request.mapper.RequestMapper;
import com.bk.project.request.vo.Request;

@Service
public class RequestService {
	
	 @Autowired
	    private RequestMapper requestMapper;
	 
	 @Autowired
	 private MemberMapper memberMapper;
	 
	 // 멤버 리스트
	 public List<Member> getMemberList() {
		 return memberMapper.allMembers();
	 }

	    // 신규 품의서 등록
	 public int newRequest(Request request) {
		    Member member = memberMapper.findMemberNo(request.getMemberNo());
		    if(member != null) {
		        request.setMemberName(member.getName());
		    }
		    Member approver = memberMapper.findMemberNo(request.getApproverNo());
		    if (approver != null) {
		        request.setApproverName(approver.getName());
		    }
		   return requestMapper.newRequest(request);
		}
	 
	    // 특정 품의서 검색
	    public List<Request> searchRequest(RequestPagingDTO paging) {
			return requestMapper.searchRequest(paging);
	    }

	    // 품의서 조회
	    public List<Request> allRequest(RequestPagingDTO paging) {
	        return requestMapper.allRequest(paging);
	    }

	    public Request selectRequest(int requestNo) {
	        return requestMapper.selectRequest(requestNo);
	    }

	    public int updateApprovalStatus(int requestNo) {
	        return requestMapper.updateApprovalStatus(requestNo);
	    }
	    
	    public int notApproveRequest(int requestNo) {
	        return requestMapper.notApproveRequest(requestNo);
	    }

	    public int updateRequest(Request request) {
	        return requestMapper.updateRequest(request);
	    }
	    
	    public int deleteRequest(int requestNo) {
			return requestMapper.deleteRequest(requestNo);
	    	
	    }

		public int countRequest(RequestPagingDTO paging) {
			return requestMapper.countRequest(paging);
		}

}
