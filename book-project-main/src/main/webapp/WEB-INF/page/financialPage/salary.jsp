<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
	
    <h1>급여/상여금 관리</h1>
	<section class="section1">
	<h2>급여내역</h2>
	<!-- 선택할 수 있게
	     선택해서 삭제할 수 있게(삭제 버튼 필요)
	     사원 추가할 수 있게(신규 인원 있을 경우 추가할 수 있게)(사원 추가 버튼 필요) -->
	<!-- 사번 / 성명 / 부서명 / 직책 / 급여합계 / 공제액계 / 실지급액 
	출퇴근 관리와 이어지는 : 근로일수(일 / 시간)
	-->
	사번 : <input type="text" name="memberNo" /><br>
	성명 : <input type="text" name="memberName" /><br>
	부서명 : <input type="text" name="deptName" /><br>
	직책 : <input type="text" name="position" /><br>
	급여합계 : <input type="text" name="totalSalary" /><br>
	공제액계 : <input type="text" name="totalDeduction" /><br>
	실지급액 : <input type="text" name="actualPay" /><br>
	근로일수 : 
	<input type="text" name="workingDays" /> 일 /
	<input type="text" name="workingHours" /> 시간
	</label><br>
	
	<button id="add" type="button">사원추가</button>
	<button id="delete" type="button">삭제</button>
	</section>
	
	<section class="section2">
	<h2>지급항목</h2>	
	<!-- 기본급 / 식대 / 연장수당 / 기타 상여금 -->
	기본급 : <input type="text" name="salary" /><br>
	식대 : <input type="text" name="foodCharge" /><br>
	연장수당 : <input type="text" name="otPay" /><br>
	기타 상여금 : <input type="text" name="bonus" /><br>
	</section>
	
	<section class="section3">
	<h2>공제항목</h2>	
	<!-- 정산소득세 / 정산주민세 / 소득세 / 주민세 / 건강보험 / 장기요양보험 / 국민연금 / 고용보험 
		/ 건강보험정산액 / 요양보험정산액 / 고용보험정산액 
	-->	
	정산소득세 : <input type="text" name="taxAdjIncome" /><br>
	정산주민세 : <input type="text" name="taxAdjResident" /><br>
	소득세 : <input type="text" name="incomeTax" /><br>
	주민세 : <input type="text" name="residentTax" /><br>
	건강보험 : <input type="text" name="healthInsurance" /><br>
	장기요양보험 : <input type="text" name="nursingInsurance" /><br>
	국민연금 : <input type="text" name="nationalPension" /><br>
	고용보험 : <input type="text" name="employmentInsurance" /><br>
	건강보험정산액 : <input type="text" name="healthAdj" /><br>
	요양보험정산액 : <input type="text" name="nursingAdj" /><br>
	고용보험정산액 : <input type="text" name="employmentAdj" /><br>
	</section>
	
	<script>
		("#add").click(() => {
			location.href="/addMember"
		});
	</script>
	
  </body>
</html>
