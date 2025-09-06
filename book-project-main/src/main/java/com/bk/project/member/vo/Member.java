package com.bk.project.member.vo;

import java.time.LocalDate;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class Member implements UserDetails{

	private int memberNo;
	private String name;
	private String id; 
	private String password;
	private int deptNo;
	private String position;
	private String dept;
	private String addr;
	private String email;
	private String role;
	private String dept_name;
	private LocalDate joinDate;
	private LocalDate quitDate;
	private String type;
	

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of(new SimpleGrantedAuthority(role));
	}


	@Override
	public String getUsername() {
		return this.id;
	}
	
	@Override
	public String getPassword() {
		
		return this.password;
	}
}
