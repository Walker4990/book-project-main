<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>납부한 세금 목록</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/budget.css" />
</head>
<body>
	<section class="budget">
		<div class="box">
		  <h1>부서별 예산 목록</h1><br>
		  
		  <form method="get" action="/allBudgetPlan" class="searchForm">
		    <div class="input">
		      <label class="label" for="month">월별 조회</label>
		    </div>

		    <div class="form-inline-budget">
		      <div class="input">
		        <input type="month" id="month" name="month" value="${selectedMonth}">
		      </div>

		      <div class="btn-wrap-budget">
		        <button type="submit" class="btnNavy btn-sm btn-primary">조회</button>
		        <button type="button" id="create" class="btnNavy adminAccess">부서별 예산 등록</button>
		        <button type="button" id="execute" class="btnNavy adminAccess">부서별 예산 집행</button>
		      </div>
		    </div>
		  </form>
		
		<div class="tableWrapper">		
        <table class="table" id="taxPaidTable">
    <thead>
      <tr>
        <th>예산 달</th>
        <th>부서</th>
        <th>총 예산</th>
        <th>사용액</th>
        <th>남은 금액</th>
      </tr> 
    </thead>
    <tbody>
      <c:forEach var="bl" items="${budgetList}">
        <tr>
          <td>${bl.budgetMonth}</td>
          <td>${bl.deptName}</td>
          <td>${bl.totalAmount}</td>
          <td>${bl.spentAmount}</td>
          <td>${bl.remainingAmount}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
  <!--<nav>

	  <ul class="pagination">
		 이전 버튼
		<c:choose>
		  <c:when test="${paging.page == 1}">
		    <li class="disabled"><span>이전</span></li>   <%-- a태그 대신 span --%>
		  </c:when>
		  <c:otherwise>
		    <li>
		      <a href="?page=${paging.page - 1}&select=${param.select}&keyword=${param.keyword}">
		        이전
		      </a>
		    </li>
		  </c:otherwise>
		</c:choose>

	    페이지 번호 
	    <c:forEach
	      var="i"
	      begin="${paging.startPage}"
	      end="${paging.endPage}"
	    >
	      <li class="${i == paging.page ? 'active' : ''}">
	        <a
	          href="?page=${i}&select=${param.select}&keyword=${param.keyword}"
	          >${i}</a
	        >
	      </li>
	    </c:forEach>

		다음 버튼 
		<c:choose>
		  <c:when test="${!paging.next}">
		    <li class="disabled"><span>다음</span></li>   <%-- a태그 대신 span --%>
		  </c:when>
		  <c:otherwise>
		    <li>
		      <a href="?page=${paging.page + 1}&select=${param.select}&keyword=${param.keyword}">
		        다음
		      </a>
		    </li>
		  </c:otherwise>
		</c:choose>
	  </ul>
	</nav>-->

  <!--예산 등록 모달-->
  
  		<div id="budgetCreateModal" class="modal-overlay">
  		  <div class="modal-box">
			
			<div class="modal-header">
				<h5 class="modal-title">부서별 예산 등록</h5>
			<button class="close-btn" id="budgetCloseX">✕</button>
			</div>
			
			 <div class="modal-body">
			    <form id="budgetCreateForm">
					<div class="form-grid">
						
					<div class="input">
			         <label class="label">부서</label>
			         <select name="deptNo" id="deptNo" required>
			           <option value="">부서 선택</option>
			           <c:forEach var="dept" items="${deptList}">
			             <option value="${dept.deptNo}">${dept.deptName}</option>
			           </c:forEach>
			         </select>
			       </div>

			       <div class="input">
			         <label class="label">예산 월</label>
			         <input type="date" name="budgetMonth" id="budgetMonth" class="form-control" required>
			       </div>

			       <div class="input">
			         <label class="label">총 예산액</label>
			         <input type="number" name="totalAmount" id="totalAmount"
			                class="form-control" min="0" step="1" required>
			       </div>
				   </div>
				   </div>
				  
			       <div class="modal-footer">
			         <button type="submit" id="budgetSaveBtn">등록</button>
			         <button type="button" id="budgetCancelBtn">취소</button>
			       </div>
			     </form>
			   </div>
			 </div>
			 
			 <!--예산 집행 모달-->
			   		<div id="budgetExecuteModal" class="modal-overlay">
			   		  <div class="modal-box">
						<div class="modal-header">
							<h5 class="modal-title">부서별 예산 집행</h5>
			 			<button class="close-btn" id="executeCloseX">✕</button>
						</div>
						
						<div class="modal-body">
							<form id="budgetExecute">
								<div class="form-grid">
			 			 
						     <div class="input">
						         <label class="label">예산 선택</label>
						         <select id="budgetNo" name="budgetNo" class="form-select" required>
						             <option value="">예산 선택</option>
						             <c:forEach var="b" items="${budgetList}">
						                 <option value="${b.budgetNo}" data-remaining="${b.remainingAmount}"
										 data-month="${b.budgetMonth}">
						                     ${b.deptName} - ${b.budgetMonth} (남은 예산: ${b.remainingAmount}원)
						                 </option>
						             </c:forEach>
						         </select>
						     </div>

						     <div class="input">
						         <label class="label">집행 날짜</label>
						         <input type="date" id="execDate" name="execDate" class="form-control" required>
						     </div>

						     <div class="input">
						         <label class="label">집행 금액</label>
						         <input type="number" id="amount" name="amount" class="form-control" required>
						     </div>

						     <div class="input">
						         <label class="label">사용 사유</label>
						         <textarea id="description" name="description" class="form-control"></textarea>
						     </div>
							 </div>
							 </div>

							 <div class="modal-footer">
						     <button type="submit" class="btn btn-primary">등록</button>
							 <button type="button" id="executeCancelBtn" class="btn btn-secondary">취소</button>
							 </div>
							 
						 </form>
			 			   </div>
			 			 </div>
		
			<script>
			$(document).ready(function() {
			  const $modal = $("#budgetCreateModal");

			  // 등록 버튼 → 모달 열기
			  $("#create").click(() => {
			    $modal.show();
			  });

			  // X버튼, 취소 버튼 → 모달 닫기
			  $("#budgetCloseX, #budgetCancelBtn").click(() => {
			    $modal.hide();
				$("#budgetCreateForm")[0].reset();// 입력값 초기화
			  });
				
			  // 등록 처리 (AJAX 예시)
			  $("#budgetCreateForm").submit(function(e) {
			    e.preventDefault();

				$.ajax({
				   type: "POST",
				   url: "/insertBudgetPlanModal",
				   data: $(this).serialize(),    // ★ 폼 직렬화
				   success: function(res){
				     if(res === "success"){
						 alert("등록 성공"); 
						$("#budgetCreateModal").hide();
						    location.reload(); 
					 }
				     else if(res ==="fail"){
						alert("이미 등록된 부서 / 월 입니다.");
					 }
					 
				   },
				   error: function(){ alert("서버 오류"); }
				 });
			  });
			  
			  // 집행버튼
			  const $execute = $("#budgetExecuteModal");
			  
			  $("#execute").click(()=>{
				$execute.show();
			  });
			
			  $("#executeCloseX, #executeCancelBtn").click(() => {
			  		  $execute.hide();
			  			$("#budgetExecute")[0].reset();// 입력값 초기화
			  });
				
			  $("#budgetExecute").submit(function(e) {
				e.preventDefault();
				const remaining = $("#budgetNo option:selected").data("remaining");
				const execDate2 = $("#execDate").val();
				const description = $("#description").val();
				const amount = $("#amount").val();
				 
				 
				 if(parseInt(amount) > remaining){
				   alert("남은 예산보다 많은 금액은 집행할 수 없습니다.");
				   return;
				 }
				 if(!execDate2 && !amount && !description)
				 	{
				 		alert("내용을 작성해주세요.");
				 		return;
				 	}
				 	if(!execDate2)
				 	{
				 		alert("날짜를 작성해주세요.");
				 		return;
				 	}
				 	if(!amount)
				 	{
				 		alert("집행금액을 작성해주세요.");
				 		return;
				 	}
				 	if(!description)
				 	{
				 		alert("사유를 작성해주세요.");
				 		return;
				 	}
				 	if(parseInt(amount) < 0)
				 	{
				 		alert("집행 금액은 0원 이상이여야 합니다.");
				 		return;
				 	}
				 			  
				const budgetMonth = new Date($("#budgetNo option:selected").data("month"));
			    const execDate = new Date($("#execDate").val());

			    if (execDate < budgetMonth) {
			      alert("예산 등록일 이후부터 집행 가능합니다.");
			      return;
			    }
		
			
				$.ajax({
					type:"POST",
					url: "/insertBudgetExecuteModal",
					data: $(this).serialize(),
					success: function(res){
					    if(res.startsWith("success")){
					      alert("등록 성공");
					      $execute.hide();
					      location.reload();
					    } else if(res==="failAmount"){
					      alert("예산을 초과하였습니다"); 
					    } else if (res==="failDate"){
							alert("예산 등록일 이후 부터 가능합니다.")
						}
						},
						error : function(){
							alert("서버 오류");
						}
				});
				
			  });
			  });
			
		</script>
</body>
</html>