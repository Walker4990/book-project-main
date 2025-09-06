<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>출고 목록</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shipment.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css" />
</head>
<body>
	
	<section class="shipment">
		<div class="box">
			<form class="searchForm" action="/allShipment" method="get">
			    <div class="form-inline">
					<select name="select">
					        <option value="title">도서명</option>
					        <option value="shipment_no">출고번호</option>
					      </select>
			      <input type="text" name="keyword" value="${param.keyword}" placeholder="도서명 또는 발주번호를 입력하세요.">
			      <div class="btn-wrap">
			        <input type="submit" value="조회" class="btnNavy">
			      </div>
			    </div>
			  </form>
			  
   <div class="regShipment">
	<h1>출고 목록</h1>
	
	<div class="btn-wrap">
	<button type="button" class="btnNavy adminAccess" onclick="openModal()">출고 등록</button>
	</div>
	</div>
  
  
  <div class="tableWrapper">
  <table class="table">
    <thead>
      <tr>
		<th>선택</th>
        <th>출고번호</th>
        <th>도서명</th>
        <th>출고수량</th>
        <th>거래처</th>
        <th>배송사</th>
        <th>출고위치</th>
        <th>출고일</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="shipment" items="${shipmentList}">
        <tr>
			<td><input type="radio" name="shipment" value="${shipment.shipmentNo}"></td>
          <td>${shipment.shipmentNo}</td>
          <td>${shipment.bookTitle}</td>
          <td>${shipment.quantity}</td>
          <td>${shipment.partnerName}</td>
		  <td>
		    <c:choose>
		      <c:when test="${empty shipment.deliveryName}">미지정</c:when>
		      <c:otherwise>${shipment.deliveryName}</c:otherwise>
		    </c:choose>
		  </td>
          <td>${shipment.location}</td>
          <td>${shipment.shipmentDate}</td>
         
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
  <div class="bottomBtn">
  <td class="adminAccess">
  		<button type="button" class="btnNavy updateBtn" data-shipment-no="${shipment.shipmentNo}">수정</button> 
  		</td>	
           <td class="adminAccess">
  		<button type="button" class="btnGray deleteBtn" data-shipment-no="${shipment.shipmentNo}">삭제</button>  
	</div>      
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
>${i}</a>
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
  
  <!-- 🟫 모달 영역 시작 : 출고 등록 -->
  	  <div id="shipmentModal" class="modal-overlay">
  	    <div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">출고 등록</h5>
  	      <button class="close-btn" onclick="closeModal()">✕</button>
  	        </div>
			
			<div class="modal-body">
            <form action="/newOutInven" method="post" id="shipmentForm">
				<div class="form-grid">
					
			<div class="row">
			 <button type="button" id="addRow">행 추가</button>
			</div>
			
			<div class="outtableWrapper">
			<table class="table" id="outTable" >
			  <thead>
			    <tr>
			      <th>도서 (재고 기준)</th>
			      <th>출고 수량</th>
			      <th>단가</th>
			      <th>출고 위치</th>
			      <th>거래처</th>
			      <th>운송사</th>
			    </tr>
			  </thead>
			  <tbody>
			    <!-- 기본 1행 -->
			    <tr>
			      <td>
			        <select name="outList[0].inventoryNo" id="inventoryOptions" class="inventoryNo" required>
						<c:forEach var="inven" items="${invenList}">
						  <option value="${inven.inventoryNo}" data-qty="${inven.quantity}">
						    ${inven.bookTitle} / 재고: ${inven.quantity} / 위치: ${inven.location}
						  </option>
						</c:forEach>
			        </select>
			      </td>
			      <td><input type="number" name="outList[0].quantity" class="quantity" min="1" required /></td>
			      <td><input type="number" name="outList[0].price" class="price" min="0" required readonly /></td>
			      <td><input type="text" name="outList[0].location" class="location" value="창고" required /></td>
			      <td>
			        <select name="outList[0].partnerNo" id="partnerOptions" class="partnerNo" required>
			          <c:forEach var="p" items="${partnerList}">
			            <option value="${p.partnerNo}">${p.name}</option>
			          </c:forEach>
			        </select>
			      </td>
			      <td>
			        <select name="outList[0].deliveryNo" id="deliveryOptions" class="deliveryNo" required>
			          <c:forEach var="d" items="${deliveryList}">
			            <option value="${d.deliveryNo}">${d.name}</option>
			          </c:forEach>
			        </select>
			      </td>
			    </tr>
			  </tbody>
			</table>
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

	  <!-- 🟫 모달 영역 시작 : 출고 내용 수정 -->
	  
	  <div id="editShipmentModal" class="modal-overlay">
	    <div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">출고 정보 수정</h5>
	      <span class="close-btn" onclick="closeEditModal()">✕</span>
		  </div>
	    
		  <div class="modal-body">
	      <form id="editShipmentForm">
			<div class="form-grid">	
	        <input type="hidden" name="shipmentNo" id="editShipmentNo"/>
	        <input type="hidden" name="inventoryNo" id="editInventoryNo"/>
	        <input type="hidden" name="bookNo" id="editBookNo"/>

	        <div class="inputGroup">
	          <label>도서명</label>
	          <input type="text" name="bookTitle" id="editBookTitle" required readonly>
	        </div>

	        <div class="inputGroup">
	          <label>현재 위치</label>
	          <input type="text" name="location" id="editLocation" required>
	        </div>

	        <div class="inputGroup">
	          <label>출고 수량</label>
	          <input type="number" name="quantity" id="editQuantity" min="1" required>
			  <input type="hidden" id="editInvenQty" name="invenQty" value="">
	        </div>

	        <div class="inputGroup">
	          <label>출고 단가</label>
	          <input type="number" name="price" id="editPrice" min="0" required readonly>
	        </div>

	        <div class="inputGroup">
	          <label>거래처</label>
	          <select name="partnerNo" id="editPartnerNo">
	            <c:forEach var="p" items="${partnerList}">
	              <option value="${p.partnerNo}">${p.name}</option>
	            </c:forEach>
	          </select>
	        </div>

	        <div class="inputGroup">
	          <label>운송사</label>
	          <select name="deliveryNo" id="editDeliveryNo">
	            <c:forEach var="d" items="${deliveryList}">
	              <option value="${d.deliveryNo}">${d.name}</option>
	            </c:forEach>
	          </select>
	        </div>
			
			</div>
			</div>

	        <div class="modal-footer">
	          <button type="submit" class="btnNavy" id="submitUpdateOutInven">출고 수정</button>
	          <button type="button" class="btnGray" id="cancelUpdateOutInven">취소</button>
	        </div>
	      </form>
	    </div>
	  </div>
	  	  <!-- 🟫 모달 영역 끝 -->
  
  <script>
	function openModal() {
	      document.getElementById("shipmentModal").style.display = "flex";
		  setTimeout(() => {
		     $("#outTable .inventoryNo").each(function(){
		       if ($(this).val()) $(this).trigger("change");
		     });
		   }, 0);
	    }

	    // 모달 닫기
	    function closeModal() {
	      document.getElementById("shipmentModal").style.display = "none";
		  location.reload();
	    }

		let rowCount = 1;

		// ✅ 행 추가
		$("#addRow").click(() => {
		  const newRow = $("<tr>");
			
			
			const inventorySelect = $("<select>")
			  .addClass("inventoryNo")
			  .attr("name", `outList[${rowCount}].inventoryNo`) // ✅ 인덱스 추가
			  .attr("required", true)
			 .html($("#inventoryOptions").html());
			
		
			const partnerSelect = $("<select>")
			  .addClass("partnerNo")
			  .attr("name", `outList[${rowCount}].partnerNo`) // ✅ 인덱스 추가
			  .attr("required", true)
			   .html($("#partnerOptions").html());
			
			

			const deliverySelect = $("<select>")
			  .addClass("deliveryNo")
			  .attr("name", `outList[${rowCount}].deliveryNo`) // ✅ 인덱스 추가
			  .attr("required", true)
			  .html($("#deliveryOptions").html());
			  
			  
	
		  newRow.append($("<td>").append(inventorySelect));
		  newRow.append($("<td>").append(`<input type="number" name="outList[${rowCount}].quantity" class="quantity" min="1" required>`));
		  newRow.append($("<td>").append(`<input type="number" name="outList[${rowCount}].price" class="price" min="0" required readonly>`));
		  newRow.append($("<td>").append(`<input type="text" name="outList[${rowCount}].location" class="location" value="창고" required>`));
		  newRow.append($("<td>").append(partnerSelect));
		  newRow.append($("<td>").append(deliverySelect));
		  newRow.append($("<td>").append(`<button type="button" class="removeRow">삭제</button>`));

		  $("#outTable tbody").append(newRow);
		  newRow.find(".inventoryNo").trigger("change")
		  rowCount++;
		});

		// ✅ 삭제
		$(document).on("click", ".removeRow", function () {
		  $(this).closest("tr").remove();
		});
	
		// ✅ 출고 등록
		$("#shipmentForm").on("submit", function(e){
		  e.preventDefault();
		  
		  let isValid = true;
		  const outList = [];

		  $("#outTable tbody tr").each((i, row) => {
		    const inventoryNo = Number($(row).find(".inventoryNo").val());
		    const quantity = Number($(row).find(".quantity").val());
			const invenQty = Number($(row).find(".inventoryNo option:selected").data('qty'));
		    console.log(`✔️ [${i}] inventoryNo =`, inventoryNo); // 🔍 확인용 로그

		    if (!inventoryNo || inventoryNo === 0) {
		      alert(`[${i + 1}행] 도서를 선택하지 않았습니다.`);
		      isValid = false;
		      return false;
		    }

		    if (!quantity || quantity <= 0) {
		      alert(`[${i + 1}행] 출고 수량이 올바르지 않습니다.`);
		      isValid = false;
		      return false;
		    }
			if(invenQty < quantity) {
				alert("재고량이 부족합니다.")
				isValid =false;
				return false;
			}
			
		    outList.push({
		      inventoryNo: inventoryNo,
		      quantity: quantity,
		      price: Number($(row).find(".price").val()),
		      location: $(row).find(".location").val(),
		      partnerNo: Number($(row).find(".partnerNo").val()),
		      deliveryNo: Number($(row).find(".deliveryNo").val())
		    });
		  });

		  if (!isValid) return;

		  console.log("📦 최종 전송 데이터: ", outList);

		  $.ajax({
		    url: "/newOutInven",
		    method: "POST",
		    contentType: "application/json",
		    data: JSON.stringify(outList),
		    success: function (result) {
		      if (result === "success") {
		        alert("출고 등록 완료");
		        location.reload();
		      } else if (result ==="out_of_stock"){
				alert("재고 수량 부족");
		      } else { 
				 alert("출고 등록 실패");
				 
			}
		    },
		    error: function () {
		      alert("출고 등록 실패 (서버 오류)");
		    }
		  });
		});

		// ✅ 단가 자동 조회
		$(document).on("change", ".inventoryNo", function () {
		  const $row = $(this).closest("tr");
		  const inventoryNo = $(this).val();

		  if (inventoryNo) {
		    $.ajax({
		      url: "/getBookPrice",
		      method: "GET",
		      data: { inventoryNo },
		      success: function (price) {
		        if (price != null) {
		          $row.find(".price").val(price);
		        } else {
		          $row.find(".price").val("");
		          alert("단가 정보를 가져올 수 없습니다.");
		        }
		      },
		      error: function () {
		        alert("단가 조회 실패 (서버 오류)");
		      }
		    });
		  }
		});
	
	// 같은 이벤트 발생인데 -> 선택 버튼 없이 항목이 추가되서 생긴 버튼에도 작동
	$(document).on("click",".deleteBtn", function(){
		const shipmentNo = $("input[name='shipment']:checked").val();
		if (!shipmentNo) {
		  alert("삭제할 출고를 선택하세요.");
		  return;
		}
		if(confirm("정말 삭제하시겠습니까?")){
		  location.href = "/deleteShipment?shipmentNo=" + shipmentNo;
		}
	});
	
	// 출고 정보 수정 모달 Script
	function openEditModal(){ $("#editShipmentModal").css("display","flex"); }
	function closeEditModal(){ $("#editShipmentModal").hide(); }
	$("#cancelUpdateOutInven").on("click", closeEditModal);
	
		$(document).on("click",".updateBtn", function(){
		  const shipmentNo = $("input[name='shipment']:checked").val();
		  console.log("선택한 출고번호:", shipmentNo);
		  if(!shipmentNo){
			alert("수정할 항목을 선택하세요.");
			return;
		  }		
	

		  $.get("/getShipment", { shipmentNo })
		   .done(function(s){
			console.log("조회 응답:", s);
		     $("#editShipmentNo").val(s.shipmentNo);
		     $("#editInventoryNo").val(s.inventoryNo);
		     $("#editBookNo").val(s.bookNo);
		     $("#editBookTitle").val(s.bookTitle || "");
		     $("#editLocation").val(s.location || "");
		     $("#editQuantity").val(s.quantity ?? 0);
		     $("#editPrice").val(s.price ?? 0);
		     $("#editPartnerNo").val(s.partnerNo ?? "");
		     $("#editDeliveryNo").val(s.deliveryNo ?? "");
			 $("#editInvenQty").val(s.invenQty);
		     openEditModal();
		   })
		   .fail(()=> alert("출고 정보 상세 조회 실패"));
		});
	
		// ✅ 출고 내용 수정 저장 — bulk 엔드포인트로 1건짜리 배열(JSON) 전송
		$("#editShipmentForm").on("submit", function(e){
		  e.preventDefault();

		  const qty = Number($("#editQuantity").val());
		  const invenQty = Number($("#editInvenQty").val());
		  if (qty <= 0) { alert("출고 수량은 1개 이상이어야 합니다."); return; }
		  if (invenQty && qty > invenQty) { alert(`재고(${invenQty})보다 많은 수량(${qty})으로 수정할 수 없습니다.`); return; }

		  // 👇 네가 쓰는 필드/ID/키 그대로
		  const dto = {
		    shipmentNo: Number($("#editShipmentNo").val()),
		    inventoryNo: Number($("#editInventoryNo").val()),
		    bookNo: Number($("#editBookNo").val()),
		    location: $("#editLocation").val(),
		    quantity: Number($("#editQuantity").val()),
		    price: Number($("#editPrice").val()),
		    partnerNo: Number($("#editPartnerNo").val()),
		    deliveryNo: Number($("#editDeliveryNo").val())
		  };

		  $.ajax({
		    url: "/updateOutInven/bulk",
		    type: "POST",
		    contentType: "application/json; charset=utf-8",
		    data: JSON.stringify([dto]),   // ← 1건도 배열로 보냄(List<ShipmentDTO> 바인딩)
		    success: function(res) {
		      if(res === "success"){ alert("저장되었습니다."); closeEditModal(); location.reload(); }
		      else if(res === "out_of_stock"){ alert("재고 수량 부족으로 수정할 수 없습니다."); }
		      else if(res === "notFound"){ alert("기존 출고 내역을 찾을 수 없습니다."); }
		      else { alert("저장 실패: " + res); }
		    },
		    error: function(){ alert("서버 오류 저장 실패"); }
		  });
		});

  </script>
</body>
</html>