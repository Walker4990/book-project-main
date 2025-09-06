package com.bk.project.member.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
public class SecurityConfig {

	@Autowired
	private JwtAuthenticationFilter jwtFilter;
	
	//제어 메서드
		@Bean
		public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
			return http
					.csrf(csrf -> csrf.disable()) //웹 보안 토큰 설정(비활성화)
					.authorizeHttpRequests(authorize -> 
						authorize
							.requestMatchers("/mypage").authenticated()
							.requestMatchers("/admin").hasRole("ADMIN")// role 컬럼이 ADMIN만 들어갈 수 있음(앞에 ROLE_ 은 자동으로 읽어줌)
							.requestMatchers("/updateInfo").permitAll() //어떤 요청이든 전부 수락
							.anyRequest().permitAll()
					)
					.formLogin(form ->
					form.loginPage("/login")
					.defaultSuccessUrl("/main")
					.failureUrl("/login?error")  
					)
					
					.logout(logout ->
					logout.logoutUrl("/logout")
					.logoutSuccessUrl("/")
					) 
					.build();
		}
		
		@Bean
		public PasswordEncoder passwordEncorder(){
			return new BCryptPasswordEncoder();
		}
}
