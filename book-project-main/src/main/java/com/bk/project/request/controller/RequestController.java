package com.bk.project.request.controller;

import java.io.File;
import java.io.IOException;
import java.security.Provider.Service;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bk.project.claim.vo.Claim;
import com.bk.project.contract.dto.ContractPagingDTO;
import com.bk.project.member.service.MemberService;
import com.bk.project.member.vo.Member;
import com.bk.project.request.dto.RequestDTO;
import com.bk.project.request.dto.RequestPagingDTO;
import com.bk.project.request.service.RequestService;
import com.bk.project.request.vo.Request;

import jakarta.servlet.http.HttpSession;

@Controller
public class RequestController {
	
	@Autowired
    private RequestService requestService;
    @Autowired
    private MemberService memberService;

    
    private String path =  "\\\\192.168.0.10\\engrp\\";
    
    public String fileUpload(MultipartFile file)
    {
    	UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() +"_"+ file.getOriginalFilename();
		File copyFile = new File(path+ fileName);
		try {
			file.transferTo(copyFile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		System.out.println("파일 이름 : "+fileName);
    	return fileName;
    }
    
    
    
    // 신규 클레임 등록
    @ResponseBody
    @PostMapping("/newRequest")
    public String submit(Request request, MultipartFile file) throws Exception {
    	Member writer = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (writer == null) {
            // 로그인 안 된 경우 → 로그인 페이지로 이동
            return "redirect:/login";
        }

        // 파일 저장
        if (file != null && !file.isEmpty()) {
            String fileName = fileUpload(file);
            request.setFilePath(fileName);
        }
        request.setMemberNo(writer.getMemberNo());
       int result = requestService.newRequest(request);
        if(result >0)
        {
        	return "success";
        }
        return "fail";
    }

    // 특정 품의서 검색 조회
    @PostMapping("/allRequest")
    public String keyword(RequestPagingDTO paging, Model model) {
        List<Request> list;
        int total = requestService.countRequest(paging);
        if (paging.getKeyword() == null || paging.getKeyword().trim().isEmpty()) {
	        list = requestService.allRequest(paging);
	    } else {
	        list = requestService.searchRequest(paging);
	    }
        Member writer = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("approvers", memberService.allMembers());
        model.addAttribute("writer", writer);
        model.addAttribute("list", list);
        model.addAttribute("paging", new RequestPagingDTO(paging.getPage(), total));
        model.addAttribute("page", "requestPage/allRequest.jsp");
        return "common/layout";
    }
    
    //모달용
    @ResponseBody
    @GetMapping("/getRequestDetail")
    public Request getRequestDetail(int no)
    {
    	Request re = requestService.selectRequest(no);
    	return re;
    }
    
    @GetMapping("/allRequest")
    public String list(RequestPagingDTO paging, Model model) {
    	Member writer = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	List<Request> list;
        
    	if (paging.getKeyword() == null || paging.getKeyword().trim().isEmpty()) {
	        list = requestService.allRequest(paging);
	    } else {
	        list = requestService.searchRequest(paging);
	    }
        
    	int total = requestService.countRequest(paging);
        System.out.println("list : "+ list);
    	System.out.println("total : "+ total);
    	model.addAttribute("approvers", memberService.allMembers());
        model.addAttribute("writer", writer);
        model.addAttribute("list",list);
        model.addAttribute("paging", new RequestPagingDTO(paging.getPage(), total));

        model.addAttribute("page", "requestPage/allRequest.jsp");
        return "common/layout";
    }

    //기존 품의서 상세 페이지
    @GetMapping("/viewRequest")
    public String view(int no, Model model) {
        Request request = requestService.selectRequest(no);
        Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        boolean isWriter = false;
        boolean isApprover = false;

        if (member != null) {
            isWriter = member.getMemberNo() == request.getMemberNo();
            isApprover = member.getMemberNo() == request.getApproverNo();
        }

        model.addAttribute("request", request);
        model.addAttribute("isWriter", isWriter);
        model.addAttribute("isApprover", isApprover);
        model.addAttribute("page", "requestPage/viewRequest.jsp");
        return "common/layout";
    }

    //승인
    @ResponseBody
    @PostMapping("/approveRequest")
    public String approve(int requestNo) {
    	System.out.println(requestNo);
        int result = requestService.updateApprovalStatus(requestNo);
        if(result > 0)
        {
        	return "승인처리가 완료되었습니다";
        }
        return "승인 처리에 실패했습니다.";
    }
    //반려
    @ResponseBody
    @PostMapping("/notApproveRequest")
    public String notApprove(int requestNo) {
    	System.out.println(requestNo);
        int result = requestService.notApproveRequest(requestNo);
        if(result > 0)
        {
        	return "반려처리가 완료되었습니다";
        }
        return "반려처리에 실패했습니다.";
    }
    
    
    
    //수정
    @ResponseBody
    @PostMapping("/updateRequest")
    public String update(Request request) {
    	System.out.println("받은 request 값 : "+request);
        requestService.updateRequest(request);
        return "수정이 완료되었습니다.";
    }
    
    //삭제
    @ResponseBody
    @PostMapping("/deleteRequest")
    public String deleteRequest(int requestNo) {
    	requestService.deleteRequest(requestNo);
    	return "삭제를 완료하였습니다.";
    }
}
