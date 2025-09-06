<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>로그인</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/reset.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/login.css"
    />
  </head>
  <body>
    <div class="loginCard">
      <img
        src="${pageContext.request.contextPath}/resources/assets/logo.png"
        alt=""
      />
      <h1>LOGIN</h1>
      <form action="/login" method="post">
        <div class="inputGroup">
          <input
            type="text"
            name="username"
            id="username"
            placeholder="아이디를 입력해주세요"
          />
        </div>
        <div class="inputGroup">
          <input
            type="password"
            name="password"
            id="password"
            placeholder="비밀번호를 입력해주세요"
          />
        </div>
        <div id="errorMessage"></div>
        <button class="loginBtn">로그인</button>
        <div class="findPwd">
          <a href="#">비밀번호 찾기</a>
        </div>
      </form>
    </div>
    <div class="registerCard">
      <form action="/register">
        <a href="/register">
          <h1>NEW IN</h1>
          <p>책이 천장에, 하늘에 닿는다.</p>
          <p>달의 서재 입사를 환영합니다 :)</p>
        </a>
      </form>
    </div>
  </body>
</html>
