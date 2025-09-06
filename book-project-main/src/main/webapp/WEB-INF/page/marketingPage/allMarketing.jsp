<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>외주업체 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	
	<section class="marketing">
		<div class="box">
			<h1>외주 업체 전체 검색 조회</h1><br>
	
	<form class="searchForm" action="/allMarketing" method="get">
		<div class="form-inline">
		  <input type="text" name="keyword" value="${param.keyword}" placeholder="프로젝트명을 입력하세요">
		  
		  <div class="btn-wrap">
		  <button type="submit" value="조회" class="btnNavy">조회</button>
		  <button type="button" class="btnNavy" onclick="openModal()">신규 등록</button>
		 </div>
		 
		 </div>
		</form>		
		
		<h1>외주 업체 전체 조회</h1>
		<div class="tableWrapper">
		<table class="table">
			<thead>
			<tr>
				<th>선택</th>
				<th>프로모션 번호</th>
				<th>업체명</th>
				<th>등록일</th>
				<th>담당자</th>
				<th>담당부서</th>
				<th>프로모션 유형</th>
				<th>프로젝트명</th>
				<th>프로모션 시작일</th>
				<th>프로모션 종료일</th>
				<th>비용</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${marketingList}" var="Marketing">
			
			<tr>
				<td><input type="radio" name="eventNo" value="${Marketing.eventNo}"></td>
				<td>${Marketing.eventNo}</td>
				<td>${Marketing.companyName}</td>
				<td>${Marketing.createdAt}</td>
				<td>${Marketing.createdBy}</td>
				<td>${Marketing.department}</td>
				<td>${Marketing.eventType}</td>
				<td>${Marketing.eventName}</td>
				<td>${Marketing.durationStart}</td>
				<td>${Marketing.durationEnd}</td>
				<td>${Marketing.cost}</td>
			</tr>
		</c:forEach>
		</tbody>
		</table>
		</div>
		
	<div class="bottomBtn" >
	<button id="update" type="button" class="update adminAccess">수정</button>
	<button id="delete" type="button" class="delete adminAccess">삭제</button>
	</div>
	
		<nav>
				  <ul class="pagination">
				<c:choose>
			  <c:when test="${!paging.prev}">
			    <li class="disabled"><span>이전</span></li>
			  </c:when>
			  <c:otherwise>
			    <li>
			      <a href="?page=${paging.startPage - 1}&select=${param.select}&keyword=${param.keyword}">이전</a>
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
			  <c:when test="${!paging.next}">
			    <li class="disabled"><span>다음</span></li>
			  </c:when>
			  <c:otherwise>
			    <li>
			      <a href="?page=${paging.endPage + 1}&select=${param.select}&keyword=${param.keyword}">다음</a>
			    </li>
			  </c:otherwise>
			</c:choose>
				  </ul>
				</nav>
		</div>

   </div>
		</section>
		
		<!-- 🟫 모달 영역 시작 -->
	<div id="mktModal" class="modal-overlay" >
	 <div class="modal-box">
		<div class="modal-header">
		<h5 class="modal-title">신규 외주업체 등록</h5>
	 <button class="close-btn" onclick="closeModal()">✕</button>
	 </div>
	 
	 <div class="modal-body">
	   <form action="/newMarketing" method="post" id="mktForm">
		<div class="form-grid">	
	    
		
		<div class="input">
		<label class="label">업체명</label>
		<input type="text" id="companyName" name="companyName" required/>
		</div>
		
		<div class="input">
		<label class="label">등록일</label>
		<input type="date" id="createdAt" name="createdAt" required/>
		</div>
		
		<div class="input">
		<label class="label">담당자</label>
		<input type="text" id="createdBy" name="createdBy" required/>
		</div>
		
		<div class="input">
		<label class="label" for="department" style="display: block;">담당부서</label>
		<select id="department" name="department" required>
		<option value="" disabled selected>부서 선택</option>
		<option>마케팅팀</option>
		<option>인사팀</option>
		<option>회계/재무팀</option>
		<option>재고관리팀</option>
		<option>영업팀</option>
		</select>
		</div>	
					
		<div class="input">
		<label class="label" for="eventType" style="display: block;">프로모션 유형</label>
		<select id="eventType" name="eventType" required>
		<option value="" disabled selected>프로모션 선택</option>
		<option>인스타그램 홍보</option>
		<option>유튜브 홍보</option>
		<option>블로그 홍보</option>
		<option>틱톡 홍보</option>
		<option>사인회</option>
		<option>복콘서트</option>
		</select>
		</div>	
		
		<div class="input">
		<label class="label">프로젝트명</label>
		<input type="text" id="eventName" name="eventName" required/>
		</div>
		
		<div class="input">
		<label class="label">프로모션 시작일</label>
		<input type="date" id="durationStart" name="durationStart" required/>
		</div>
								
		<div class="input">
		<label class="label">프로모션 종료일</label>
		<input type="date" id="durationEnd" name="durationEnd" required/>
		</div>
		
		<div class="input">
		<label class="label">비용</label>
		<input type="number" id="cost" name="cost" min="0" required/>
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
	
	<!-- 🟫 모달 영역 시작 : 마케팅 정보 수정 -->
	<div id="editMktModal" class="modal-overlay">
	<div class="modal-box">
		<div class="modal-header">
		<h5 class="modal-title">외주업체 정보 수정</h5>
		<span class="close-btn" onclick="closeEditModal()">✕</span>
		</div>
			
		<div class="modal-body">
			<form id="editMktForm">		
				<div class="form-grid">	
			<input type="hidden" id="editEventNo" name="eventNo" value="${marketing.eventNo}" />								
			
			<div class="inputGroup">
			<label class="label">업체명</label>
			    <input type="text" id="editCompanyName" name="companyName" value="${marketing.companyName}" />
			</div>
												
			<div class="inputGroup">
			<label class="label">등록일</label>
				<input type="date" id="editCreatedAt"name="createdAt" value="${marketing.createdAt}" />
			</div>
												
			<div class="inputGroup">
			<label class="label">담당자</label>
				<input type="text" id="editCreatedBy" name="createdBy" value="${marketing.createdBy}" />
			</div>
												
			<div class="inputGroup">
			<label class="label" for="department" style="display: block;">담당부서</label>
			<select id="editDepartment" name="department" value="${marketing.department}">
				<option>마케팅팀</option>
				<option>인사팀</option>
				<option>회계팀</option>
				<option>재고관리팀</option>
				<option>영업팀</option>
			</select>
			</div>	
															
			<div class="inputGroup">
			<label class="label" for="eventType" style="display: block;">프로모션 유형</label>
			<select id ="editEventType" name="eventType" value="${marketing.eventType}">
				<option>인스타그램 홍보</option>
				<option>유튜브 홍보</option>
				<option>블로그 홍보</option>
				<option>틱톡 홍보</option>
				<option>사인회</option>
				<option>복콘서트</option>
			</select>
			</div>	
												
			<div class="inputGroup">
			<label class="label">프로젝트명</label>
				<input type="text" id="editEventName" name="eventName" value="${marketing.eventName}"/>
			</div>
												
			<div class="inputGroup">
			<label class="label">프로모션 시작일</label>
				<input type="date" id="editDurationStart" name="durationStart" value="${marketing.durationStart}"/>
			</div>
																		
			<div class="inputGroup">
			<label class="label">프로모션 종료일</label>
				<input type="date" id="editDurationEnd" name="durationEnd" value="${marketing.durationEnd}" />
			</div>
												
			<div class="inputGroup">
			<label class="label">비용</label>
				<input type="text" id="editCost" name="cost" value="${marketing.cost}"/>
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
		document.getElementById("mktModal").style.display = "flex";
		}

		// 모달 닫기
		function closeModal() {
		document.getElementById("mktModal").style.display = "none";
		}
		
		
		$("#delete").click(() => {
			const eventNo = $("input[name='eventNo']:checked").val();
			if(!eventNo){
				alert("삭제할 내용을 선택하세요");
				return;
			}
			$.ajax({
				type:"POST",
				url:"/deleteMarketing",
				data:{
					eventNo: eventNo
				},
				success: function(result){
					if(result=="success"){
						alert("삭제 완료");
						location.href="/allMarketing"
					}
				},
				error: function(){
					alert("삭제 실패")
				}
			});
			
		});
		
		$("#create").click((e)=>{
					e.preventDefault();
					
					const companyName = $("#companyName").val();
					const createdAt = $("#createdAt").val();
					const createdBy = $("#createdBy").val();
					const department = $("#department").val();
					const eventType = $("#eventType").val();
					const eventName = $("#eventName").val();
					const durationStart = $("#durationStart").val();
					const durationEnd = $("#durationEnd").val();
					let cost = $("#cost").val();
					
					if(!companyName||!createdAt||!createdBy|| 
						!department||!eventType||!eventName|| 
						!durationStart||!durationEnd||cost === null || cost.trim() === "")
						{
							alert("등록할 내용을 입력해주세요.");
							return;
						}
					//시작 날짜가 종료 날짜보다 뒤일때 반환	
					if (new Date(durationStart) > new Date(durationEnd)) 
					{
							alert("시작 날짜는 종료 날짜보다 이전이어야 합니다.");
							return;
					}	
					if (cost < 0) 
					{
						alert("비용은 마이너스가 될 수 없습니다.");
						return;
					}	
						
						
					const formData = new FormData();
					formData.append("companyName",companyName);
					formData.append("createdAt",createdAt);
					formData.append("createdBy",createdBy);
					formData.append("department",department);
					formData.append("eventType",eventType);
					formData.append("eventName",eventName);	
					formData.append("durationStart",durationStart);
					formData.append("durationEnd",durationEnd);
					formData.append("cost",cost);
					
					
				$.ajax({
					type:"POST",
					url:"/newMarketing",
					data:formData,
					processData: false,
					contentType: false,
					success: function(result){
						if(result =="success"){
							alert("신규 마케팅 등록 완료!");
							location.href = "/allMarketing";
						}
						else if(result == "notMem")
						{
							alert("담당 직원이 존재하지 않습니다.");
						}
						else if(result == "dateError")
						{
							alert("시작 날짜는 종료 날짜보다 이전이어야 합니다.");
						}
					
						
					},
					error: function(error){
						console.error("오류 발생:", error); // 콘솔에 오류 내용 출력
						alert("오류가 발생했습니다.");
					}
				});
				});
				
				$("#cancel").click(() => {
					location.href="/allMarketing"
				});
				
	// 마케팅 정보 수정 모달 script
	
	// 1. 모달 열닫
	function openEditModal(){$("#editMktModal").css("display", "flex");}
	function closeEditModal(){$("#editMktModal").hide();}
	$("#cancelEdit").on("click", closeEditModal);
	
	// 2. 수정 선택한 값 가져오기
	$("#update").off("click").on("click", function() {
		const eventNo = $("input[name='eventNo']:checked").val();
		if(!eventNo) return alert("정보를 수정할 프로모션을 선택해주세요.");
		
		$.get("/getMarketing", {eventNo})
		.done(function(e){
			$("#editEventNo").val(e.eventNo);
			$("#editCompanyName").val(e.companyName || "");
			$("#editCreatedAt").val(e.createdAt || "");
			$("#editCreatedBy").val(e.createdBy || "");
			$("#editDepartment").val(e.department || "");
			$("#editEventType").val(e.eventType || "");
			$("#editEventName").val(e.eventName || "");
			$("#editDurationStart").val(e.durationStart || "");
			$("#editDurationEnd").val(e.durationEnd || "");
			$("#editCost").val(e.cost || "");
			openEditModal();
		})
		.fail(function(){
			alert("발주 정보 상세 조회 실패");
		});
	});
	
	// 3. 수정된 값 저장
	$("#editMktForm").on("submit", function(e){
		e.preventDefault();
		const editCompanyName = $("#editCompanyName").val();
		const editCreatedAt = $("#editCreatedAt").val();
		const editCreatedBy = $("#editCreatedBy").val();
		const editDepartment = $("#editDepartment").val();
		const editEventType = $("#editEventType").val();
		const editEventName = $("#editEventName").val();
		const editDurationStart = $("#editDurationStart").val();
		const editDurationEnd = $("#editDurationEnd").val();
		let editCost = $("#editCost").val();
							
		if(!editCompanyName||!editCreatedAt||!editCreatedBy|| 
			!editDepartment||!editEventType||!editEventName|| 
			!editDurationStart||!editDurationEnd||editCost === null || editCost.trim() === "")
		{
			alert("등록할 내용을 입력해주세요.");
			return;
		}
		//시작 날짜가 종료 날짜보다 뒤일때 반환	
		if (new Date(editDurationStart) > new Date(editDurationEnd)) 
		{
			alert("시작 날짜는 종료 날짜보다 이전이어야 합니다.");
			return;
		}	
		if (editCost < 0) 
		{
			alert("비용은 마이너스가 될 수 없습니다.");
			return;
		}	
		$.ajax({
			url: "/updateMarketing",
			type: "POST",
			data: $(this).serialize(),
			success: function(res) {
				if($.trim(res) === "success") 
				{
					alert("저장되었습니다"); 
					closeEditModal();
					location.reload();
				}
				else if(res == "notMem")
				{
					alert("담당 직원이 존재하지 않습니다."); 
				}
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