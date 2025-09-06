<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>예산 등록</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
  <h2>예산 등록</h2>
	<form action="/insertBudgetPlan" id="budgetPlan" method="post" class="mt-3">
		<div class="mb-3">
			<label class="form-label">부서</label>
			<select name="deptNo" class="form-select" required>
				<option value="">부서 선택</option>
				<c:forEach var="dept" items="${deptList}">
					<option value="${dept.deptNo}">${dept.deptName}</option>
				</c:forEach>	
			</select>
		</div>
		<div class="mb-3">
		      <label class="form-label">예산 월</label>
			  <input type="date" name="budgetMonth" class="form-control" required>
		  </div>

		  <div class="mb-3">
		      <label class="form-label">총 예산액</label>
		      <input type="number" name="totalAmount" class="form-control" required>
		  </div>

		  <button type="submit" class="btn btn-primary">등록</button>
		  <a href="/allBudgetPlan" class="btn btn-secondary">목록</a>
		
	</form>
 <script>
	$(function(){
		$("#budgetPlan").submit(function(e){
		        e.preventDefault();

		        $.ajax({
		          url: "/insertBudgetPlan",
		          type: "POST",
		          data: $(this).serialize(),
		          success: function(res){
		            if(res === "success"){
		              alert("등록 성공");
		              location.href = "/allBudgetPlan";
		            } else if(res==="fail"){
		              alert("이미 등록된 부서/월입니다.");
		            }
		          },
		          error: function(){
		            alert("서버 오류 발생");
		          }
		        });
		      });
		    });
 </script>
</body>
</html>