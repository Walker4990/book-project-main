<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/claim.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
  </head>
  <body>
	
	<section class="claim">
		<div class="box">
    <h1>클레임 검색</h1><br>
   
	<form class="searchForm" action="/allClaim" method="get">
		<div class="form-inline">
		<select name="select">
		<option value="name">업체명</option>
		<option value="title">도서명</option>
		</select>
		
		<input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요.">
		
		<div class="btn-wrap">
		<button type="submit" value="조회" class="btnNavy">조회</button>
		<button type="button" class="btnNavy" onclick="openModal()">등록</button>
		</div>
		</div>
		</form>	
	
    <h1>전체 클레임 조회</h1><br>
	<div class="tableWrapper">
    <table class="table">
		<thead>
      <tr>
        <th>선택</th>
		<th>클레임 번호</th>
        <th>업체명</th>
		<th>도서명</th>
		<th>가격</th>
		<th>클레임 수량</th>
		<th>총 금액</th>
		<th>클레임 유형</th>
		<th>회수 가능 여부</th>
		<th>회수 상태</th>
		<th>상세 설명</th>
        <th>클레임 등록 날짜</th>
      </tr>
	  </thead>

	  <tbody>
      <c:forEach items="${claimList}" var="claim">
        <tr>
          <td><input type="radio" name="claim" value="${claim.claimNo}"></td>
          <td>${claim.claimNo}</td>
          <td>${claim.name}</td>
          <td>${claim.title}</td>
		  <td>${claim.price}</td>
		  <td>${claim.quantity}</td>
		  <td>${claim.totalAmount}</td>
		  <td>${claim.defectType}</td>
		  <td>${claim.recall}</td>
		  <td>${claim.recallStatus}</td>
		  <td>${claim.content}</td>
		  <td>${claim.claimDate}</td>
        </tr>
      </c:forEach>
	  </tbody>
    </table>
	</div>
	<div class="bottomBtn">
	<button id="update" type="button"  class="update adminAccess">수정</button>
	<button id="delete" type="button"  class="delete adminAccess">삭제</button>
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
	
	</section>
	
	<!-- 🟫 모달 영역 시작 -->
		  <div id="claimModal" class="modal-overlay">
		    <div class="modal-box">
			<div class="modal-header">
		      <h5 class="modal-title">클레임 등록</h5>
			  <button class="close-btn" onclick="closeModal()">✕</button>
			  </div>
			  
			  <form action="/newClaim" method="post" id="claimForm">
			  <div class="modal-body">   
				<div class="form-grid">
				
			<div class="input">
			  <label class="label" for="partnerSelect">업체명</label>
			  <select name="partnerNo" id="partnerSelect" required>
			    <c:forEach var="partner" items="${partnerList}">
			      <option value="${partner.partnerNo}">${partner.name}</option>
			    </c:forEach>
			  </select> 
			  </div>

			  <div class="input">
			  <label class="label" for="bookSelect">도서명</label>
			  <select name="bookNo" id="bookSelect" required>
			    <c:forEach var="book" items="${bookList}">
			      <option value="${book.bookNo}" data-price="${book.price}">${book.title}</option>
			    </c:forEach>
			  </select>
			   </div>  
			   
			   <div class="input">
			  <label class="label">클레임 유형</label>
			  <div class="defectType-group">
			  <label class="cbox"><input type="checkbox" name="defectTypeList" value="인쇄 불량"><span>인쇄 불량</span></label>
			  <label class="cbox"><input type="checkbox" name="defectTypeList" value="오타"><span>오타</span></label>
			  <label class="cbox"><input type="checkbox" name="defectTypeList" value="찢어짐"><span>찢어짐</span></label>
			  </div>
			  </div> 
			  
			  <div class="input">
			  <label class="label">수량</label>
		      <input type="number" id="quantity" name="quantity" min="1" required>
			  </div>
			  
			  <div class="input">
			  <label class="label">가격</label>
			  <input type="text" id="price" name="price" readonly />
			  </div>
			  
			  <div class="input">
			  <label class="label">총 금액</label>
			  <input type="number" id="totalAmount" name="totalAmount" min="0" required>
			  </div>
		   
			  <div class="input">
			  <label class="label">클레임 내용</label>
			  <textarea name="content" cols="70" rows="5" placeholder="내용을 입력하세요" required></textarea>
			  </div>
		
			  <div class="input">
			  <label class="label">회수 가능 여부</label>
			  <div class="radio-group">
			  <label class="radio">
			  <input type="radio" name="recall" value="회수 가능" id="man" checked>회수 가능
			  </label>
			  <label class="radio">
			  <input type="radio" name="recall" value="회수 불가" id="woman">회수 불가
			  </label>
			  </div>
			  </div>
	     
			  <div class="input">
			    <label class="label" for="recallStatus">회수 상태</label> 
			    <select id="recallStatus" disabled>
			      <option value="접수중" selected>접수중</option>
			      <option value="처리중">처리중</option>
			      <option value="완료">완료</option>
			      <option value="회수 불가">회수 불가</option>
			    </select>
			    <!-- 서버에 넘길 값 -->
			    <input type="hidden" id="hiddenRecallStatus" name="recallStatus" value="접수중">
			  </div>
		  
			  
			  <div class="input">	
			  <label class="label">등록 날짜</label>
			  <input type="date" id="claimDate" name="claimDate" required>
			  </div>
		  
		  </div>
		  </div>
		  
		  <div class="modal-footer">	  
		  		  <button type="submit" id="create" value="등록">등록</button>
		  		  <button type="button" id="cancel" value="취소">취소</button>
	   </div>
	       
		</form>
	    </div>
		</div>
	
	
		
		

		  <!-- 🟫 모달 영역 끝 -->
		  
