<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>유통관리 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body> 
	<section class="delivery">
		<div class="box">
    <h1>유통관리 조회</h1><br>
	
	<form class="searchForm" action="/allDelivery" method="get">
		<div class="form-inline">
	  <input type="text" name="keyword" value="${param.keyword}" placeholder="업체명 입력">
	  
	  <div class="btn-wrap">
	  <button type="submit" value="조회" class="btnNavy">조회</button>
	  <button type="button" class="btnNavy" onclick="openModal()">신규 등록</button>
	  </div>
	  
	  </div>
	</form>
	
    <h1>전체 유통관리 조회</h1>
	<div class="tableWrapper">
    <table class="table">
		<thead>
      <tr>
		<th>선택</th>
        <th>번호</th>
        <th>업체명</th>
        <th>주소</th>
        <th>계약금</th>
        <th>계약 날짜</th>
      </tr>
      </thead>
	  
	  <tbody>
      <c:forEach items="${deliveryList}" var="delivery">
        <tr>
          <td><input type="radio" name="deliveryNo" value="${delivery.deliveryNo}"></td>
		  <td>${delivery.deliveryNo}</td>         
          <td>${delivery.name}</td>
          <td>${delivery.address}</td>
          <td>${delivery.contractAmount}</td>
          <td>${delivery.contractDate}</td>
        </tr>
      </c:forEach>
	  <tbody>
    </table>
	
	</div>
	<div class="bottomBtn">
	<button id="update" type="button" class="update adminAccess">수정</button>
	<button id="delete" type="button" class="delete adminAccess">삭제</button>
	</div>
	<nav>
		  <ul class="pagination">
	<!-- 이전 버튼 -->
		<c:choose>
		  <c:when test="${paging.page <= 1}">
		    <li class="disabled"><span>이전</span></li>
		  </c:when>
		  <c:otherwise>
		    <li>
		      <a href="?page=${paging.page - 1}&select=${param.select}&keyword=${param.keyword}">이전</a>
		    </li>
		  </c:otherwise>
		</c:choose>

	    <!-- 페이지 번호 -->
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

		<!-- 다음 버튼 -->
		<c:choose>
		  <c:when test="${paging.page >= paging.lastPage}">
		    <li class="disabled"><span>다음</span></li>
		  </c:when>
		  <c:otherwise>
		    <li>
		      <a href="?page=${paging.page + 1}&select=${param.select}&keyword=${param.keyword}">다음</a>
		    </li>
		  </c:otherwise>
		</c:choose>
		  </ul>
		</nav>
		
	</section>
	
	<!-- 🟫 모달 영역 시작 -->
		<div id="deliveryModal" class="modal-overlay">
		<div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">유통 관리 등록</h5>
		<button class="close-btn" onclick="closeModal()">✕</button>
		</div>
		
		<div class="modal-body">
		 <form id="deliveryForm">
			 <div class="form-grid">
		
		<div class="input">
		<label class="label">업체명</label>
		<input type="text" id="name" name="name" required/>
		</div>
					
		<div class="input">
		<label class="label">주소</label>
		<input type="text" id="address" name="address" required/>
		</div>
					
					
		<div class="input">
		<label class="label">계약금</label>
		<input type="number" id="contractAmount" name="contractAmount" required/>
		</div>
					
		<div class="input">
		<label class="label">계약 날짜</label>
		<input type="date" id="contractDate" name="contractDate" required/>
		</div>
		</div>
		</div>
				
		<div class="modal-footer">				
		<button type="submit" id="create">등록</button>
		<button type="button" id="cancel">취소</button>
		</div>
		</form>
		</div>
		</div>
		<!-- 🟫 모달 영역 끝 -->
	
	    <!-- 🟫 모달 영역 시작 : 운송사 수정 -->
		<div id="editDeliveryModal" class="modal-overlay">
		<div class="modal-box">
			<div class="modal-header">
			<h5 class="modal-title">유통 업체 정보 수정</h5>
		<button class="close-btn" onclick="closeEditModal()">✕</button>
		</div>
		
		<div class="modal-body">
		<form id="editDeliveryForm">
		<div class="form-grid">	
		<input type="hidden" id="editDeliveryNo" name="deliveryNo" value="${delivery.deliveryNo}">	
										
		<div class="inputGroup">
		<label class="label">업체명</label>
		<input type="text" id="editName" name="name" value="${delivery.name}" />
		</div>
										
		<div class="inputGroup">
		<label class="label">주소</label>
		<input type="text" id="editAddress" name="address" value="${delivery.address}" />
		</div>
										
										
		<div class="inputGroup">
		<label class="label">계약금</label>
		<input type="number" id="editContractAmount" name="contractAmount" value="${delivery.contractAmount}" />
		</div>
										
		<div class="inputGroup">
		<label class="label">계약 날짜</label>
		<input type="date" id="editContractDate" name="contractDate" value="${delivery.contractDate}" />
		</div>
		</div>
		</div>
				
		<div class="modal-footer">									
		<button type="submit" id="acceptEdit">수정</button>
		<button type="button" id="cancelEdit">취소</button>
		</div>
		</form>
		</div>
		</div>
		<!-- 🟫 모달 영역 끝 -->
    
    <script>
		
		// 모달 열기
		function openModal() {
		document.getElementById("deliveryModal").style.display = "flex";
		}

		// 모달 닫기
		function closeModal() {
		document.getElementById("deliveryModal").style.display = "none";
		}
		
		$("#delete").click(() => {
			const deliveryNo = $("input[name='deliveryNo']:checked").val();
			if(!deliveryNo){
				alert("삭제할 내용을 선택하세요");
				return;
			}
		$.ajax({
			type:"POST",
			url:"/deleteDelivery",
			data: {
				deliveryNo:deliveryNo
			},
			success: function(result){
					if (result=="success"){
						alert("삭제 완료");
						location.href = "/allDelivery"
					}
				},
				error: function(){
					alert("삭제 실패");
				}
		});
		});
		
		$("#create").click(() =>{
			event.preventDefault();
			const name = $("#name").val();
			const address = $("#address").val();
			const contractAmount = parseInt( $("#contractAmount").val(),10);
			const contractDate = $("#contractDate").val();
			
			if(!name){
				alert("이름을 입력해주세요");
				return;
			}
			if(!address){
				alert("주소를 입력해주세요");
				return;
			}
			if(!contractAmount){
				alert("계약금을 입력해주세요");
				return;
			}
			if(!contractDate){
				alert("날짜를 입력해주세요");
				return;
			}
			if(contractAmount < 0)
			{
				alert("계약금은 0 이상이여야합니다.");
				return;
			}
		$.ajax({
			type:"POST",
			url:"/newDelivery",
			data:{
			name: name,
			address: address,
			contractAmount: contractAmount,
			contractDate: contractDate
			},
			success: function(result) {
				if (result=="success"){
					alert("등록 완료");
					location.href = "/allDelivery";
				}
			},
			error: function() {
				alert("등록 실패");
			}
		});
		});
					
		$("#cancel").click(() => {
			location.href="/allDelivery"
		});
		
				// 운송사 정보 수정 script
				
				// 1. 모달 열닫
				function openEditModal(){$("#editDeliveryModal").css("display", "flex");}
				function closeEditModal(){$("#editDeliveryModal").hide();}
				$("#cancelEdit").on("click", closeEditModal);
				
				// 2. 수정 선택한 값 가져오기
				$("#update").off("click").on("click", function() {
					const deliveryNo = $("input[name='deliveryNo']:checked").val();
					if(!deliveryNo) return alert("정보를 수정할 운송사를 선택해주세요.");
					
					
					$.get("/getDelivery", {deliveryNo})
					.done(function(d){
						$("#editDeliveryNo").val(d.deliveryNo);
						$("#editName").val(d.name || "");
						$("#editAddress").val(d.address || "");
						$("#editContractAmount").val(d.contractAmount ?? 0);
						$("#editContractDate").val(d.contractDate || "");
						openEditModal();
					})
					.fail(function(){
						alert("발주 정보 상세 조회 실패");});
				});
				
				// 3. 수정된 값 저장
				$("#editDeliveryForm").on("submit", function(e){
					e.preventDefault();
					const editName = $("#editName").val();
					const editAddress = $("#editAddress").val();
					const editContractAmount = parseInt( $("#editContractAmount").val(),10);
					const editContractDate = $("#editContractDate").val();
					
					if(!editName){
						alert("업체명을 입력해주세요");
						return;
					}
					if(!editAddress){
						alert("주소를 입력해주세요");
						return;
					}
					if (isNaN(editContractAmount)) {
							alert("계약금을 입력해주세요");
							return;
					}
					if (editContractAmount < 0) {
						alert("계약금은 0 이상이여야 합니다.");
						return;
					}
					if(!editContractDate){
						alert("날짜를 입력해주세요");
						return;
					}
					
					
					$.ajax({
						url: "/updateDelivery",
						type: "POST",
						data: $(this).serialize(),
						success: function(res) {
							if($.trim(res) === "success") {alert("저장되었습니다"); closeEditModal(); location.reload();}
							else if($.trim(res) === "fail") {alert("저장 실패")}
					        else {alert("서버 오류 저장 실패")}
						},
						error: function(){
							alert("서버 오류 저장 실패");
						}
					});
				});
				
    </script> 
  </body>
</html>
