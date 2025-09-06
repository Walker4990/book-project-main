<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>전직원 급여 일괄 지급 등록(모달), 급여 조회</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/salary.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  
</head>
<body>

	<!-- 급여 전체 조회 화면 -->
<section class="salary">
  <div class="box">
    <h1>전직원 급여 검색 조회</h1><br>
	<!-- 검색/조회 -->
    <form action="/newSalary" method="get" class="searchForm">
      <div class="form-inline">
        
        <input type="text" name="keyword" value="${param.keyword}" placeholder="이름, 사원번호 검색" />
		
        <div class="btn-wrap">
          <button type="submit" value="조회" class="btnNavy">조회</button>
		  <button type="button" class="btnNavy adminAccess" onclick="openInsertSalaryModal()">등록</button>
        </div>
      </div>
    </form>

	<!-- 전체 급여 리스트 테이블 -->
    <h1>급여 전체 조회</h1><br>
    <div class="tableWrapper">
      <table class="table">
        <thead>
          <tr>
            <th>선택</th>
            <th>직원</th>
            <th>사원 번호</th>
            <th>기본급</th>
            <th>직책수당</th>
            <th>식대</th>
            <th>초과근무 수당</th>
			<th>보너스</th>
            <th>세금</th>
            <th>적용 시작일</th>
            <th>총 급여</th>
          </tr>
        </thead>
        <tbody>
			<!-- 서버에서 내려온 memberList 출력 -->
          <c:forEach items="${memberList}" var="salary">
            <tr>
              <td><input type="radio" name="salary" value="${salary.salaryNo}"></td>
              <td>${salary.name}</td>
              <td>${salary.memberNo}</td>
              <td>${salary.baseSalary}</td>
              <td>${salary.positionAllowance}</td>
              <td>${salary.mealAllowance}</td>
              <td>${salary.otRate}</td>
			  <td>${salary.bonus}</td>
              <td>${salary.tax}</td>
              <td>${salary.effectiveDate}</td>
              <td>${salary.totalSalary}</td>
			  
            </tr>
          </c:forEach>
        </tbody>
      </table> 
	  
	  <div class="bottomBtn">
	     <button class="update adminAccess" type="button" id="update">수정</button>
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


<!-- 급여 등록 모달 -->

<div id="insertSalaryModal" class="modal-overlay">
  <div class="modal-box">
	<div class="modal-header">
		<h5 class="modal-title">급여 등록</h5>
    <button class="close-btn" onclick="closeInsertSalaryModal()">✕</button>
	</div>
	
	<div class="modal-body">
	<form id="salaryAllForm">
		
		
		<div class="input">
          <label class="label" for="salaryMonth">급여월</label>
		</div>
		
		<div class="form-inline-salary">
		<!-- 급여월 선택 -->
		<div class="input">
          <input type="month" id="salaryMonth" name="salaryMonth" required>
        </div>
		
		<!-- 모달 내 사원 검색창 -->
		<div class="input">
        <input type="text" id="memberSearch" placeholder="사원명 또는 사번을 입력하세요">
		</div>
		
		</div>
		
		<!-- 등록 대상 테이블 (Ajax 검색 결과 렌더링) -->
        <table class="table" id="salaryTable">
          <thead>
            <tr>
              <th>사번</th>
              <th>이름</th>
              <th>기본급</th>
              <th>식대</th>
              <th>직책수당</th>
              <th>보너스</th>
              <th>초과수당</th>
              <th>세금</th>
              <th>총 지급액</th>
              <th>보너스 입력</th>
            </tr>
          </thead>
          <tbody id="salaryTargetBody"></tbody>
        </table>
		</div>
 
		
        <div class="modal-footer">
        <button type="submit" id="submitBtn">일괄 등록</button>
        <button type="button"  onclick="closeInsertSalaryModal()">취소</button>
        </div>
		
      </form>
    </div>
	</div>
	</div>
	

<!-- 보너스 입력 모달 -->
<div id="bonusModal" class="modal-overlay">
  <div class="modal-content">
    <span id="closeBonusModal" class="close" onclick="closeBonusModal()" style="cursor:pointer;">&times;</span>
    <h1>보너스 입력</h1><br>
    <input type="number" id="bonusInput" placeholder="보너스 입력" min="0" step="1">
	
	<div class="bottomBtn">
    <button type="button" id="bonusSave" class="btnNavy">적용</button>
   </div>
</div>
</div>

