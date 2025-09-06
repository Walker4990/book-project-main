package com.bk.project.member;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.member.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class Snippet {
	
	@ResponseBody
	@GetMapping("/getMemberNo")
	public int getMemberNo() {
	    Member m = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    System.out.println("Snippet : "+ m);
	    if (m == null) {
	        // 로그인 안 된 상태일 때는 -1 반환
	        return -1;
	    }
	    
	    return m.getMemberNo();
	}
}

