package com.bk.project.request.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bk.project.request.dto.RequestDTO;
import com.bk.project.request.dto.RequestPagingDTO;
import com.bk.project.request.vo.Request;

@Mapper
public interface RequestMapper {
	 int newRequest(Request request);
	 List<Request> searchRequest(RequestPagingDTO paging); 
	 List<Request> allRequest(RequestPagingDTO paging);
	 Request selectRequest(int requestNo);
	 int updateApprovalStatus(int requestNo);
	 int updateRequest(Request request);
	 int deleteRequest(int requestNo);
	 int notApproveRequest(int requestNo);
	 int countRequest(RequestPagingDTO paging);
	 
}
