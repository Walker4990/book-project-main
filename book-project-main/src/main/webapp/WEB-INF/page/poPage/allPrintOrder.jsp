<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/po.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	
	<section class="printOrder">
		<div class="box">
    <h1>발주서 조회/수정</h1><br>
	
		<form class="searchForm" action="/allPrintOrder" method="get">
		<div class="form-inline">
				
		<input type="text" name="keyword" value="${param.keyword}" placeholder="제품명 또는 발주 번호를 입력하세요.">
		
		<div class="btn-wrap">
		<button type="submit" value="조회" class="btnNavy">조회</button>
		<button type="button" class="btnNavy" onclick="openModal()">발주 등록</button>
		</div>
		</div>
		</form>
		
		<div class="tableWrap">	
		<table class="table">
		  <thead>
		    <tr>
			<th>선택</th>
		    <th>발주일자</th>
		    <th>담당자</th>
		    <th>납품일자</th>
		    <th>발행일자</th>
		    <th>구분</th>
			<th>배송상태</th>
		    </tr>
		  </thead>
		  <tbody>
			<c:forEach var="printOrder" items="${list}">
			  <tr class="order-summary">
				<td>
				 <input type="radio" name="orderNo" value="${printOrder.orderNo}" />
				    </td>
			    <td>${printOrder.orderDate}</td>
			    <td>${printOrder.manager}</td>
			    <td>${printOrder.deliveryDate}</td>
			    <td>${printOrder.issueDate}</td>
			    <td>${printOrder.category}</td>
				<td>
					<c:if test="${printOrder.status ne '배송 완료'}">
					<button type="button" onclick="openDeliveryModal('${printOrder.orderNo}', '${printOrder.status}')">
					  ${printOrder.status}
					</button>
					</c:if>
					<c:if test="${printOrder.status eq '배송 완료'}">
					   ${printOrder.status}
					 </c:if>
				</td>
			  </tr>
			  
			  <tr class="order-details" style="display: none;">
			    <td colspan="7" class="details-cell">
			      <table class="table" width="100%">
			        <thead>
			          <tr>
			            <th>제품명</th>
			            <th>정가</th>
			            <th>수량</th>
			            <th>홍보부수</th>
			          </tr>
			        </thead>
			        <tbody>
			          <c:forEach var="detail" items="${printOrder.detailList}">
			            <tr>
			              <td>${detail.productName}</td>
			              <td>${detail.regularPrice}</td>
			              <td>${detail.quantity}</td>
			              <td>${detail.promotionQuantity}</td>
			            </tr>
			          </c:forEach>
			        </tbody>
			      </table>
			    </td>
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
	        
	
			</section>
			
			<div id="deliveryModal" class="modal-overlay">
			  <div class="modal-box">
				<div class="modal-header">
					<h5 class="modal-title">배송 상태 변경</h5>
			    <button class="close-btn" onclick="closeDeliveryModal()">✕</button>
			   </div>
			   
			   <div class="modal-body">
			    <form id="statusForm">
			      <input type="hidden" id="orderNo" name="orderNo" value="">

				  <div class="input">
			      <label class="label" for="status">배송 상태</label>
			      <select id="status" name="status">
			        <option value="배송 전">배송 전</option>
			        <option value="배송 중">배송 중</option>
			        <option value="배송 완료">배송 완료</option>
			      </select>
				  </div>
				  </div>

				  <div class="modal-footer">
			      <button type="button" onclick="updateStatus()">변경하기</button>
				  </div>
			    </form>
			  </div>
			</div>

				<!-- 🟫 모달 영역 시작 -->
		<div id="poModal" class="modal-overlay">
		 <div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">신규 발주서 등록</h5>
		 <button class="close-btn" onclick="closeModal()">✕</button>
		 </div>
		 
		 <div class="modal-body">
		   <form id="poForm">
			<div class="form-grid">	
			
			<div class="input">
			<label class="label">발주 일자</label>
			<input type="date" id="orderDate" name="orderDate" required/>
			</div>
			
			<div class="input">
			<label class="label">담당자</label>
			<input type="text" id="manager" name="manager" placeholder="담당자 이름" required/>
			</div>
			
			<div class="input">
			<label class="label">납품 일자</label>
			<input type="date" id="deliveryDate" name="deliveryDate" required/>
			</div>
			
			<div class="input">
			<label class="label">발행 일자</label>
			<input type="date" id="issueDate" name="issueDate" required/>
			</div>
						
			<div class="input">
			<label class="label">구분</label>
			<select id="category" name="category" required>
			<option>도서</option>
			<option>비도서</option>
			</select>
			</div>	

			<div class="row">
			<button type="button" id="addRow">행 추가</button>	
			</div>
				      
			<table class="table" id="poTable">
			<thead>
			<tr>
			<th>도서명</th>
			<th>정가</th>
			<th>수량</th>
			<th>총 금액</th>
			<th>홍보 부 수</th>
			
			</tr>
			</thead>
			
			<tbody id="detailBody">
			<tr>
			<td>
			<select class="bookSelect" name="detailList[0].bookNo" required>
			<option value="" selected>-- 선택 --</option>
			<c:forEach var="book" items="${bookList}">
			<option value="${book.bookNo}" data-price="${book.price}">${book.title}</option>
			</c:forEach>
			</select>
			</td>
			<td><input type="number" class="regularPrice"  required readonly/></td>
			<td><input type="number" class="quantity" required /></td>
			<td><input type="number" class="totalAmount" readonly></td>
			<td><input type="number" class="promotionQuantity" /></td>
			
			</tr>
			</tbody>
			</table>
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
			
			<!-- 🟫 모달 영역 시작 : 발주서 수정 -->
			<div id="editPoModal" class="modal-overlay">
			<div class="modal-box">
				<div class="modal-header">
				<h5 class="modal-title">발주서 수정</h5>
				<button class="close-btn" onclick="closeEditModal()">✕</button>
				</div>
				
				<div class="modal-body">
				<form id="editPoForm">
				<div class="form-grid">	
				
			    <div class="inputGroup">
				<input type="hidden" name="orderNo" value="${po.orderNo}" id="editOrderNo" required/>
				<label class="label">도서명</label>
				<select id ="editProductName" name='productName' value='${detail.productName}'>
					<c:forEach var="detail" items="${printOrder.detailList}">
						<option>${detail.productName}</option>
						</c:forEach>
				</select>
				</div>
			
				<div class="inputGroup">
				<label class="label">발주 수량</label>
				<input type="number" name="quantity" min="0" id="editQuantity" required/>
				</div>
						
				<div class="inputGroup">
				<label class="label">홍보 수량</label>
				<input type="number" name="promotionQuantity"  min="0" id="editPromotionQuantity" required/>
				</div>
						
				<div class="inputGroup">
				<label class="label">담당자</label>
				<input type="text" name="manager" value="${po.manager}" id="editManager" required/>
				</div>
									
				<div class="inputGroup">
				<label class="label">발행 일자</label>
				<input type="date" name="issueDate" value="${po.issueDate}" id="editIssueDate" required/>
				</div>
				
				<div class="inputGroup">
				<label class="label">납품 일자</label>
				<input type="date" name="deliveryDate" value="${po.deliveryDate}" id="editDeliveryDate" required/>
				</div>
				<input type="hidden" name="orderDate" value="${po.orderDate}" id="editOrderDate" required/>	
				<input type="hidden" name="bookNo" id="editBookNo" required/>
				<input type="hidden" name="detailNo" id="editDetailNo" required/>
				<input type="hidden" name="orderNo" value="${po.orderNo}" id="editOrderNo" required/>
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
			let printOrder;
			let updateDetailList = [];
			let selectedItem;
			
			var $select = $("#bookSelect");
		// select 요소에 change 이벤트 리스너 달기
		$select.on('change', function() {
			   const selectedIndex = $(this).val();  // 선택된 option의 value를 가져옴 (인덱스)
			   const selectedItem = updateDetailList[selectedIndex];  // 배열에서 해당 아이템 찾기

			    // input 값 변경
			    $("#editQuantity").val(selectedItem.quantity);
			    $("#editPromotionQuantity").val(selectedItem.promotionQuantity);
			    // 필요하면 다른 input들도 변경 가능
			});	
			
			$(document).on('change', '#editProductName', function() {
			    const selectedIndex = $(this).val();
			    selectedItem = updateDetailList[selectedIndex];

			    if (!selectedItem) return;

			    $("#editQuantity").val(selectedItem.quantity);
			    $("#editPromotionQuantity").val(selectedItem.promotionQuantity);
			    $("#editBookNo").val(selectedItem.bookNo);
			    $("#editDetailNo").val(selectedItem.detailNo);
			});
			
			
			
			// 배송상태 모달 열기
		function openDeliveryModal(orderNo, currentStatus){
			$("#deliveryModal").css("display", "block");
			$("#orderNo").val(orderNo);
			$("#status").val(currentStatus);
		}
		function closeDeliveryModal(){
			$("#deliveryModal").css("display", "none");
			
		}
		function updateStatus(){
			const orderNo = $("#orderNo").val();
			const status = $("#status").val();
			
			$.ajax({
				url:"/updateDeliveryStatus",
				type:"POST",
				data:{ orderNo: orderNo, status: status},
				success: function(res){
					if(res==="success"){
						alert("상태 변경 완료")
						location.reload();
					} else {
						alert("상태 변경 실패");
					}
				},
				error: function(){
					alert("에러 발생");
				}
			});
		}
		
		// 모달 열기
		    function openModal() {
		      document.getElementById("poModal").style.display = "flex";
		    }

		    // 모달 닫기
		    function closeModal() {
				
				
		      document.getElementById("poModal").style.display = "none";
		    }
		
		$(document).on("click", ".order-summary", function (e) {
			if($(e.target).is("input[type=radio]"))
			{
				return;
			}
			
		  const detailRow = $(this).next(".order-details");
		  detailRow.toggle();
		});
		 
		
		$("#delete").click(() => {
			const orderNo = $("input[name='orderNo']:checked").val();
				if (!orderNo) {
				      alert("삭제할 계약을 선택해주세요.");
				     return;
				   }
		$.ajax({
			type:"POST",
			url:"/deletePrintOrder",
			data: {
			orderNo: orderNo
			},
			dataType: "text",
			success: function(result) {
				if (result=="success"){
					alert("삭제완료");
					location.href = "/allPrintOrder"
				} else alert("삭제 실패")
						}
				});
						
			});
					
					const bookMap = {
							  <c:forEach var="book" items="${bookList}" varStatus="vs">
							    "${book.bookNo}": ${book.price}<c:if test="${!vs.last}">,</c:if>
							  </c:forEach>
							};
						  // 행 추가 버튼 클릭 시
						  $("#addRow").click(() => {
							const newRow = `
							  <tr>
							    <td>
							      <select class="bookSelect" required>
							        ` + $("#detailBody select.bookSelect:first").html() + `
							      </select>
							    </td>
							    <td><input type="number" class="regularPrice" required /></td>
							    <td><input type="number" class="quantity" required/></td>
								<td><input type="number" class="totalAmount" readonly/></td>
							    <td><input type="number" class="promotionQuantity" required /></td>
							    <td><button type="button" class="delRow">삭제</button></td>
							  </tr>`;
							  // 추가 항목들 추가된 행에 추가
						    $("#detailBody").append(newRow);
						  });

						  // 삭제 버튼 클릭 시 해당 행 제거
						  //$(부모요소).on("이벤트", "대상선택자", function() { ... });
						  $(document).on("click", ".delRow", function () {
							const rowCount = $("#detailBody tr").length;
							 if (rowCount > 1) {
							   $(this).closest("tr").remove();
							 } else {
							   alert("최소 1개의 발주 항목은 유지해야 합니다.");
							 }
						  });
						
						  //정가 입력
						  $(document).on("change",".bookSelect", function(){
							const bookNo = $(this).val();
							  const price = bookMap[bookNo] || 0;
							  const row = $(this).closest("tr");
							  row.find(".regularPrice").val(price).trigger("input");
							  
						  })
						  
						  //$(document) - HTML 전체문서 , 동적으로 추가된 요소에도 이벤트 바인딩 가능
						  // $(this) - 현재 이벤트(클릭)에만 동작하기 위해 사용
						  
						  // 취소 버튼
						  $("#cancel").click(() => {
						    location.href = "/allPrintOrder";
						  });

						  // 등록 버튼
						  $("#create").click(() => {
						    let isValid = true;
							
							let allValid = true;
							$("#poForm").find("input:required, select:required").each(function () {
							  if (!this.checkValidity()) {
							    this.reportValidity(); // 브라우저 기본 오류 표시
							    allValid = false;
							    return false; // break
							  }
							});
							if (!allValid) return;
						    // 수량 유효성 검사
						    $("#poForm .quantity").each(function () {
						      if (parseInt($(this).val()) < 0) {
						        alert("수량은 0 이상이어야 합니다.");
						        isValid = false;
						        return false;
						      }
						    });

						    // 홍보 부수 유효성 검사
						    $("#poForm .promotionQuantity").each(function () {
						      if (parseInt($(this).val()) < 0) {
						        alert("홍보 부수는 0 이상이어야 합니다.");
						        isValid = false;
						        return false;
						      }
						    });

						    if (!isValid) return; // 유효성 실패 시 AJAX 중단

						    const data = {
						      orderDate: $("#orderDate").val(),
						      manager: $("#manager").val(),
						      deliveryDate: $("#deliveryDate").val(),
						      issueDate: $("#issueDate").val(),
						      category: $("#category").val(),
						      detailList: []
						    };
							
							const { orderDate, deliveryDate, issueDate } = data;
							
							if(orderDate && deliveryDate && orderDate > deliveryDate){
								alert("발주일을 납품일자보다 빨라야합니다.")
								return;
							}
							if (deliveryDate && issueDate && issueDate > deliveryDate) {
							  alert("발행일은 납품일보다 빠르거나 같아야 합니다.");
							  return;
							}
							if(orderDate && issueDate && orderDate > issueDate){
								alert("발주일은 발행일보다 빨라야합니다.")
								return;
							}
							

						    //$("selector").each() -> jQuery 반복문
						    // $(selector).each(function(index, element) {
						    // index: 현재 순서 (0부터 시작)
						    // element: 현재 순회 중인 요소 (DOM 객체)
						    // 여기서 row는 <tr> 요소 하나, index는 그 순번
						    $("#detailBody tr").each((_, row) => {
								
						      const detail = {
						        bookNo: $(row).find(".bookSelect").val(),
								productName: $(row).find(".bookSelect option:selected").text(),
						        regularPrice: $(row).find(".regularPrice").val(),
						        quantity: $(row).find(".quantity").val(),
						        promotionQuantity: $(row).find(".promotionQuantity").val()
						      };
						      data.detailList.push(detail);
						    });
						    // $(row) -

						    $.ajax({
						      type: "POST",
						      url: "/newPrintOrder",
						      contentType: "application/json", // JSON 전송 명시
						      data: JSON.stringify(data), // JS 객체 → JSON 문자열
							  success: function (result) {
							    if ($.trim(result) === "success") {
						          alert("발주 등록 완료");
						          location.href = "/allPrintOrder";
							   } else {
							      alert("등록 실패");
							    }
							  },
						      error: function () {
						        alert("서버 오류 발생");
						      }
						    });
						  });
						  // 정가, 수량 입력 시 총 금액 자동 계산
						  $(document).on("input", ".regularPrice, .quantity", function () {
						    const row = $(this).closest("tr");
						    const price = parseInt(row.find(".regularPrice").val()) || 0;
						    const quantity = parseInt(row.find(".quantity").val()) || 0;
						    row.find(".totalAmount").val(price * quantity);
						  });
						  
		// 발주서 수정 모달 script
		function openEditModal(){
			$("#editPoModal").css("display", "flex");
		}
		function closeEditModal(){
			$("#editPoModal").hide();
			
		}
		$("#cancelEdit").on("click", closeEditModal);
		
		
		$("#update").click(function (){
			let orderNo = $("input[name='orderNo']:checked").val();
			 if (!orderNo) {
			   alert("수정할 발주서를 선택해주세요.");
			   return;
			 }
			 let $select = $("#editProductName");
			 $select.empty();
			$.get("getPrintOrder", {orderNo})
			.done(function(o){
				printOrder = o;
				console.log(o);
				$("#editOrderNo").val(o.orderNo);
				$("#editManager").val(o.manager || "");
				$("#editIssueDate").val(o.issueDate || "");
				$("#editDeliveryDate").val(o.deliveryDate || "");
				$("#editOrderDate").val(o.orderDate || "");
				updateDetailList = o.detailList;
				if(o.detailList != null)
				{
					// 2. 옵션 추가
					   updateDetailList.forEach((item,index) => {
					       $select.append(
					           $("<option>", {
					               value: index,
					               text: item.productName,
								   "data-product-name": item.productName
					           })
					       );
					});
				
					// 첫 번째 항목을 선택하고 input 값 세팅
					  const firstIndex = 0;
				$("#editQuantity").val(updateDetailList[firstIndex].quantity);
				$("#editPromotionQuantity").val(updateDetailList[firstIndex].promotionQuantity);
				$("#editBookNo").val(updateDetailList[firstIndex].bookNo);
				$("#editDetailNo").val(updateDetailList[firstIndex].detailNo);
				console.log(updateDetailList);
				openEditModal();
				}
				else{
					console.log("o값이 비었습니다.")
				}
			})
			.fail(() => alert("발주 정보 상세 조회 실패"));
		});
					
		// 수정 값 저장
		$("#editPoForm").on("submit", function(e){
			e.preventDefault();
			 const  orderNo =  $("#editOrderNo").val();
			 const orderDate =  $("#editOrderDate").val();
			 const issueDate =  $("#editIssueDate").val();
			 const  deliveryDate =  $("#editDeliveryDate").val();
			 const  manager =  $("#editManager").val();
			 const  category =  $("#editCategory").val();
			 const detailList =  [
			 {
				productName : $("#editProductName option:selected").data("product-name"),
				quantity: $("#editQuantity").val(),
				promotionQuantity: $("#editPromotionQuantity").val(),
			  	bookNo : $("#editBookNo").val(),
			 	detailNo : $("#editDetailNo").val()
			 }];
			 
			 if($("#editProductName").val() == null)
			 {
				alert("도서를 선택해주세요.");
				return;
			 }
			 if( $("#editQuantity").val() == null)
			 {
			 	alert("발주 수량을 입력해주세요.");
			 	return;
			 }
			 if(parseInt($("#editQuantity").val()) <0)
			 {
				alert("발주 수량은 0개 이상이여야 합니다.");
				return;
			 }
			 if(parseInt($("#editPromotionQuantity").val()) <0)
			 {
			 		alert("홍보 수량은 0개 이상이여야 합니다.");
			 		return;
			 } 
			 if($("#editPromotionQuantity").val() == null)
			 {
			 	alert("홍보 수량을 입력해주세요.");
			 	return;
			 }
			 
			 
			 
			 
			const data = {
				orderNo,
				orderDate,
				issueDate,
				deliveryDate,
				manager,
				category,
				detailList
			}
			
			$.ajax({
				url: "/updatePrintOrder",
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify(data),
				success: function(res) {
					if(res === "success") {alert("저장되었습니다."); closeEditModal(); location.reload();}
					else if(res === "fail") {alert("저장 실패")}
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
