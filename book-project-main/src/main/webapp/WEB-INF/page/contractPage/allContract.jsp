<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>계약작가 정보 조회</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/contract.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	
	<section class="contract">
		<div class="box">
		
			
    <h1>계약 작가 정보 검색</h1><br>
	
		<form class="searchForm" action="/allContract" method="get">
			<div class="form-inline">
			<input type="text" name="keyword" value="${param.keyword}" placeholder="작가명 또는 계약번호을 입력하세요.">
			
			<div class="btn-wrap">
			<button type="submit" value="조회" class="btnNavy">조회</button>
			<button type="button" id="createBtn" class="btnNavy adminAccess">계약 등록</button>
			</div>
			</div>
		</form>
		
	<h1>전체 계약 작가 정보 조회</h1>
	<div class="tableWrapper">
	<table class="table">
		<thead>
		<tr>
			<th>선택</th>
			<th>작가명</th>
			<th>국적</th>
			<th>생년월일</th>
			<th>성별</th>
			<th>도서명</th>
			<th>장르</th>
			<th>계약금</th>
			<th>인세</th>
			<th>계약 일자</th>
			<th>계약 만료 일자</th>
			<th>원고 마감 일자</th>
			<th>인쇄 일자</th>
			<th>출판 일자</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="contract">	
		<tr>
			<td><input type="radio" name="contractNo" value="${contract.contractNo}"></td>
			<td>${contract.authorName}</td>
			<td>${contract.nationality}</td>
			<td>${contract.birthDate}</td>
			<td>${contract.gender}</td>
			<td>${contract.bookTitle}</td>
			<td>${contract.genre}</td>
			<td>${contract.contractAmount}</td>
			<td>${contract.royaltyRate}</td>
			<td>${contract.startDate}</td>
			<td>${contract.endDate}</td>
			<td>${contract.manuscriptDue}</td>
			<td>${contract.printDate}</td>
			<td>${contract.publishDate}</td>
		</tr>
		</c:forEach>
		</tbody>
		</table>
		
		<div class="bottomBtn">
		<button id="updateBtn" type="button" class="update adminAccess">수정</button>
	    <button id="deleteBtn" type="button" class="delete adminAccess">해지</button>
		</div>
		
		
		
	</div>
		</section>
		
		<!--계약 등록 모달-->
		<div id="contractModal" class="modal-overlay">
		    <div class="modal-box">
		      <div class="modal-header">
		        <h5 class="modal-title">계약 등록</h5>
		        <button class="close-btn" id="closeModal">✕</button>
		      </div>
		      <div class="modal-body">
		        <form id="contractForm">
		          <div class="form-grid">
					
		            <div class="input">
		              <label class="label" for="authorName">작가 이름</label>
		              <input type="text" name="authorName" id="authorName" required>
		            </div>
					
		            <div class="input">
		              <label class="label" for="birthDate">생년월일</label>
		              <input type="date" name="birthDate" id="birthDate" required>
		            </div>

					<div class="input">
					  <label class="label">성별</label>
					  <div class="radio-group">
					    <label class="radio">
					      <input type="radio" name="gender" value="남" id="man" checked> 남
					    </label>
					    <label class="radio">
					      <input type="radio" name="gender" value="여" id="woman"> 여
					    </label>
					  </div>
					</div>
					
		            <div class="input">
		              <label class="label" for="nationality">국적</label>
		              <select name="nationality" id="nationality" required>
		                <option value="" disabled selected>국적 선택</option>
						<option>그리스</option>
						<option>네덜란드</option>
						<option>노르웨이</option>
						<option>대만</option>
						<option>대한민국</option>
						<option>덴마크</option>
						<option>독일</option>
						<option>멕시코</option>
						<option>미국</option>
						<option>바누아투</option>
						<option>스웨덴</option>
						<option>스페인</option>
						<option>영국</option>
						<option>오스트레일리아</option>
						<option>오스트리아</option>
						<option>인도</option>
						<option>일본</option>
						<option>포르투갈</option>
						<option>프랑스</option>
		              </select>
		            </div>

		            <div class="input">
		              <label class="label" for="bookTitle">도서명</label>
		              <input type="text" name="bookTitle" id="bookTitle" required>
		            </div>
		            <div class="input">
		              <label class="label" for="genre">장르</label>
		              <select name="genre" id="genre" required>
		                <option value="" disabled selected>장르 선택</option>
		                <option>소설</option>
		                <option>시</option>
		                <option>전기</option>
		                <option>에세이</option>
		                <option>만화</option>
		                <option>심리학</option>
		                <option>논픽션</option>
		                <option>기타</option>
		              </select>
		            </div>

		            <div class="input">
		              <label class="label" for="contractAmount">계약금</label>
		              <input type="number" name="contractAmount" id="contractAmount" min="0" required>
		            </div>
		            <div class="input">
		              <label class="label" for="royaltyRate">인세</label>
		              <input type="number" name="royaltyRate" id="royaltyRate" step="0.1" min="0" required>
		            </div>

		            <div class="input">
		              <label class="label" for="price">판매가</label>
		              <input type="number" name="price" id="price" required>
		            </div>
		            <div class="input">
		              <label class="label" for="startDate">계약일자</label>
		              <input type="date" name="startDate" id="startDate" required>
		            </div>

		            <div class="input">
		              <label class="label" for="endDate">계약 만료 일자</label>
		              <input type="date" name="endDate" id="endDate" required>
		            </div>
		            <div class="input">
		              <label class="label" for="manuscriptDue">원고 마감 일자</label>
		              <input type="date" name="manuscriptDue" id="manuscriptDue" required>
		            </div>

		            <div class="input">
		              <label class="label" for="printDate">인쇄 예정 일자</label>
		              <input type="date" name="printDate" id="printDate" required>
		            </div>
		            <div class="input">
		              <label class="label" for="publishDate">출판 예정 일자</label>
		              <input type="date" name="publishDate" id="publishDate" required>
		            </div>
		          </div>
		      </div>
			  
		      <div class="modal-footer">
		        <button type="submit" id="saveContract">등록</button>
		        <button type="button" id="closeModalFooter">닫기</button>
		      </div>
		      </form>
		    </div>
		  </div>

			
		<!-- 계약 해지/ 만료 모달-->
		<div id="terminateModal" class="modal-overlay" >
		  <div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">계약 해지/만료 처리</h5>
				<button type="button" class="close-btn" id="closeTerminate">✕</button>
		          </div>

		    <div class="modal-body">
				
			<div class="input">
		    <label class="label" for="terminationType">처리 유형</label>
		    <select id="terminationType" name="terminationType">
		      <option value="">선택</option>
		      <option value="EXPIRE">만료</option>
		      <option value="CANCEL">해지</option>
		    </select>
			</div>

			<div class="input">
		    <label class="label" for="terminationReason">사유 (최대 200자)</label>
		    <textarea id="terminationReason" name="terminationReason" maxlength="200" placeholder="사유를 입력하세요"></textarea>
			</div>
			</div>

		    <div class="modal-footer">
				<button type="button" id="saveTerminate" class="btn btnPrimary">확인</button>
				<button type="button" id="closeTerminate" class="cancelBtn">취소</button>		
		    </div>
		  </div>
		  </div>
		
		
		<!-- 계약 수정 모달 -->
		<div id="editContractModal" class="modal-overlay">
		  <div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">계약 정보 수정</h5>
		    <button class="close-btn" id="closeEditModal">✕</button>
		    </div>

			<div class="modal-body">
			<form id="editContractForm">
				<div class="form-grid">
			  <input type="hidden" name="contractNo" id="edit-contractNo">

			  <div class="inputGroup">
			    <label>작가 이름</label>
			    <input type="text" id="edit-authorName" readonly>
			  </div>

			  <div class="inputGroup">
			    <label>도서명</label>
			    <input type="text" id="edit-bookTitle" name="bookTitle" required>
			  </div>

			  <div class="inputGroup">
			    <label>장르</label>
			    <select id="edit-genre" name="genre" required>
			      <option value="소설">소설</option>
			      <option value="시">시</option>
			      <option value="전기">전기</option>
			      <option value="에세이">에세이</option>
			      <option value="만화">만화</option>
			      <option value="심리학">심리학</option>
			      <option value="논픽션">논픽션</option>
			      <option value="기타">기타</option>
			    </select>
			  </div>
			  
			  <div class="inputGroup">
			    <label>계약금</label>
			    <input type="number" id="edit-contractAmount" name="contractAmount" min="0" required>
			  </div>

			  <div class="inputGroup">
			    <label>인세</label>
			    <input type="number" id="edit-royaltyRate" name="royaltyRate" step="0.1" min="0" required>
			  </div>

			  <div class="inputGroup">
			    <label>계약 만료 일자</label>
			    <input type="date" id="edit-endDate" name="endDate" required>
			  </div>

			  <div class="inputGroup">
			    <label>원고 마감 일자</label>
			    <input type="date" id="edit-manuscriptDue" name="manuscriptDue" required>
			  </div>

			  <div class="inputGroup">
			    <label>인쇄 일자</label>
			    <input type="date" id="edit-printDate" name="printDate" required>
			  </div>

			  <div class="inputGroup">
			    <label>출판 일자</label>
			    <input type="date" id="edit-publishDate" name="publishDate" required>
			  </div>
			  </div>
			  </div>

			  <div class="modal-footer">
			    <button type="submit" class="btnNavy" id="acceptEdit">수정</button>
			    <button type="button" class="btnGray" id="cancelEdit">취소</button>
			  </div>
			</form>
			  </div>
			</div>
		
			<script>
			$(function () {
			  const openCreateModal     = () => $("#contractModal").fadeIn(120);
			  const closeCreateModal    = () => $("#contractModal").fadeOut(120);
			  const openTerminateModal  = () => $("#terminateModal").fadeIn(120);
			  const closeTerminateModal = () => $("#terminateModal").fadeOut(120);
			  const openEditModal       = () => $("#editContractModal").css("display","flex");
			  const closeEditModal      = () => $("#editContractModal").hide();

			  // ---------- 계약 등록 모달 ----------
			  // ---------- 계약 등록 모달 ----------
			  $("#createBtn").on("click", function(){
			    $("#contractForm")[0].reset();
			    openCreateModal();
			  });
			  
			  

			  // 닫기 버튼 처리 (X 버튼, footer 닫기 버튼 모두)
			  $("#closeModal, #closeModalFooter").on("click", closeCreateModal);

			  // 저장 버튼 처리
			  $("#saveContract").on("click", function(e){
			    e.preventDefault();

			    const form = $("#contractForm")[0];
			    if (!form.checkValidity()) { form.reportValidity(); return; }
				const authorName     = $("#authorName").val().trim();
				 const bookTitle      = $("#bookTitle").val().trim();
				 const contractAmount = $("#contractAmount").val();
				 const royaltyRate    = $("#royaltyRate").val();
			    const startDate     = $("#startDate").val();
			    const endDate       = $("#endDate").val();
			    const manuscriptDue = $("#manuscriptDue").val();
			    const printDate     = $("#printDate").val();
			    const publishDate   = $("#publishDate").val();

			    
				if (startDate && endDate && startDate > endDate)       
				       return alert("계약 시작일은 계약 만료일보다 이전이어야 합니다.");
					   
			    if (manuscriptDue && endDate && manuscriptDue > endDate)  
				    return alert("원고 마감일은 계약 만료일보다 이전이어야 합니다.");
					
			    if (manuscriptDue && printDate && manuscriptDue > printDate) 
				 return alert("원고 마감일은 인쇄일보다 이전이어야 합니다.");
				 
			    if (printDate && publishDate && publishDate < printDate)  
				    return alert("출판일은 인쇄일 이후여야 합니다.");
					
				if(!authorName) return alert("작가명을 입력해주세요.");
				
				 if(!bookTitle)  return alert("도서명을 입력해주세요.");
				 
				 if(contractAmount === "" || contractAmount < 0) 
				 return alert("계약금을 입력해주세요.");
				 
				 if(royaltyRate === "" || royaltyRate < 0)     
				   return alert("인세율을 입력해주세요.");
				   
			    $.ajax({
			      type: "POST",
			      url: "/newContract",
			      data: $("#contractForm").serialize(),
			      success(res){
			        if(res === "success"){
						 alert("계약 등록 완료"); 
						 location.href="/allContract";
					 }
			        else { 
						alert(res || "등록 실패"); 
					}
			      },
			      error(){ alert("요청 실패"); },
			    });
			  });


			  // ---------- 해지/만료 모달 ----------
			  $("#deleteBtn").on("click", function(){
			    const contractNo = $("input[name='contractNo']:checked").val();
			    if (!contractNo) return alert("대상 계약을 선택하세요");
			    openTerminateModal();
			  });
			  $("#closeTerminate").on("click", closeTerminateModal);

			  $("#saveTerminate").on("click", function(){
			    const contractNo  = $("input[name='contractNo']:checked").val();
			    const closeType   = $("#terminationType").val();
			    const closeReason = $("#terminationReason").val().trim();
			    if (!contractNo)  return alert("대상 선택");
			    if (!closeType)   return alert("유형 선택");
			    if (!closeReason) return alert("사유 입력");

			    $.ajax({
			      type: "POST",
			      url: "/insertExpired",
			      data: { contractNo, closeType, closeReason },
			      success(result){
			        if (result === "success"){ alert("처리 완료"); closeTerminateModal(); location.href="/allContract"; }
			        else { alert("처리 실패"); }
			      },
			      error(){ alert("요청 실패"); }
			    });
			  });

			  // ---------- 계약 수정 모달 ----------
			  $("#closeEditModal, #cancelEdit").on("click", closeEditModal);

			  $("#updateBtn").on("click", function(){
			    const contractNo = $("input[name='contractNo']:checked").val();
			    if(!contractNo) return alert("수정할 계약을 선택하세요.");

			    $.get("/getContract", { contractNo })
			     .done(function(c){
			       $("#edit-contractNo").val(c.contractNo);
			       $("#edit-authorName").val(c.authorName);
			       $("#edit-bookTitle").val(c.bookTitle);
			       $("#edit-contractAmount").val(c.contractAmount);
			       $("#edit-royaltyRate").val(c.royaltyRate);
			       $("#edit-endDate").val(c.endDate);
			       $("#edit-manuscriptDue").val(c.manuscriptDue);
			       $("#edit-printDate").val(c.printDate);
			       $("#edit-publishDate").val(c.publishDate);
				   $("#edit-genre").val(c.genre);
			       openEditModal();
			     })
			     .fail(() => alert("계약 상세 조회 실패"));
			  });

			  $("#editContractForm").on("submit", function(e){
			    e.preventDefault();

			    const data = {
			      contractNo    : $("#edit-contractNo").val(),
			      bookTitle     : $("#edit-bookTitle").val(),
			      contractAmount: $("#edit-contractAmount").val(),
			      royaltyRate   : $("#edit-royaltyRate").val(),
			      endDate       : $("#edit-endDate").val(),
			      manuscriptDue : $("#edit-manuscriptDue").val(),
			      printDate     : $("#edit-printDate").val(),
			      publishDate   : $("#edit-publishDate").val(),
				  genre			: $("#edit-genre").val()
			    };
				if (data.contractAmount < 0)
				  return alert("계약금은 0 이상이여야합니다.");
				if(data.royaltyRate < 0)
  				  return alert("인세가 0 이상이여야합니다.");
			    if (data.manuscriptDue && data.endDate && data.manuscriptDue > data.endDate)
			      return alert("원고 마감일은 계약 만료일보다 늦을 수 없습니다.");
			    if (data.manuscriptDue && data.printDate && data.manuscriptDue > data.printDate)
			      return alert("원고 마감일은 인쇄일보다 늦을 수 없습니다.");
			    if (data.publishDate && data.printDate && data.publishDate < data.printDate)
			      return alert("출판일은 인쇄일보다 이전일 수 없습니다.");

			    $.ajax({
			      url: "/updateContract",
			      type: "POST",
			      contentType: "application/json",
			      data: JSON.stringify(data),
			      success(res){
			        if(res === "success"){ alert("수정 완료"); closeEditModal(); location.reload(); }
			        else { alert("수정 실패"); }
			      },
			      error(){ alert("수정 중 오류가 발생했습니다."); }
			    });
			  });
			});
			</script>	
  </body>
</html>