<!-- 급여 수정 모달 -->
<div id="editSalaryModal" class="modal-overlay">
  <div class="modal-box">
	<div class="modal-header">
	 <h5 class="modal-title">급여 수정</h5>
    <button class="close-btn" id="closeEditModal">✕</button>
    </div>

	<div class="modal-body">
	    <form id="editSalaryForm" onsubmit="return false;">
			<div class="form-grid">
	      <input type="hidden" name="salaryNo" id="editSalaryNo">

	      <div class="inputGroup">
	        <label>사번</label>
	        <input type="number" name="memberNo" id="editMemberNo" readonly>
	      </div>
		  
	      <div class="inputGroup">
	        <label>사원명</label>
	        <input type="text" name="name" id="editName" readonly>
	      </div>
		  
	      <div class="inputGroup">
	        <label>부서명</label>
	        <input type="text" id="editDeptName" readonly>
	        <input type="hidden" name="deptNo"id="editDeptNo">
	      </div>

	      <div class="inputGroup"><label>기본급</label>
	        <input type="number" name="baseSalary" id="editBaseSalary"min="0" required>
	      </div>
		  
	      <div class="inputGroup"><label>직책수당</label>
	        <input type="number" name="positionAllowance" id="editPositionAllowance" min="0" required>
	      </div>
		  
	      <div class="inputGroup"><label>식대</label>
	        <input type="number" name="mealAllowance" id="editMealAllowance" min="0" required>
	      </div>
		  
	      <div class="inputGroup"><label>초과근무 수당</label>
	        <input type="number" name="otRate" id="editOtRate" min="0" required>
	      </div>
		  
	      <div class="inputGroup"><label>보너스</label>
	        <input type="number" name="bonus" id="editBonus" min="0" required>
	      </div>
		  
	      <div class="inputGroup"><label>적용 시작일</label>
	        <input type="date" name="effectiveDate" id="editEffectiveDate" required>
	      </div>
		  
	      <div class="inputGroup"><label>비고</label>
	        <input type="text" name="description" id="editDescription">
	      </div>
		  </div>
		  </div>

		  
	      <div class="modal-footer">
	        <button type="button" id="editSalaryBtn" class="btnNavy">저장</button>
	        <button type="button" class="btnGray" id="cancelEdit">취소</button>
	      </div>
	    </form>
	  </div>
	</div>

<script>
	console.log("JS 로드됨");
	  console.log("DOM ready");
  let currentRow = null; // 현재 보너스 입력 중인 행
  let bonusMap = {}; // memberNo 기준으로 보너스 저장 (검색 후에도 유지됨)

  // 전체 직원 불러오기 (키워드 없이)
  function loadAllMembers() {
    $.ajax({
      url: "/searchMember",
      type: "GET",
      data: { keyword: "" },  // 빈 검색어 → 전체 검색
      success: function(list) { renderTable(list); }// Ajax 결과 테이블 렌더링
    });
  }

  // 🔹 검색 이벤트 (실시간 검색)
  $("#memberSearch").on("input", function () {
    const keyword = $(this).val();
    $.ajax({
      url: "/searchMember",
      type: "GET",
      data: { keyword: keyword },
      success: function(list) { renderTable(list); }
    });
  });