<!-- 🟫 모달 영역 시작 :  클레임 수정 -->
		  <div id="editClaimModal" class="modal-overlay">
		  <div class="modal-box">			
			<div class="modal-header">
			<h5 class="modal-title">클레임 수정</h5>
		  <button class="close-btn" onclick="closeEditModal()">✕</button>
		  </div>
		  				
		  <div class="modal-body">
		  		<form id="editClaimForm">
					<div class="form-grid">
							
		  		<div class="inputGroup">
		  		<label class="label">클레임 번호</label>
		  		<input type="number" id="editClaimNo" name="claimNo" value="${selectedClaim.claimNo}" readonly >
		  		</div>

		  		<div class="inputGroup">
		  		<label class="label">업체명</label>
				<input type="hidden" id="editPartnerNo" name="partnerNo" value="${selectedClaim.partnerNo}" />
		  		<input type="text" id="editName" name="name" value="${selectedClaim.name}" readonly >
		  	    </div>
				
				<div class="inputGroup">
				<label class="label">도서명</label>
				<input type="hidden" id="editBookNo" name="bookNo" value="${selectedClaim.bookNo}" />
				<input type="text" id="editClaimTitle" name="title" value="${selectedClaim.title}" readonly >
				</div>

		  		<div class="inputGroup">
		  		<label class="label">가격</label>
		  		<input type="number" id="editPrice" name="price" value="${selectedClaim.price}" readonly >
		  		</div>
		  						  
		  		<div class="inputGroup">
		  		<label class="label">수량</label>
		  		<input type="number" id="editQuantity" name="quantity" value="${selectedClaim.quantity}" min="0" >
		  		</div>
		  						  
		  		<div class="inputGroup">
		  		<label class="label">총 금액</label>
		  		<input type="number" id="editTotalAmount" name="totalAmount" value="${selectedClaim.totalAmount}" readonly >
		  		</div>
		  		
				<div class="inputGroup">			   
		  		<label class="label">클레임 유형</label>
				<div class="defectType-group" id="editStatusWrap" >
					<label class="cbox"><input type="checkbox" name="defectTypeList" value="인쇄 불량" ><span>인쇄 불량</span></label>
					<label class="cbox"><input type="checkbox" name="defectTypeList" value="오타" ><span>오타</span></label>
					<label class="cbox"><input type="checkbox" name="defectTypeList" value="찢어짐" ><span>찢어짐</span></label>
		  		</div>
				</div>
		  						  
		  		<div class="inputGroup">
		  		<label class="label">클레임 내용</label><br>
		  		<textarea id="editContent" name="content" cols="70" rows="5">${selectedClaim.content}</textarea>
		  		</div>
		  				
				<div class="inputGroup">
					<label class="label">회수 가능 여부</label>	
				  <div class="radio-group" id="editRecallGroup" >	
				    <label class="radio">
				      <input type="radio" name="recall" value="회수 가능" required> 회수 가능
				    </label>
				    <label class="radio">
				      <input type="radio" name="recall" value="회수 불가" required> 회수 불가
				    </label>
				  </div>
				</div> 
		  		
				<div class="inputGroup">
				  <label class="label" for="editRecallStatus">회수 상태</label> 
				  <select id="editRecallStatus" disabled>
				    <option value="접수중">접수중</option>
				    <option value="처리중">처리중</option>
				    <option value="완료">완료</option>
				    <option value="회수 불가">회수 불가</option>
				  </select>
				  <!-- 실제 서버로 전달될 값 -->
				  <input type="hidden" id="hiddenRecallStatusEdit" name="recallStatus">
				</div>
		  					  
		  						  
		  		<div class="inputGroup">	
		  		<label>등록 날짜</label>
		  		<input type="date" id="editClaimDate" name="claimDate" value="${selectedClaim.claimDate}" required>
		  		</div>
				</div>
				</div>
		  				     
		  		<div class="modal-footer">	  
		  		<button type="submit" id="acceptEdit" value="등록">수정</button>
		  		<button type="button" id="cancelEdit" value="취소">취소</button>
		  		</div>
		  		</form>
		  	</div>
		</div>
