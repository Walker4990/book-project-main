<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>품질 검사 보고서</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/defect.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<section class="defect">
	<div class="box">
  <h1>품질 검사 보고서 검색</h1><br>
  <form action="/allDefect" method="get" class="searchForm">
    <div class="form-inline">
      <select name="select">
        <option value="title">도서명</option>
        <option value="status">품질 상태</option>
      </select>
      <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요" />
	  
      <div class="btn-wrap">
        <input type="submit" value="조회" class="btnNavy" />
        <button type="button" class="btnNavy adminAccess" onclick="openModal()">등록</button>
      </div>
    </div>
  </form>

  <h1>품질 검사 보고서 전체 조회</h1>
  <div class="tableWrapper">
  <table class="table">
	<thead>
    <tr>
      <th>선택</th>
      <th>보고 번호</th>
      <th>도서명</th>
      <th>인쇄 날짜</th>
      <th>품질 상태</th>
      <th>상세 설명</th>
      <th>수량</th>
      <th>단가</th>
      <th>총 가격</th>
      <th>등록 날짜</th>
    </tr>
	</thead>
	
	<tbody>
    <c:forEach items="${defectList}" var="defect">
      <tr>
        <td><input type="radio" name="defect" value="${defect.defectNo}"></td>
        <td>${defect.defectNo}</td>
        <td>${defect.title}</td>
        <td>${defect.printDate}</td>
        <td>${defect.status}</td>
        <td>${defect.content}</td>
        <td>${defect.quantity}</td>
        <td>${defect.price}</td>
        <td>${defect.totalAmount}</td>
        <td>${defect.defectDate}</td>
      </tr>
    </c:forEach>
	</tbody>
  </table>
  </div> 
  
  <div class="bottomBtn">
  <button id="update" type="button" class="update adminAccess" >수정</button>
  <button id="delete" type="button" class="delete adminAccess" >삭제</button>
  </div>
  <nav>
  	  <ul class="pagination">
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

	  <div id="defectModal" class="modal-overlay">
	    <div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">품질 검사 보고 등록</h5>
	      <button class="close-btn" id="closeModal" onclick="closeModal()">✕</button>
		  </div>
		  
		  <form action="/newDefect" method="post" id="defectForm">
		  <div class="modal-body">
			<div class="form-grid">

	        <div class="input">
	          <label class="label" for="bookSelect">도서명</label>
	          <select name="bookNo" id="bookSelect" required>
	            <c:forEach var="book" items="${bookList}">
	              <option value="${book.bookNo}" data-price="${book.price}">${book.title}</option>
	            </c:forEach>
	          </select>
	        </div>

	        <div class="input">
	          <label class="label" for="printDate">인쇄 날짜</label>
	          <input type="date" id="printDate" name="printDate" required>
	        </div>

			<div class="input">
			<label class="label">품질 상태</label>
	        <div class="status-group">
			  <label class="cbox"><input type="checkbox" name="statusList" value="인쇄 불량"><span>인쇄 불량</span></label>
			  <label class="cbox"><input type="checkbox" name="statusList" value="오타"><span>오타</span></label>
			  <label class="cbox"><input type="checkbox" name="statusList" value="찢어짐"><span>찢어짐</span></label>  
	        </div>
			</div>

	        <div class="input">
	          <label class="label">상세 설명</label>
	          <textarea name="content" cols="70" rows="5" placeholder="내용을 입력하세요" required></textarea>
	        </div>

	        <div class="input">
	          <label class="label">수량</label>
	          <input type="number" id="quantity" name="quantity" min="1" required>
	        </div>

	        <div class="input">
	          <label class="label">단가</label>
	          <input type="text" id="price" name="price" readonly>
	        </div>

	        <div class="input">
	          <label class="label">총 가격</label>
	          <input type="number" id="totalAmount" name="totalAmount" readonly>
	        </div>

	        <div class="input">
	          <label class="label">등록 날짜</label>
	          <input type="date" name="defectDate" required>
	        </div>
			
			<div class="input">
			</div>
			</div>
			</div>
			
				<div class="modal-footer">
				          <button type="submit" id="create">등록</button>
				          <button type="button" id="cancel" onclick="closeModal()">취소</button>
				        </div>
				</form>
				</div>
	    </div>
	  <!-- 🟫 모달 영역 끝 -->
	  
	  <!-- 🟫 모달 영역 시작 : 품질 검수 보고 수정 -->
	  	  <div id="editDefectModal" class="modal-overlay">
	  	    <div class="modal-box">
				<div class="modal-header">
					<h5 class="modal-title">품질 검사 보고 수정</h5>
	  	      <button class="close-btn" onclick="closeEditModal()">✕</button>
			  </div>
			  
	  	      <form id="editDefectForm">
			  <div class="modal-body">
					<div class="form-grid">
					
	  	        <div class="inputGroup">
	  	          <label class="label">품질 보고 번호</label>
					<input type="hidden" id="editOrderNo" name="orderNo" readonly/>	
				  <input type="text" id="editDefectNo" name="defectNo" value="${defect.defectNo}" readonly/>
	  	        </div>

	  	        <div class="inputGroup">
	  	          <label class="label">도서명</label>
	  	          <input type="text" id="editTitle" name="title" value="${defect.title}" readonly />
	  	        </div>

	  	        <div class="inputGroup">
	  	          <label class="label">인쇄 날짜</label>
				  <input type="date" id="editPrintDate" name="printDate" value="${defect.printDate}" readonly />
	  	        </div>

	  	        <div class="inputGroup">
					<label class="label">품질 상태</label>
					<div class="status-group" id="editStatusWrap" >
						<input type="hidden" name="status" id="editStatus">
					  <label class="cbox"><input type="checkbox" name="statusList" value="인쇄 불량" ><span>인쇄 불량</span></label>
					  <label class="cbox"><input type="checkbox" name="statusList" value="오타"><span>오타</span></label>
					  <label class="cbox"><input type="checkbox" name="statusList" value="찢어짐"><span>찢어짐</span></label>
					</div>
	  	        </div>

	  	        <div class="inputGroup">
	  	          <label class="label">상세 설명</label>
	  	          <textarea id="editDefectContent" cols="70" name="content" rows="5" required>${defect.content}</textarea>
	  	        </div>
				
				<div class="inputGroup">
				<label class="label">수량</label>
				<input type="number" id="editQuantity" name="quantity" value="${defect.quantity}" min="1" required/>
				</div>

	  	        <div class="inputGroup">
	  	          <label class="label">단가</label>
	  	          <input type="number" id="editPrice" name="price" value="${defect.price}" readonly />
	  	        </div>
				
				<div class="inputGroup">
				<label class="label">총 가격</label>
				<input type="number" id="editTotalAmount" name="totalAmount" value="${defect.totalAmount}" readonly/>
				</div>

	  	        <div class="inputGroup">
	  	          <label class="label">등록 날짜</label>
	  	          <input type="date" id="editDefectDate" name="defectDate" value="${defect.defectDate}">
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
		
		// 숫자 안전 변환 & 합계 재계산(등록/수정 공용)
		function _toNum(v){ return Number(String(v ?? '').replace(/,/g,'')) || 0; }

		// 등록 모달 합계
		function recalcCreateTotal(){
		  const q = _toNum($('#quantity').val());
		  const p = _toNum($('#price').val());
		  $('#totalAmount').val(q * p);
		}

		// 수정 모달 합계
		function recalcEditTotal(){
		  const q = _toNum($('#editQuantity').val());
		  const p = _toNum($('#editPrice').val());
		  $('#editTotalAmount').val(q * p);
		}
		
	    // 모달 열기
	    function openModal() {
	      document.getElementById("defectModal").style.display = "flex";
	    }

	    // 모달 닫기
	    function closeModal() {
	      document.getElementById("defectModal").style.display = "none";
	    }

	    // 등록 시 품질상태 체크 확인
	    $("#defectForm").on("submit", function (e) {
	      const statusChecked = $("#defectForm input[name='statusList']:checked").length > 0;
	      if (!statusChecked) {
	        alert("품질 상태를 최소 한 개 이상 선택해주세요.");
	        e.preventDefault();
	      } else {
	        alert("등록 완료");
	      }
	    });

	    // 도서 선택 시 단가 가져오기
	    function selectBook(bookNo) {
	      $.ajax({
	        url: '/selectBook',
	        type: 'get',
	        data: { bookNo },
			success: function(data) {
			  $('#price').val(data.price);
			  recalcCreateTotal(); // 단가 반영 후 합계 갱신
	        }
	      });
	    }

		selectBook($('#bookSelect').val());
		
		$('#bookSelect').change(function() {
		  selectBook($(this).val());
		  recalcCreateTotal(); // 선택 변경시 한 번 더 안전하게
	    });

		$('#quantity').off('input').on('input', recalcCreateTotal);

	    // 삭제 버튼
	    $("#delete").click(() => {
	      const defectNo = $("input[name='defect']:checked").val();
	      if (!defectNo) {
	        alert("삭제하실 항목을 선택해주세요.");
	        return;
	      }

	      $.ajax({
	        url: "/deleteDefect",
	        type: "post",
	        data: { defectNo },
	        success: function () {
	          alert("삭제되었습니다.");
	          location.href = "/allDefect";
	        },
	        error: function () {
	          alert("삭제에 실패했습니다.");
	        }
	      });
	    });
		
		// 품질 검수 보고 수정 script
		
		// 1. 모달 열닫
		function openEditModal(){$("#editDefectModal").css("display", "flex");}
		function closeEditModal(){$("#editDefectModal").hide();}
		$("#cancelEdit").on("click", closeEditModal);
		
		// 2. 수정 선택한 값 가져오기
		$("#update").off("click").on("click", function() {
		  const defectNo = $("input[name='defect']:checked").val();
		  if (!defectNo) return alert("수정할 품질 보고를 선택해주세요.");

		  $.get("/getDefect", { defectNo })
		    .done(function(d) {
			  $("#editOrderNo").val(d.orderNo);
		      $("#editDefectNo").val(d.defectNo);
		      $("#editTitle").val(d.title || "");
		      $("#editPrintDate").val(d.printDate || "");

		      // 상태 체크박스 세팅
		      $("#editDefectForm input[name='statusList']").prop("checked", false);
		      if (d.status) {
		        d.status.split(",").forEach(v => {
		          $("input[name='statusList'][value='" + v.trim() + "']").prop("checked", true);
		        });
		      }

		      $("#editDefectContent").val(d.content || "");
		      $("#editQuantity").val(d.quantity ?? 0);
		      $("#editPrice").val(d.price ?? 0);
		      $("#editTotalAmount").val(d.totalAmount ?? 0);
		      $("#editDefectDate").val(d.defectDate || "");
			  recalcEditTotal();                                  // 현재 값으로 1회 보정
			  $('#editQuantity').off('input').on('input', recalcEditTotal); // 수량 바뀔 때마다 합계
		      openEditModal();
		    })
		    .fail(function() { alert("보고서 정보 상세 조회 실패"); });
		});
		
		// 3. 수정된 값 저장
		$("#editDefectForm").off("submit").on("submit", function(e){
			e.preventDefault();
			
			const checked = $("#editDefectForm input[name='statusList']:checked")
			                  .map(function(){ return $(this).val(); }).get().join(", ");

			 if (!checked) {
			   alert("품질 상태를 최소 한 개 이상 선택해주세요.");
			   return false;
			 }
			 // 👉 hidden input에 값 세팅
			 $("#editStatus").val(checked);
			 $.ajax({
					url: "/updateDefect",
					type: "POST",
					data: $(this).serialize(),
					success: function(res) {
					if($.trim(res) === "success") {
						alert("저장되었습니다"); 
						closeEditModal();
						 location.reload();}
					  		else if($.trim(res) === "fail") {
								alert("저장 실패")
							}
					  		else {
								alert ("서버 오류 저장 실패")
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