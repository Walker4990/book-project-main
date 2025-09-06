<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags" %>
<header class="greet">
  <div class="welcome-box">
    <h2>Welcome, <sec:authentication property="principal.name" /> :)</h2>
    <p>(<span id="time"></span>)</p>
    <p>출근 시간: <span id="checkInDisplay"></span></p>
    <p>퇴근 시간: <span id="checkOutDisplay"></span></p>
  </div>

  <div class="personalMain">
    <ul class="personalBox">
      <!-- 품의서 -->
      <li>
        <button type="button" class="iconBtn" id="requestBtn">
          <img
            src="${pageContext.request.contextPath}/resources/assets/file.png"
            alt=""
            width="20"
          />
        </button>
        <ul class="depth_1">
          <li >
            <a href="${pageContext.request.contextPath}/allRequest"
              >품의서 조회</a
            >
          </li>
		  
        </ul>
      </li>

      <!-- 마이페이지 -->
      <li>
        <button type="button" class="iconBtn" id="myPageBtn">
          <img
            src="${pageContext.request.contextPath}/resources/assets/user.png"
            alt=""
            width="20"
          />
        </button>
        <ul class="depth_1">
          <li>
            <a href="${pageContext.request.contextPath}/myPage">내 정보</a>
          </li>
		  <li >
		  	<a href="#" id="openOvertimeModalBtn">야근 신청</a>
		  </li>
        </ul>
      </li>

      <!-- 로그아웃 (POST 권장) -->
      <li>
        <form action="${pageContext.request.contextPath}/logout" method="get">
          <button type="submit" class="iconBtn" id="logoutBtn">
            <img
              src="${pageContext.request.contextPath}/resources/assets/logout.png"
              alt=""
              width="20"
            />
          </button>
        </form>
      </li>
    </ul>
  </div>
</header>
