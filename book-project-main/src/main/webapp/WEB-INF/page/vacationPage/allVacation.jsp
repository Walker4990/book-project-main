<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>휴가 신청 관리</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
  </head>
  <body>
	
	<section class="vacation">
		<div class="box">
	<h1>휴가 신청 관리</h1><br>
	

	
	    <form action="/allVacation" method="get" class="searchForm">
		  <div class="form-inline">
	      <input
	        type="text"
	        name="keywordBefore"
	        placeholder="정보를 입력하세요."/>
		  <div class="btn-wrap">
	      <button type="submit" value="조회" class="btnNavy">조회</button>
		  </div>
		  </div>
	    </form>
		
		<h2>승인 대기 신청서</h2>
		<br>
		
		<div class="tableWrapper">
	    <table class="table">
			<thead>
	      <tr>
	        <th>부서</th>
	        <th>이름</th>
			<th>아이디</th>
	        <th>이메일</th>
			<th>휴가 시작 날짜</th>
			<th>휴가 끝 날짜</th>
			<th>사유</th>
			<th>진행 상황</th>
			<th>승인 검토</th>
			<th>선택</th>
	      </tr>
		  </thead>
		  <tbody>
	      <c:forEach items="${beforeVacationList}" var="item">
	        <tr>
	          <td>${item.deptName}</td>
	          <td>${item.name}</td>
	          <td>${item.id}</td>
			  <td>${item.email}</td>
			  <td>${item.startDate}</td>
			  <td>${item.endDate}</td>
			  <td>${item.reason}</td>
			  <td>${item.status}</td>
			  <td>${item.approve}</td>
			  <td><input type="radio" name="vacationNo" value="${item.vacationNo}"></td>
			  
	        </tr>
	      </c:forEach>
		  </tbody>
	    </table>
		
		<div class="bottomBtn">
		<button id="true" type="button"  class="adminAccess">승인</button>
		<button id="false" type="button"  class="adminAccess">미승인</button>
		</div>
			</div>

		<nav>
		  <ul class="pagination">
		    <!-- 이전 버튼 -->
		    <c:choose>
		      <c:when test="${pagingBefore.page <= 1}">
		        <li class="disabled"><span>이전</span></li>
		      </c:when>
		      <c:otherwise>
		        <li>
		            <a href="?pagingBefore=${pagingBefore.page - 1}&pagingAfter=${pagingAfter.page}&select=${param.select}&keywordBefore=${param.keywordBefore}">이전</a>
		        </li>
		      </c:otherwise>
		    </c:choose>

		    <!-- 페이지 번호 -->
			<c:forEach var="i" begin="${pagingBefore.startPage}" end="${pagingBefore.endPage}">
				      <li class="${i == pagingBefore.page ? 'active' : ''}">
				        <a href="?pagingBefore=${i}&pagingAfter=${pagingAfter.page}
				          <c:if test='${not empty keywordBefore}'>
				            &keywordBefore=${keywordBefore}
				          </c:if>
				        ">${i}</a>
		      </li>
		    </c:forEach>

		    <!-- 다음 버튼 -->
		    <c:choose>
		      <c:when test="${pagingBefore.page >= pagingBefore.lastPage}">
		        <li class="disabled"><span>다음</span></li>
		      </c:when>
		      <c:otherwise>
		        <li>
		             <a href="?pagingBefore=${pagingBefore.page + 1}&pagingAfter=${pagingAfter.page}&select=${param.select}&keywordBefore=${param.keywordBefore}">다음</a>
		        </li>
		      </c:otherwise>
		    </c:choose>
		  </ul>
		</nav>
		</div>
		
		
		
		
		
		<br>
		<br>
		
		
		<div class="box">
		<h2>검토 완료 신청서</h2><br>
		
		<form action="/allVacation" method="get" class="searchForm">
			  <div class="form-inline">
		      <input
		        type="text"
		        name="keywordAfter"
		        placeholder="정보를 입력하세요."/>
			  <div class="btn-wrap">
		      <input type="submit" value="조회" class="btnNavy" />
			  
			 
			  </div>
			</div>
		    </form>

		
		<br>
		<div class="tableWrapper">
		<table class="table">
			<thead>
		      <tr>
		        <th>부서</th>
		        <th>이름</th>
				<th>아이디</th>
		        <th>이메일</th>
				<th>휴가 시작 날짜</th>
				<th>휴가 끝 날짜</th>
				<th>사유</th>
				<th>진행 상황</th>
				<th>승인 검토</th>
		      </tr>
			  </thead>
			  <tbody>
		      <c:forEach items="${afterVacationList}" var="item">
		        <tr>
		          <td>${item.deptName}</td>
		          <td>${item.name}</td>
		          <td>${item.id}</td>
				  <td>${item.email}</td>
				  <td>${item.startDate}</td>
				  <td>${item.endDate}</td>
				  <td>${item.reason}</td>
				  <td>${item.status}</td>
				  <td>${item.approve}</td>
				  
		        </tr>
		      </c:forEach>
			  </tbody>
		    </table>
			
			
			<nav>
			  <ul class="pagination">
			    <c:choose>
			      <c:when test="${pagingAfter.page <= 1}">
			        <li class="disabled"><span>이전</span></li>
			      </c:when>
			      <c:otherwise>
			        <li>
			            <a href="?pagingAfter=${pagingAfter.page - 1}&pagingBefore=${pagingBefore.page}&select=${param.select}&keywordAfter=${param.keywordAfter}">이전</a>
			        </li>
			      </c:otherwise>
			    </c:choose>

				<c:forEach var="i" begin="${pagingAfter.startPage}" end="${pagingAfter.endPage}">
						      <li class="${i == pagingAfter.page ? 'active' : ''}">
						        <a href="?pagingAfter=${i}&pagingBefore=${pagingBefore.page}
						          <c:if test='${not empty keywordAfter}'>
						            &keywordAfter=${keywordAfter}
						          </c:if>
						        ">${i}</a>
			      </li>
			    </c:forEach>

			    <c:choose>
			      <c:when test="${pagingAfter.page >= pagingAfter.lastPage}">
			        <li class="disabled"><span>다음</span></li>
			      </c:when>
			      <c:otherwise>
			        <li>
			            <a href="?pagingAfter=${pagingAfter.page + 1}&pagingBefore=${pagingBefore.page}&select=${param.select}&keywordAfter=${param.keywordAfter}">다음</a>
			        </li>
			      </c:otherwise>
			    </c:choose>
			  </ul>
			</nav>
			
			</section>
			
			<!-- 🟫 모달 영역 시작 : 휴가 일정 관리 캘린더에서 휴가 등록 가능하게 하였으니, 해당 페이지에서는 삭제하는 것으로 
				  <div id="vacationModal" class="modal-overlay">
				    <div class="modal-box">
						<div class="modal-header">
							<h5 class="modal-title">휴가 신청</h5>
				      <button class="close-btn" type="button" onclick="closeModal()">✕</button>
					  </div>
					  
					  <div class="modal-body">
				      <form action="/vacation" method="post" id="vacationForm">
						<div class="form-grid">
				        

				        <div class="input">
				          <label class="label" for="startDate">시작 날짜</label>
				          <input type="date" id="startDate" name="startDate" required>
				        </div>

				        <div class="input">
				          <label class="label" for="endDate">종료 날짜</label>
				          <input type="date" id="endDate" name="endDate" required>
				        </div>

				        <div class="input">
				          <label class="label">신청 사유</label>
				          <textarea name="reason" id="reason" required></textarea>
				        </div>
						</div>
						</div>

				        <div class="modal-footer">
				          <button type="button" id="vacationSubmit">등록</button>
				          <button type="button" class="cancel-btn" onclick="closeModal()">취소</button>
				        </div>
				      </form>
				    </div>
				  </div>
				  🟫 모달 영역 끝 -->
			
				<script>
					function openModal() {
					      document.getElementById("vacationModal").style.display = "flex";
					    }

					    // 모달 닫기
					    function closeModal() {
					      document.getElementById("vacationModal").style.display = "none";
					    }
					
					$("#true").click(() => {
					  const vacationNo = $("input[name='vacationNo']:checked").val();
					  if (!vacationNo) {
						alert("신청서를 선택해주세요");
						return;
					  } 
					  const formData = new FormData();
					  formData.append("vacationNo", vacationNo);
					  $.ajax({
					  		type:"POST",
					  		url:"/approveVacation",
							data: formData,
							processData: false,
							contentType: false,
					  		success: function(result) {
					  			if (result=="success"){
					  				alert("승인이 완료되었습니다.");
					  				location.href = "/allVacation"
					  			} else alert("승인 실패")
					  		}
					  });
					  
					});		
					
					$("#false").click(() => {
						const vacationNo = $("input[name='vacationNo']:checked").val();
						if (!vacationNo) {
						      alert("신청서를 선택해주세요.");
							  return;
						    }
							
						const formData = new FormData();
						formData.append("vacationNo", vacationNo);
					$.ajax({
						type:"POST",
						url:"/notApprove",
						data: formData,
						processData: false,
						contentType: false,
						success: function(result) {
							if (result=="success"){
								alert("해당 휴가신청이 미승인되었습니다.");
								location.href = "/allVacation"
							} else alert("미승인 처리 실패")
						}
					});
				});
				
				$("#submit").click((e) => {
					e.preventDefault();
					
					const startDate = $("#startDate").val();
					const endDate = $("#endDate").val();
					const reason = $("#reason").val();
					 if(!startDate && !endDate && !reason)
					{
						alert("값을 입력해주세요");
						return;
					}
							 
					if(!startDate)
					{
						alert("시작 날짜를 입력해주세요");
						return;
					}
					if(!endDate)
					{
						alert("끝 날짜를 입력해주세요");
						return;
					}
					if(reason == '')
					{
						alert("사유를 입력해주세요");
						return;
					}
					const today = new Date();
					today.setHours(0, 0, 0, 0);
					
					const parsedStartDate = new Date(startDate);
					if(parsedStartDate <= today)
					{
						alert("휴가 시작 날짜는 오늘보다 이후여야 합니다.");
						return;
					}
					
					
					
					 const formData = new FormData();

					 formData.append("startDate",startDate);
					 formData.append("endDate", endDate);
					 formData.append("reason", reason);
							 
					  $.ajax({
						   type: "POST",
						   url: "/vacation",
						   data: formData,
				           processData: false,
						   contentType: false,
						   success: function (result) {
						   if (result == "success") {
						 	  	alert("휴가 등록이 완료되었습니다!");
						 	  	location.href = "/allVacation";
						   } else if (result == "startDateAfter") {
						 	  	alert("시작 날짜가 끝 날짜보다 뒤에 있습니다.");
						   } else if (result == "dateAfter") {
								alert("휴가 날짜가 이미 지났습니다.");	
						   } else if(result == "enough"){
								alert("연차가 부족합니다.");	
						   } else if(result == "duplicationDate"){
								alert("이미 해당 날짜에 휴가신청 하였습니다.");
						   } else if(result == "zero") {
								alert("현재 소지중인 연차 개수가 0개 입니다.");
						   } else if(result == "empty"){
								alert("값이 없습니다.");	
						   }else {
						 	  	alert("알 수 없는 오류");
						   }
					},
						  error: function () {
						 	  	alert("서버 오류 발생");
					},
				});
			});
				</script>	
  </body>
</html>