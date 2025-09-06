<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 나중에 삭제 -->
<!-- 나중에 삭제 -->
<!-- 나중에 삭제 -->
<!-- 나중에 삭제 -->
<!-- 나중에 삭제 -->
<!-- 나중에 삭제 -->
<!-- 나중에 삭제 -->
<!-- 나중에 삭제 -->
<!-- 나중에 삭제 -->


<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>급여 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	
	
    <h1>급여 조회</h1>
    <form action="/allSalary" method="get">
		<input type="text" name="keyword" value="${param.keyword}" >
		<input type="submit" value="검색" >
	</form>
	
	<h1>급여 전체 조회</h1>
	<table border="1">
	  <tr>
		<th>선택</th>
		<th>직원</th>
		<th>사원 번호</th>
		<th>기본급</th>
		<th>직책수당</th>
		<th>식대</th>
		<th>초과근무 수당</th>
		<th>세금</th>
		<th>적용 시작일</th>
		<th>총 급여</th>
	  </tr>
	  <c:forEach items="${salaryList}" var="salary">
		<tr>
			<td><input type="checkbox" name="salary" value="${salary.salaryNo}"></td>
			<td>${salary.memberName}</td>
			<td>${salary.memberNo}</td>
			<td>${salary.baseSalary}</td>
			<td>${salary.positionAllowance}</td>
			<td>${salary.mealAllowance}</td>
			<td>${salary.otRate}</td>
			<td>${salary.tax}</td>
			<td>${salary.effectiveDate}</td>
			<td>${salary.totalSalary}</td>
	    </tr>
	  </c:forEach>
	  </table> 	
	  
	  
	  <button id="update" type="button" class="adminAccess">수정</button>
	  <button id="delete" type="button" class="adminAccess">삭제</button>
	  
	  <script>
	  		
	  		$("#update").click(() => {
	  			const selectedSalaryNo = $("input[name='salary']:checked").val();
	  			if(selectedSalaryNo)
	  			{
	  				location.href="/updateSalary?SalaryNo=" + selectedSalaryNo;			
	  			}
	  			else
	  			{
	  				alert("수정할 급여를 선택하세요.");
	  			}
	  		});
	  		$("#delete").click(() => {
	  			const selectedSalaryNo = $("input[name='salary']:checked").val();
	  			
	  			const formData = new FormData();
	  			formData.append("salaryNo", selectedSalaryNo);
	  			
	  			if(selectedSalaryNo)
	  						{
	  			$.ajax({
	  				type : "POST",
	  				url : "/deleteSalary",
	  				data : formData,
	  				processData: false,
	  				contentType: false,
	  				success: function (result) {
	  					if (result === "success") {
	  						alert("해당정보가 삭제되었습니다.");
	  						location.href = "/allSalary";
	  					} else {
	  						alert("삭제할 수 없습니다.");
	  						location.href = "/allSalary";
	  					}	
	  				},
	  			})
	  		}
	  					else
	  					{
	  						alert("삭제할 내용을 선택하세요.");
	  					}
	  		})
	  	
	  	</script>
  </body>
</html>
