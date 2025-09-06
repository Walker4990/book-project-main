<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>마이 페이지</title>

    
  </head>

  <body>
    <section class="profileCard">
      <div class="profileHead">
        <h1>MY PROFILE</h1>

        <sec:authentication var="member" property="principal" />

        <div class="title">
          <h2><sec:authentication property="principal.name" /></h2>
          <p class="dept">
            <sec:authentication property="principal.dept_name" />
          </p>
          <p class="sub"><sec:authentication property="principal.id" /></p>
        </div>

        <div class="actions">
          <form
            action="${pageContext.request.contextPath}/updateInfo"
            method="get"
          >
            <button class="btn">회원 정보 수정</button>
          </form>
        </div>
      </div>

      <dl class="info">
        <div class="myInfo">
          <dt>아이디</dt>
          <dd><sec:authentication property="principal.id" /></dd>
        </div>
        <div class="myInfo">
          <dt>이메일</dt>
          <dd><sec:authentication property="principal.email" /></dd>
        </div>
        <div class="myInfo">
          <dt>부서</dt>
          <dd><sec:authentication property="principal.dept_name" /></dd>
        </div>
        <div class="myInfo">
          <dt>주소</dt>
          <dd><sec:authentication property="principal.addr" /></dd>
        </div>
        <div class="myInfo">
          <dt>입사일</dt>
          <dd><sec:authentication property="principal.joinDate" /></dd>
        </div>
      </dl>
    </section>
  </body>
</html>
