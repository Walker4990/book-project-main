package com.bk.project.member.config;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.Map;

import javax.crypto.SecretKey;

import org.springframework.stereotype.Service;

import com.bk.project.member.vo.Member;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

@Service
public class TokenProvider {
	//보완
		private final SecretKey secretKey = Keys.secretKeyFor(SignatureAlgorithm.HS512);
		//로그인을 했을 때 정보를 토큰으로 만들어주는 메서드
		public String create(Member member)
		{
			return Jwts.builder()
					.signWith(secretKey, SignatureAlgorithm.HS512)
					.setClaims(Map.of(
						"id", member.getId(),
						"name", member.getName(),
						"role", member.getRole()
					))
					.setIssuedAt(new Date())//토큰 발행 시점
					.setExpiration(Date.from(Instant.now().plus(1,ChronoUnit.DAYS)))// 토큰 만료 시점
					.compact();
		}
		
		//유저 정보 가져오기
		public Member validate(String token)
		{
			Claims claims = Jwts
					.parserBuilder()
					.setSigningKey(secretKey)
					.build()
					.parseClaimsJws(token)
					.getBody();
					
			return Member.builder()
					.id((String)claims.get("id"))
					.name((String) claims.get("name"))
					.role((String) claims.get("role"))
					.build();
		}
		
		
}