// 🔹 Ajax 결과 테이블 렌더링
  function renderTable(list) {
    let html = "";
    if (!list || list.length === 0) {
      html = "<tr><td colspan='10' style='text-align:center;'>검색 결과가 없습니다.</td></tr>";
      $("#salaryTargetBody").html(html);
      return;
    }

    let idx = 0; // hidden name 인덱스
    list.forEach(mem => {
      // 기본값
      const baseSalary = parseInt(mem.baseSalary) || 0;
      const meal       = parseInt(mem.mealAllowance) || 0;
      const pos        = parseInt(mem.positionAllowance) || 0;
      const overtime   = parseInt(mem.otRate) || 0;

      // 보너스: 입력했던 값 유지
      const savedBonus = bonusMap[mem.memberNo];
      const bonus      = (savedBonus !== undefined) ? parseInt(savedBonus) : (parseInt(mem.bonus) || 0);

	  const taxable = baseSalary + pos + bonus + overtime;

	  // 4대보험 계산
	  const pension   = Math.floor(taxable * 0.045);      // 국민연금
	  const health    = Math.floor(taxable * 0.03545);    // 건강보험
	  const longTerm  = Math.floor(health * 0.1295);      // 장기요양
	  const empIns    = Math.floor(taxable * 0.009);      // 고용보험

	  let realTax = pension + health + longTerm + empIns;
	  let netPay  = taxable + meal - realTax;

	  // 원단위 정수화
	  realTax = Math.round(realTax);
	  netPay  = Math.round(netPay);
	  
	  // 테이블 행 + hidden input (Spring 자동 바인딩용)
	  html += ""
	    + "<tr data-member='" + mem.memberNo + "'>"
	    +   "<td>" + mem.memberNo + "</td>"
	    +   "<td>" + mem.name + "</td>"
	    +   "<td class='baseSalary'>" + baseSalary + "</td>"
	    +   "<td class='mealAllowance'>" + meal + "</td>"
	    +   "<td class='positionAllowance'>" + pos + "</td>"
	    +   "<td class='bonus'>" + bonus + "</td>"
	    +   "<td class='overtimePay'>" + overtime + "</td>"
	    +   "<td class='tax'>" + realTax + "</td>"
	    +   "<td class='netPay'>" + netPay + "</td>"
	    +   "<td>"
	    +     "<button type='button' class='btnNavy bonusBtn'>입력</button>"

		+ "<input type='hidden' name='memberList[" + idx + "].memberNo' value='" + mem.memberNo + "'>"
		+ "<input type='hidden' name='memberList[" + idx + "].baseSalary' value='" + baseSalary + "'>"
		+ "<input type='hidden' name='memberList[" + idx + "].mealAllowance' value='" + meal + "'>"
		+ "<input type='hidden' name='memberList[" + idx + "].positionAllowance' value='" + pos + "'>"
		+ "<input type='hidden' class='bonusField' name='memberList[" + idx + "].bonus' value='" + bonus + "'>"
		+ "<input type='hidden' class='otField' name='memberList[" + idx + "].otRate' value='" + overtime + "'>"
		+ "<input type='hidden' class='taxField' name='memberList[" + idx + "].tax' value='" + realTax + "'>"
		+ "<input type='hidden' class='netPayField' name='memberList[" + idx + "].totalSalary' value='" + netPay + "'>"
	    +   "</td>"
	    + "</tr>";
	  idx++;
    });

    $("#salaryTargetBody").html(html);
  }

  // 보너스 모달 열기
  $(document).on("click", ".bonusBtn", function () {
    currentRow = $(this).closest("tr");                // 현재 행 저장
    const bonus = parseInt(currentRow.find(".bonus").text()) || 0;
    $("#bonusInput").val(bonus);

    // ✅ 선택된 행을 모달에 data로 저장
    $("#bonusModal").data("targetRow", currentRow);

    $("#bonusModal").show();
  });

  // 보너스 모달 닫기
  $("#closeBonusModal").on("click", function(){ $("#bonusModal").hide(); });
  function closeBonusModal(){ $("#bonusModal").hide(); }

  // 보너스 저장
  $("#bonusSave").click(() => {
    const bonus = parseInt($("#bonusInput").val()) || 0;

    // ✅ 모달에 저장해둔 행을 꺼냄
    const currentRow = $("#bonusModal").data("targetRow");

    const memberNo   = currentRow.data("member");
    const baseSalary = parseInt(currentRow.find(".baseSalary").text()) || 0;
    const meal       = parseInt(currentRow.find(".mealAllowance").text()) || 0;
    const pos        = parseInt(currentRow.find(".positionAllowance").text()) || 0;
    const overtime   = parseInt(currentRow.find(".overtimePay").text()) || 0;
	
    const taxable   = baseSalary + pos + bonus + overtime;

    const incomeTax = Math.floor(taxable * 0.08);
    const localTax  = Math.floor(incomeTax * 0.10);
    const pension   = Math.floor(taxable * 0.045);
    const health    = Math.floor(taxable * 0.035);
    const empIns    = Math.floor(taxable * 0.009);

    let realTax = incomeTax + localTax + pension + health + empIns;
    let netPay  = taxable + meal - realTax;

    realTax = Math.round(realTax);
    netPay  = Math.round(netPay);

    // ✅ 화면 반영
    currentRow.find(".bonus").text(bonus);
    currentRow.find(".tax").text(realTax);
    currentRow.find(".netPay").text(netPay);

    // ✅ hidden input 반영
    currentRow.find(".bonusField").val(bonus);
    currentRow.find(".taxField").val(realTax);
    currentRow.find(".netPayField").val(netPay);

    // ✅ 보너스 상태 저장
    bonusMap[memberNo] = bonus;

    $("#bonusModal").hide();
  });

  // 모달 열고 초기 데이터 로딩
  function openInsertSalaryModal() {
    $("#insertSalaryModal").css("display", "flex");
    loadAllMembers();
  }
  function closeInsertSalaryModal() {
    $("#insertSalaryModal").hide();
  }

  // 삭제 버튼 기능 (기존 유지)

  $("#delete").click(() => {
    const selectedSalaryNo = $("input[name='salary']:checked").val();
    if (!selectedSalaryNo) {
      alert("삭제할 내용을 선택하세요.");
      return;
    }

    const formData = new FormData();
    formData.append("salaryNo", selectedSalaryNo);

    $.ajax({
      type: "POST",
      url: "/deleteSalary",
      data: formData,
      processData: false,
      contentType: false,
      success: function (result) {
        if (result === "success") {
          alert("삭제되었습니다.");
          location.href = "/newSalary";
        } else {
          alert("삭제 실패");
        }
      }
    });
  });

  // 이중 submit 방지
  $(document).on("click", "#submitBtn", function(e){
	e.preventDefault(); 
    $("#submitBtn").prop("disabled", true);
	
	$.ajax({
	    url: "/insertSalary",
	    type: "POST",
	    data: $("#salaryAllForm").serialize(),
	    success: function(res){
	      alert("등록 완료");
	      closeInsertSalaryModal();
	      location.reload(); // 새로고침
	    },
	    error: function(){
	      alert("등록 실패");
	      $("#submitBtn").prop("disabled", false);
	    }
	  });
	});
  
  
  // 급여 수정 모달 script
  function openEditModal(){ $("#editSalaryModal").css("display","flex"); }
  function closeEditModal(){ $("#editSalaryModal").hide(); }
  $("#closeEditModal, #cancelEdit").on("click", closeEditModal);

  // 수정 버튼 → 선택된 항목 조회 후 모달에 바인딩
  $("#update").off("click").on("click", function(){
    const salaryNo = $("input[name='salary']:checked").val();
    if(!salaryNo){ alert("수정할 급여를 선택하세요."); return; }

    $.get("/getSalary", { salaryNo })
     .done(function(s){
		console.log(s);
        $("#editSalaryNo").val(s.salaryNo);
        $("#editMemberNo").val(s.memberNo);
        $("#editName").val(s.name || "");
        $("#editDeptName").val(s.deptName || "");
        $("#editDeptNo").val(s.deptNo ?? 0);
        $("#editBaseSalary").val(s.baseSalary ?? 0);
        $("#editPositionAllowance").val(s.positionAllowance ?? 0);
        $("#editMealAllowance").val(s.mealAllowance ?? 0);
        $("#editOtRate").val(s.otRate ?? 0);
        $("#editBonus").val(s.bonus ?? 0);
        if(s.effectiveDate){ $("#editEffectiveDate").val(s.effectiveDate); }
        $("#editDescription").val(s.description || "");
        openEditModal();
     })
     .fail(function(){ alert("급여 상세 조회 실패"); });
  });
  

  // 모달 저장
 
  	$(document).on("click", "#editSalaryBtn", function(e){
	console.log("수정버튼 클릭");	
	e.preventDefault();
	console.log($("#editSalaryForm").serialize());
	
	let editBaseSalary = $("#editBaseSalary").val();
	let editPositionAllowance = $("#editPositionAllowance").val();
	let editMealAllowance = $("#editMealAllowance").val();
	let editOtRate = $("#editOtRate").val();
	let editBonus = $("#editBonus").val();
	let editEffectiveDate = $("#editEffectiveDate").val();
	
	if(!editBaseSalary){
		alert("기본급을 입력해주세요.");
		return;
	}
	if(!editPositionAllowance){
		alert("직책수당을 입력해주세요.");
		return;
	}
	if(!editMealAllowance){
		alert("식대를 입력해주세요.");
		return;
	}
	if(!editOtRate){
		alert("초과근무수당을 입력해주세요.");
		return;
	}
	if(!editBonus){
		alert("보너스를 입력해주세요.");
		return;
	}if(!editBonus){
		alert("보너스를 입력해주세요.");
		return;
	}if(!editEffectiveDate){
		alert("젹용 시작일을 입력해주세요.");
		return;
	}
	
	if(parseInt(editBaseSalary) < 0){
		alert("기본급은 최소 0원 이상이어야 합니다.");
		return;
	}if(parseInt(editPositionAllowance) < 0){
		alert("직책수당은 최소 0원 이상이어야 합니다.");
		return;
	}if(parseInt(editOtRate) < 0){
		alert("초과근무 수당은 최소 0원 이상이어야 합니다.");
		return;
	}if(parseInt(editPositionAllowance) < 0){
		alert("직책수당은 최소 0원 이상이어야 합니다.");
		return;
	}if(parseInt(editMealAllowance) < 0){
		alert("식대는 최소 0원 이상이어야 합니다.");
		return;
	}if(parseInt(editBonus) < 0){
		alert("보너스는 최소 0원 이상이어야 합니다.");
		return;
	}

    $.ajax({
      url: "/editSalaryAtNewSalary",
      type: "POST",
      data: $("#editSalaryForm").serialize(),
	  dataType: "text", // 여기가 핵심!
      success: function(res){
        if(res === "success"){ alert("저장되었습니다."); closeEditModal(); location.href = "/newSalary" }
        else if(res === "fail"){ alert("저장 실패"); }
        else { alert(res); }
      },
      error: function(error){
        alert("서버 오류 저장 실패");
      }
    });
  });

</script>

</body>
</html>
