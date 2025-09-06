<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/salary.css" />
    <title>급여 수정</title>
  </head>
  <body>
	<section class="updateSalary">
	<div class="updateSalaryBox">
	<h1>급여 수정</h1>
	<form id="updateForm" action="/updateSalary" method="post">
	   <!-- PK hidden -->
	  
	   <div class="inputGroup">
	   	  <input type="hidden" name="salaryNo" value="${salary.salaryNo}" />
	   	  <label for="memNo">사번</label>
	   	  <input type="number" id="memNo" name="memNo" value="${salary.memberNo}" readonly />
	   </div>
	   		 
	   <div class="inputGroup">
	   	  <label for="name">사원명</label>
	   	  <input type="text" id="name" name="name" value="${salary.name}" readonly />
	   </div>
	   
	   <div class="inputGroup">
	   	 <label for="name">부서명</label>
	   	 <input type="text" id="name" name="name" value="${salary.deptName}" readonly />
	   </div>
		   
	  <div class="inputGroup">
		 <label for="name">기본급</label>
		 <input type="number" id="name" name="name" value="${salary.baseSalary}" required />
	  </div>
			   
	  <div class="inputGroup">
		 <label for="name">직책수당</label>
		 <input type="number" id="name" name="name" value="${salary.positionAllowance}" />
	  </div>
				   
	  <div class="inputGroup">
		 <label for="name">식대</label>
		 <input type="number" id="name" name="name" value="${salary.mealAllowance}" />
	  </div>
					   
	  <div class="inputGroup">
		 <label for="name">초과근무 수당</label>
		 <input type="number" id="name" name="name" value="${salary.otRate}" />
	  </div>
						   
	  <div class="inputGroup">
		 <label for="name">보너스</label>
		 <input type="number" id="name" name="name" value="${salary.bonus}" />
	  </div>
	   
	  <div class="btnArea">
	  	 <button type="submit" class="btnNavy">저장</button>
	  	 <a href="/allSalary" class="btnGray">취소</a>
	  </div>
	  </form>
	  </div>
	  </section>
	   
  </body>
</html>
