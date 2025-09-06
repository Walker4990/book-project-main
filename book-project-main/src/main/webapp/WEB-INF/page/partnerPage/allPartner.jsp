<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>거래처 조회 페이지</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/partner.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
   	
	<section class="partner">
		<div class="box">
	<h1>거래처(매장) 조회</h1><br>
	
		<form class="searchForm" action="/allPartner" method="get">
			<div class="form-inline">
			<select name="select">
			<option value="name">업체명</option>
			<option value="type">온/오프라인</option>
			</select>
			
			<input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
			
			<div class="btn-wrap">
			<button type="submit" value="조회" class="btnNavy">조회</button>
			<button type="button" class="btnNavy" onclick="openModal()">신규 등록</button>
			</div>
			</div>
			</form>	
			
	<h1>전체 거래처 목록 조회</h1>	
	<div class="tableWrapper">
	<table class="table">
		<thead>
		<tr>
			<th>선택</th>
			<th>업체번호</th>
			<th>업체명</th>
			<th>온/오프라인</th>
			<th>거래시작일</th>
			<th>거래종료일</th>
		</tr>
		</thead>
		
		<tbody>
		<c:forEach items="${partnerList}" var="partner">		
		<tr>
			<td><input type="radio" name="partner" value="${partner.partnerNo}"></td>
		    <td>${partner.partnerNo}</td>
			<td>${partner.name}</td>
			<td>${partner.type}</td>
			<td>${partner.startDate}</td>
			<td>${partner.endDate}</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	
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
	</div>
	</div>
	</section>
	
	<!-- 🟫 모달 영역 시작 -->
			<div id="partnerModal" class="modal-overlay">
			 <div class="modal-box">
				<div class="modal-header">
					<h5 class="modal-title">신규 거래처(매장) 등록</h5>
			 <button class="close-btn" onclick="closeModal()">✕</button>
			 </div>
			 
			 <div class="modal-body">
			   <form action="/newPartner" method="post" id="poForm">
				<div class="form-grid">
			    
				
				<div class="input">
				<label class="label">거래처명</label>
				<input type="text" id="name" name="name" required/>
				</div>
				
				<div class="input">
				<label class="label">온/오프라인</label>
				<div class="radio-group">
			    <label class="radio"><input type="radio" name="type" id="online" value="온라인"  checked>온라인</label>
				<label class="radio"><input type="radio" name="type" id="offline" value="오프라인">오프라인</label>
			</div>	
			</div>

				<div class="input">
				<label class="label">거래 시작일</label>
				<input type="date" id="startDate" name="startDate" required/>
				</div>
				
				<div class="input">
				<label class="label">거래 종료일</label>
				<input type="date" id="endDate" name="endDate" required/>
				</div>
				</div>
				</div>
							
				<div class="modal-footer">
				<button type="button" id="create">등록</button>
				<button type="button" id="cancel">취소</button>
				</div>
				
				</form>
				</div>
				</div>
				<!-- 🟫 모달 영역 끝 -->
		
				<!-- 🟫 모달 영역 시작 : 거래처 정보 수정 -->
				<div id="editPartnerModal" class="modal-overlay">
				<div class="modal-box">
					<div class="modal-header">
						<h5 class="modal-title">거래처 정보 수정</h5>
				<button class="close-btn" onclick="closeEditModal()">✕</button>
				</div>
			
				<div class="modal-body">
				<form id="editPartnerForm">		
					<div class="form-grid">
						
				<input type="hidden" name="partnerNo" id="editPartnerNo" value="${partner.partnerNo}"/>	
					
				<div class="inputGroup">
				<label class="label">거래처명</label>
				<input type="text" id ="editName" name="name" placeholder="${partner.name}">
				</div>
				
				<div class="inputGroup">
				<label class="label">거래 시작일</label>
				<input type="date" id="editStartDate" name="startDate" value="${partner.startDate}" disabled /><br />
				</div>
				
								
				<div class="inputGroup">
				<label class="label">거래 종료일</label>
				<input type="date" id ="editEndDate" name="endDate" value="${partner.endDate}">
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
		document.getElementById("partnerModal").style.display = "flex";
		}

		// 모달 닫기
		function closeModal() {
		document.getElementById("partnerModal").style.display = "none";
		}
		
		$("#delete").click(() => {
			const selectedPartnerNo = $("input[name='partner']:checked").val();
			
			const formData = new FormData();
			formData.append("partnerNo", selectedPartnerNo);
			
			if(selectedPartnerNo)
						{
			$.ajax({
				type : "POST",
				url : "/deletePartner",
				data : formData,
				processData: false,
				contentType: false,
				success: function (result) {
					if (result === "success") {
						alert("해당정보가 삭제되었습니다.");
						location.href = "/allPartner";
					} else {
						alert("삭제할 수 없습니다.");
						location.href = "/allPartner";
					}	
				},
			})
		}
					else
					{
						alert("삭제할 거래처를 선택하세요.");
					}
		})
		
		$("#create").click(() => {
					// required 검사
					let allValid = true;
			$("input:required").each(function () {
				if (!this.checkValidity()) { //required, type, pattern 등의 유효성 검사를 실행
					this.reportValidity(); // 브라우저 기본 알림 띄우기
				allValid = false;
				return false; // break
				}
				});
					if (!allValid) return;
							
					const name = $("#name").val();
					const type = $("input[name='type']:checked").val();
					const startDate = $("#startDate").val();
					const endDate = $("#endDate").val();
					if (startDate && endDate && startDate > endDate){
						alert("거래시작일이 더 빨라야합니다.");
						return;
					}
					
					$.ajax({
						type:"POST",
						url:"/newPartner",
						data: {
						name: name,
						type: type,
						startDate: startDate,
						endDate: endDate
						},
						success: function(result) {
						if (result=="success"){
						alert("등록 완료");
						location.href = "/allPartner"
						}
						else if(result==="fail")
						alert("등록 실패")	;
						},
						error:function(){
							alert("서버오류");
						}
						
					});	 					
				});
									
				$("#cancel").click(() => {
					location.href="/allPartner"
				});
				
				// 거래처 정보 수정 script
				
				// 1. 모달 열닫
				function openEditModal(){$("#editPartnerModal").css("display", "flex");}
				function closeEditModal(){$("#editPartnerModal").hide();}
				$("#cancelEdit").on("click", closeEditModal);
				
				// 2. 수정 선택한 값 가져오기
				$(document).off("click", "#update").on("click", "#update", function () {
				  // 1) 라디오 선택 됐는지 length로 확인 (value가 "0"일 수도 있으니 값 대신 length)
				  const $checked = $('.table input[type="radio"][name="partner"]:checked');
				  if ($checked.length === 0) {
				    alert("정보를 수정할 거래처를 선택해주세요.");
				    return;
				  }
				  const partnerNo = $checked.val();

				  // 2) 상세조회는 반드시 JSON으로 내려오게(@ResponseBody)
				  $.get("/getPartner", { partnerNo })
				    .done(function (p) {
				      // 서버가 JSON을 주는지 로그로 확인해보세요
				      // console.log(p);

				      $("#editPartnerNo").val(p.partnerNo);
				      $("#editName").val(p.name || "");
					  $("#editStartDate").val(p.startDate || "");
				      $("#editEndDate").val(p.endDate || "");

				      // 3) 여기서 모달 오픈
				      openEditModal();
				    })
				    .fail(function () {
				      alert("거래처 정보 상세 조회 실패");
				    });
				});
			 
			 // 수정된 값 저장
			 $("#editPartnerForm").on("submit", function(e){
				e.preventDefault();
				const startDate = $("#editStartDate").val();
				const endDate = $("#editEndDate").val();
				
				if (startDate && endDate && new Date(startDate) > new Date(endDate)) {
				  		alert("거래시작일이 거래종료일보다 빨라야 합니다.");
				        return; 
				    }
				$.ajax({
					url: "/updatePartner",
					type: "POST",
					data: $(this).serialize(),
					success: function(res) {
						if($.trim(res) === "success") {alert("저장되었습니다."); closeEditModal(); location.reload();}
						
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