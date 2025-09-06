<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>품의서 조회</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/request.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	<sec:authentication var="member" property="principal" />
	<input type="hidden" id="loginRole" name="loginRole" value="<sec:authentication property='principal.role' />">
	<input type="hidden" id="loginName" name="loginName" value="<sec:authentication property='principal.name' />">
	
	<section class="request">
	<div class="box">
		
	<h1>품의서 검색</h1><br>	
	
	<form action="/allRequest" method="get" class="searchForm">
		<div class="form-inline">
	    <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요.">
		
		<div class="btn-wrap">
		<button type="submit" value="조회" class="btnNavy">조회</button>
		<button type="button" id="write" class="btnNavy" onclick="openWriteModal()">품의서 작성</button>
		</div>
		</div>
	</form>
	
	<h1>품의서 목록</h1><br>
	<div class="tableWrapper">
	<table class="table">
	<thead>
	  <tr>
		<th>선택</th>
	    <th>번호</th>
	    <th>제목</th>
	    <th>작성자</th>
	    <th>작성일</th>
	    <th>결재 상태</th>
	  </tr>
	  </thead>
	  <tbody>
	  <c:forEach var="r" items="${list}">
	    <tr data-request-no="${r.requestNo}" class="requestRow" style="cursor:pointer;">
		  <td><input type="radio" name="request" value="${r.requestNo}"></td>
	      <td>${r.requestNo}</td>
	      <td>${r.title}</td>
	      <td>${r.memberName}</td>
	      <td>${r.writeDate}</td>
	      <td>${r.approvalStatus}</td>
	    </tr>
	  </c:forEach>
	  </tbody>
	</table>
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
	        <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
	            <li class="${i == paging.page ? 'active' : ''}">
	              <a href="?page=${i}&select=${param.select}&keyword=${param.keyword}">${i}</a>
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
	</div>
	
	<div class="bottomBtn">
	<button class="delete adminAccess" id="delete" type="button">삭제</button>
	</div>
	
	</div>
	</section>
					
	<!-- 모달 : 품의 작성 모달 -->
	<div id="writeRequestModal" class="modal-overlay">
		<div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">품의 작성</h5>
				<button class="close-btn" onclick="closeWriteModal()">✕</button>
			</div>
			
			<div class="modal-body">
				<form action="/newRequest" method="post" enctype="multipart/form-data" id="RequestForm">
					<div class="form-grid">
						<div class="input">
						  <label class="label" for="memberName">결재자</label>
							<select name="approverNo" id="memberName">
							<c:forEach var="m" items="${approvers}">
							<option value="${m.memberNo}">${m.name}</option>
							</c:forEach>
							</select>
						</div>
				
						<div class="input">
						<label class="label">제목</label> 
						<input type="text" id="requestTitle" name="title" placeholder="품의 제목을 입력해주세요." required />
						</div>
						
						<div class="input">
						  <label class="label">내용</label>
						  <textarea name="content" rows="10" id="content" cols="50" required></textarea>
						</div>
						
						<div class="input" id="uploadFile">
						  <label>파일 첨부</label>
						  <input type="file" name="file" id="file" />
					    </div>
					</div>
				
					<div class="modal-footer">  
						<button type="submit" id="create" value="저장">저장</button>
						<button type="button" id="cancel" value="취소">취소</button>
					</div>	
				</form>
			</div>
		</div>
	</div>
	          
	
	<!-- 모달 : 품의서 상세 조회 -->
	<div id="modalBackdrop" class="modal-overlay">
		<div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">품의 내용</h5>
				<button class="close-btn" onclick="closeModal()">✕</button>
			</div>
            
			<div class="modal-body">
				<div class="form-grid">	
					<div class="inputGroup">
						<label class="label">작성일자</label>
						<p><span id="modalDate"></span></p>	
					</div>
						
					<img class="requestImg" style="display:none;"/>
					
					<div class="inputGroup">
						<label class="label">결재자</label>
						<p><span id="modalApprover"></span></p>
					</div>
					
					<div class="inputGroup">
						<label class="label">작성자</label>
						<p><span id="modalWriter"></span></p>
					</div>
					
					<div class="inputGroup">
						<label class="label">결재 상태</label>
						<p><span id="modalStatus"></span></p>
					</div>
					
					<div class="inputGroup">
						<label class="label">제목</label>
						<p><span id="modalTitle"></span></p>
					</div>
					
					<div class="inputGroup">
						<label class="label">내용</label>
						<p><span id="modalContent"></span></p>
					</div>
					
					<p id="fileDownload"></p>
					
					<!-- 작성자일 경우에만 수정 가능 -->
					<div class="input" id="updateContent" style="display:none;">
					  <div class="retouch">
					    <label class="label">제목</label>
					    <input type="text" id="updateTitle" name="updateTitle" required/>
					  </div>
					  <div class="input">
					    <label class="label">내용</label>
					    <textarea id="updateContentText" name="updateContent" rows="10" cols="50"></textarea>
					  </div>
					  <div class="bottomBtn">
					    <button type="button" id="retouchBtn" class="btnNavy">내용 수정</button>
					  </div>
					</div> 
				</div>		
			 	
				<div class="modal-footer authority" style="display:none;">		
					<button id="approve" type="button">승인</button>
					<button id="notApprove" type="button">반려</button>	
				</div>
			</div>
		</div>		
	</div>
	
	<script>
		const role = $("#loginRole").val();
		const loginName = $("#loginName").val();
		let requestNo= 0;
		let approvalStatus = null;

		// 삭제 버튼
		$("#delete").click(() => {
			if(role !== "ADMIN"){
				alert("관리자만 삭제 가능합니다.");
				return;
			}
			const requestNo = $("input[name='request']:checked").val();
			if(!requestNo) {
				alert("삭제하실 항목을 선택해주세요.")
				return;
			}
			$.ajax({
				url: "deleteRequest",
				type: "post",
				data: {requestNo},
				success: function(){
					alert("삭제되었습니다.");
					location.href = "/allRequest";
				},
				error: function() {
					alert("삭제에 실패했습니다.");
				},
			});
		});
		
		// 모달 : 신규 품의서 등록 
		function openWriteModal(){$("#writeRequestModal").css("display", "flex");}
		function closeWriteModal(){$("#writeRequestModal").hide();}
		$("#cancel").on("click", closeWriteModal);
		
		$("#create").click((e)=>{
			e.preventDefault();	
			const title = $("#requestTitle").val();
			const content = $("#content").val();
			if(!content || !title){
				alert("내용을 입력해주세요.");
				return;
			} 
						
			const form = $("#RequestForm")[0];
			const formData = new FormData(form);
			$.ajax({
				url: "/newRequest",
				method: "POST",
				data: formData,
				processData: false, 
				contentType: false, 
				success: function(result){
					if(result == "success"){
						alert("품의서 등록이 완료되었습니다!");
						location.href = "/allRequest";
					}
					else {
						alert("품의서 등록에 실패하였습니다.");
					}
				},
				error: function(xhr, status, error) {
					alert("에러 발생: " + error);
				}
			});
		});
		
		// 모달 : 품의서 상세 조회
		$(".requestRow").click(function(e) {
		    if ($(e.target).is('input[type=radio]')) return;
		    requestNo = $(this).data('request-no');
			$.ajax({
				url: "/getRequestDetail",
				method: "GET",
				data: { no: requestNo },
				success: function(data) {
					approvalStatus = data.approvalStatus;	
					$("#modalTitle").text(data.title);
					$("#modalWriter").text(data.memberName);
					$("#modalDate").text(data.writeDate);
					$("#modalApprover").text(data.approverName);
					$("#modalStatus").text(data.approvalStatus);
					$("#modalContent").text(data.content);
					$("#modalBackdrop").show().addClass("show");

					if(data.filePath){
						$(".requestImg").attr("src","http://192.168.0.10:8081/" + data.filePath).show();
						$("#fileDownload").html('<a href="'+data.filePath+'" download>첨부파일 다운로드</a>');
					}else{
						$(".requestImg").hide();
						$("#fileDownload").empty();
					}
					
					if(data.memberName == loginName){
						$("#updateContent").show();
						$("#updateTitle").val(data.title);
						$("#updateContentText").val(data.content);
					}else{
						$("#updateContent").hide();
					}
					if(data.approverName == loginName){
						$(".authority").show();
					}else{
						$(".authority").hide();
					}				
				}
			});
		});
		
		function closeModal(){
			$("#modalBackdrop").hide();
		}
		
		// 수정 버튼
		$("#retouchBtn").click(function() {
			const updateTitle = $("#updateTitle").val();
			const updateContent = $("#updateContentText").val();
			
			if(!updateContent){
				alert("내용을 입력해주세요!");
				return;
			}
			const formData = new FormData();
			formData.append("requestNo", requestNo);
			formData.append("title",updateTitle);
			formData.append("content",updateContent);
			$.ajax({
				url: "/updateRequest",
				method: "POST",
				data: formData,
				processData: false, 
				contentType: false, 
				success: function(result) {
					alert(result);
					location.href = "/allRequest"; 
				}
			});
		})
		
		// 승인 버튼
		$("#approve").click(function() {
			if(role == "USER"){
				alert("관리자만 승인 가능합니다.");
				return;
			}
			if(approvalStatus !== '대기'){
				alert("이미 처리된 품의서 입니다.");
				return;
			}
			$.ajax({
				url: "/approveRequest",
				type: "post",
				data: {requestNo},
				success: function (result) {
					alert(result);
					location.href = "/allRequest"; 
				},
				error: function (error) {
					alert(error);
				},
			});
		});
		
		// 반려 버튼
		$("#notApprove").click(function() {
			if(role == "USER"){
				alert("관리자만 승인 가능합니다.");
				return;
			}
			if(approvalStatus !== '대기'){
				alert("이미 처리된 품의서 입니다.");
				return;
			}
			$.ajax({
				url: "/notApproveRequest",
				type: "post",
				data: {requestNo},
				success: function (result) {
					alert(result);
					location.href = "/allRequest"; 
				},
				error: function (error) {
					alert(error);
				},
			});
		});
	</script>
  </body>
</html>