<!-- 🟫 모달 영역 끝 -->
	
<script>
  // 🟫 수정 모달 - 회수 여부 라디오 변경 시 처리
  $("#editClaimForm input[name='recall']").on("change", function() {
    const recallVal = $(this).val();
    if (recallVal === "회수 불가") {
      $("#editRecallStatus")
        .html('<option value="회수 불가" selected>회수 불가</option>')
        .val("회수 불가")
        .prop("disabled", true);
      $("#hiddenRecallStatusEdit").val("회수 불가"); // 수정 모달 전용 hidden
    } else {
      $("#editRecallStatus")
        .html(
          '<option value="접수중">접수중</option>'
          + '<option value="처리중">처리중</option>'
          + '<option value="완료">완료</option>'
        )
        .prop("disabled", false)
        .val("접수중");
      $("#hiddenRecallStatusEdit").val("접수중");
    }
  });

  // 🟫 수정 모달 - select 값이 바뀔 때 hidden 값 동기화
  $("#editRecallStatus").on("change", function() {
    $("#hiddenRecallStatusEdit").val($(this).val());
  });

  // 🟫 등록 모달 - select 값이 바뀔 때 hidden 값 동기화
  $("#recallStatus").on("change", function() {
    $("#hiddenRecallStatus").val($(this).val());
  });

  // 🟫 숫자 변환 유틸 함수 (등록/수정 공용)
  function _toNum(v) {
    return Number(String(v ?? '').replace(/,/g, '')) || 0;
  }

  // 🟫 등록 모달 - 총 금액 계산
  function recalcCreateTotal() {
    const q = _toNum($('#quantity').val());
    const p = _toNum($('#price').val());
    $('#totalAmount').val(q * p);
  }

  // 🟫 수정 모달 - 총 금액 계산
  function recalcEditTotal() {
    const q = _toNum($('#editQuantity').val());
    const p = _toNum($('#editPrice').val());
    $('#editTotalAmount').val(q * p);
  }

  // 🟫 등록 모달 열기
  function openModal() {
    $("#claimModal").css("display", "flex");

    // 현재 라디오 값에 따라 회수 상태 select 초기화
    const recallVal = $("#claimForm input[name='recall']:checked").val();
    const $select = $("#recallStatus");

    if (recallVal === "회수 불가") {
      $select.html('<option value="회수 불가" selected>회수 불가</option>');
      $select.prop("disabled", true);
      $("#hiddenRecallStatus").val("회수 불가");
    } else {
      $select.html(
        '<option value="접수중" selected>접수중</option>'
        + '<option value="처리중">처리중</option>'
        + '<option value="완료">완료</option>'
      );
      $select.prop("disabled", false);
      $("#hiddenRecallStatus").val($select.val());
    }
  }

  // 🟫 등록 모달 - 회수 여부 라디오 변경 시 처리
  // 등록 모달 회수 여부 변경
  $("#claimForm input[name='recall']").on("change", function() {
    const recallVal = $(this).val();
    const $select = $("#recallStatus");
    if (recallVal === "회수 불가") {
      $select.html('<option value="회수 불가" selected>회수 불가</option>')
             .prop("disabled", true);
      $("#hiddenRecallStatus").val("회수 불가");
    } else {
      $select.html(
        '<option value="접수중" selected>접수중</option>'
        + '<option value="처리중">처리중</option>'
        + '<option value="완료">완료</option>'
      ).prop("disabled", false);
      $("#hiddenRecallStatus").val("접수중");
    }
  });

  // 🟫 모달 닫기
  function closeModal() {
    $("#claimModal").hide();
  }
  $("#cancel").on("click", closeModal);

  // 🟫 삭제 버튼
  $("#delete").click(() => {
    const claimNo = $("input[name='claim']:checked").val();
    if (!claimNo) {
      alert("삭제하실 항목을 선택해주세요.");
      return;
    }
    $.ajax({
      url: "/deleteClaim",
      type: "post",
      data: { claimNo },
      success: function() {
        alert("삭제되었습니다.");
        location.href = "/allClaim";
      },
      error: function() {
        alert("삭제에 실패했습니다.");
      }
    });
  });

  // 🟫 등록 폼 submit
  $("#claimForm").off("submit").on("submit", function(e) {
    e.preventDefault();

    // 유효성 검사
    const defectChecked = $("#claimForm input[name='defectTypeList']:checked").length > 0;
    const recallChecked = $("#claimForm input[name='recall']:checked").length > 0;
    const dateChecked = $("#claimDate").val();

    if (!defectChecked) return alert("클레임 유형을 최소 한 개 이상 선택해주세요.");
    if (!recallChecked) return alert("회수 가능 여부를 선택해주세요.");
    if (!dateChecked) return alert("등록 날짜를 선택해주세요");

    // Ajax 등록
    $.ajax({
      url: "/newClaim",
      type: "POST",
      data: $(this).serialize(),
      success: function(res) {
        switch ($.trim(res)) {
          case "success": alert("등록되었습니다."); closeModal(); location.reload(); break;
          case "partnerNoError": alert("업체를 선택해주세요."); break;
          case "bookNoError": alert("도서를 선택해주세요."); break;
          case "quantityError": alert("수량을 입력해주세요."); break;
          case "totalError": alert("총 금액이 올바르지 않습니다."); break;
          case "contentError": alert("클레임 내용을 입력해주세요."); break;
          case "recallError": alert("회수 가능 여부를 선택해주세요."); break;
          case "recallStatusError": alert("회수 상태를 선택해주세요."); break;
          case "dateError": alert("등록 날짜를 선택해주세요."); break;
          case "defectTypeError": alert("클레임 유형을 최소 1개 이상 선택해주세요."); break;
          default: alert("등록 실패");
        }
      },
      error: function() {
        alert("서버 오류로 등록에 실패했습니다.");
      }
    });
  });

  // 🟫 도서 선택 시 가격/합계 반영
  selectBook($('#bookSelect').val());
  $('#bookSelect').change(function() {
    selectBook($(this).val());
    recalcCreateTotal();
  });
  function selectBook(bookNo) {
    $.ajax({
      url: '/selectBook',
      type: 'get',
      data: { bookNo },
      success: function(data) {
        $('#price').val(data.price);
        recalcCreateTotal();
      }
    });
  }
  $('#quantity').off('input').on('input', recalcCreateTotal);

  // 🟫 수정 모달 열기
  function openEditModal() {
    $("#editClaimModal").css("display", "flex");

    const recallVal = $("#editClaimForm input[name='recall']:checked").val();
	const $select = $("#editRecallStatus");
    const recallStatusVal = $select.val() || $("#hiddenRecallStatusEdit").val() || "접수중";
    

    if (recallVal === "회수 불가") {
      $select.html('<option value="회수 불가">회수 불가</option>');
      $select.val("회수 불가");
      $select.prop("disabled", true);
      $("#hiddenRecallStatusEdit").val("회수 불가");
    } else {
      $select.html(
        '<option value="접수중">접수중</option>'
        + '<option value="처리중">처리중</option>'
        + '<option value="완료">완료</option>'
      );
      $select.prop("disabled", false);
	  $select.val(recallStatusVal); // ★ 서버에서 세팅된 값 유지
	      $("#hiddenRecallStatusEdit").val($select.val());
    }
  }

  function closeEditModal() { $("#editClaimModal").hide(); }
  $("#cancelEdit").on("click", closeEditModal);

  // 🟫 수정 버튼 클릭 시 데이터 바인딩
  $("#update").off("click").on("click", function() {
    const claimNo = $("input[name='claim']:checked").val();
    if (!claimNo) return alert("수정할 클레임을 선택해주세요.");

    $.get("/getClaim", { claimNo })
      .done(function(c) {
        // 데이터 바인딩
        $("#editClaimNo").val(c.claimNo);
        $("#editName").val(c.name || "");
        $("#editClaimTitle").val(c.title || "");
        $("#editPrice").val(c.price ?? 0);
        $("#editQuantity").val(c.quantity ?? 0);
        $("#editTotalAmount").val(c.totalAmount ?? 0);
        $("#editBookNo").val(c.bookNo || "");
        $("#editPartnerNo").val(c.partnerNo || "");

        // 클레임 유형 체크박스
        $("#editClaimForm input[name='defectTypeList']").prop("checked", false);
        let types = [];
        if (Array.isArray(c.defectTypeList)) types = c.defectTypeList;
        else if (typeof c.defectType === "string") types = c.defectType.split(",");
        types.forEach(v => {
          $("#editClaimForm input[name='defectTypeList'][value='" + String(v).trim() + "']").prop("checked", true);
        });

        // 본문
		$("#editClaimForm input[name='recall']").prop("checked", false);

		// 공백/NBSP 제거해서 비교
		const normalize = s => String(s ?? '').replace(/[\s\u00A0]/g, '');
		const target = normalize(c.recall);

		// 옵션들 중 정규화 후 값이 같은 걸 체크
		let matched = false;
		$("#editClaimForm input[name='recall']").each(function(){
		  if (normalize(this.value) === target) {
		    this.checked = true;
		    matched = true;
		  }
		});

		// 혹시 못 찾으면 기본값으로 '회수 가능' 체크
		if (!matched) {
		  $("#editClaimForm input[name='recall'][value='회수 가능']").prop("checked", true);
		}

        // 회수 상태 / 날짜
        $("#editRecallStatus").val(c.recallStatus || "");
		$("#hiddenRecallStatusEdit").val(c.recallStatus || "");
        $("#editClaimDate").val(c.claimDate || "");

        // 합계 계산
        recalcEditTotal();
        $('#editQuantity').off('input').on('input', recalcEditTotal);

        openEditModal();
      })
      .fail(function() { alert("클레임 상세 조회 실패"); });
  });
  
  // 회수 상태 select → hidden 반영
  $("#editClaimForm").on("change", "#editRecallStatus", function () {
    $("#hiddenRecallStatusEdit").val(this.value);
  });

  // 회수 가능 여부 라디오 변경 시 select 구성 및 hidden 동기화
  $("#editClaimForm").on("change", "input[name='recall']", function () {
    const val = this.value;
    const $s  = $("#editRecallStatus");

    if (val === "회수 불가") {
      $s.html('<option value="회수 불가">회수 불가</option>')
        .val("회수 불가")
        .prop("disabled", true);
      $("#hiddenRecallStatusEdit").val("회수 불가");
    } else {
      const keep = $("#hiddenRecallStatusEdit").val() || "접수중";
      $s.prop("disabled", false)
        .html(
          '<option value="접수중">접수중</option>' +
          '<option value="처리중">처리중</option>' +
          '<option value="완료">완료</option>'
        )
        .val(keep);
      $("#hiddenRecallStatusEdit").val($s.val());
    }
  });

  // 🟫 수정 폼 submit
  $("#editClaimForm").off("submit").on("submit", function(e){
    e.preventDefault();

    const defectChecked = $("#editClaimForm input[name='defectTypeList']:checked").length > 0;
    const recallChecked = $("#editClaimForm input[name='recall']:checked").length > 0;
    const recallStatus = $("#hiddenRecallStatusEdit").val(); // ★ select 대신 hidden 기준으로 확인
    const qty = $("#editQuantity").val();
    const content = $("#editContent").val();

    if(!defectChecked) return alert("클레임 유형을 최소 한 개 이상 선택해주세요");
    if(!recallChecked) return alert('회수 가능 여부를 선택해주세요');
    if(!recallStatus) return alert('회수 상태를 선택해주세요'); // hidden 값 확인
    if(!qty) return alert('수량을 입력해주세요');
    if(!content) return alert('상세 설명을 입력해주세요');

    $.ajax({
      url: "/updateClaim",
      type: "POST",
      data: $(this).serialize(),
      success: function(res) {
        switch($.trim(res)) {
          case "success":
            alert("저장되었습니다");
            closeEditModal();
            location.reload();
            break;
          case "fail": alert("저장 실패"); break;
          default: alert("서버 오류 저장 실패");
        }
      },
      error: function(){
        alert("서버 오류 저장 실패");
      }
    });
  });
</script>


  </body>
</html>
