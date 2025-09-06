package com.bk.project.member.config;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import com.bk.project.member.vo.Member;


import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter{

	
	@Autowired
	private  TokenProvider tokenProvider;
	
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, 
			FilterChain filterChain)
			throws ServletException, IOException {
		//클라이언트에서 보낸 토큰을 받아서 사용자 확인 후 인증 처리
		String token = parseBearerToken(request);
		
		if(token!= null && !token.equalsIgnoreCase("null")){
			Member member = tokenProvider.validate(token);
			
			// 추출된 인증 정보를 필터링해서 사용할 수 있도록 SecurityContext 등록
			AbstractAuthenticationToken authentication = new UsernamePasswordAuthenticationToken
			(token, null, member.getAuthorities());
			authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
			SecurityContextHolder.getContext().setAuthentication(authentication);
		
		}
		filterChain.doFilter(request, response);
		
	}
	
	//값을 받는 메서드
		private String parseBearerToken(HttpServletRequest request){
			String bearerToken =  request.getHeader("Authorization");
			if(StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer"))
			{
				return bearerToken.substring(7);
			}
			return null;
		}

}
