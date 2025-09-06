<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>납부한 세금 목록</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tax.css" />
</head>
<body>
	
  <section class="tax">
	<div class="box">
  <h1>납부한 세금 목록</h1><br>
  
  <form method="get" action="/taxPaidList" class="mb-4">
	
	<div class="input">
  	<label class="label" for="month">월별 조회</label>
	</div>
	
	<div class="form-inline-tax">
		
	<div class="input">
  	<input type="month" name="month" value="${selectedMonth}">
	</div>
	
	<div class="btn-wrap-tax">
  	<button type ="submit" class="btnNavy btn-sm btn-primary">조회</button>
	<button type="button" id="createBtn" class="btnNavy adminAccess">납부 등록</button>
	</div>
	</div>
  	</form>
	
	
	<div class="tableWrapper">
  <table class="table">
    <thead>
      <tr>
        <th>세금 번호</th>
        <th>카테고리</th>
        <th>세액</th>
        <th>납부 금액</th>
        <th>납부일</th>
        <th>납부 방법</th>
		<th>납부 상태</th>
        <th>비고</th>
      </tr> 
    </thead>
    <tbody>
      <c:forEach var="tp" items="${taxList}">
        <tr>
          <td>${tp.taxNo}</td>
          <td>${tp.category}</td>
          <td>${tp.taxAmount}</td>
          <td>${tp.amount}</td>
          <td>${tp.paymentDate}</td>
          <td>${tp.paymentMethod}</td>
		  <td>${tp.status}</td>
		  <td>${tp.description}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
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
		</form>
		</section>
		
		
		<div id="insertTaxPaymentModal" class="modal-overlay" >
				<div class="modal-box">
					
				<div class="modal-header">
				 <h5 class="modal-title">납부 등록</h5>
				 <button class="close-btn" id="budgetCloseX">✕</button>
				</div>
				 
				<div class="modal-body">
				 <form id="insertTax">
					<div class="form-grid">
						
				<div class="input">
				<div class="mb-3">
					        <label class="label">세금 선택</label>
					        <select id="taxNo" name="taxNo" class="form-select" required>
					          <option value="">세금 선택</option>
					          <c:forEach var="tax" items="${unpaidTaxes}">
					           <option
					              value="${tax.taxNo}"
					              data-amount="${tax.remainingAmount}"
					              data-taxdate="${tax.taxDate}"
					            >
					              ${tax.category} - 남은 금액: ${tax.remainingAmount}원 (총 세액:
					              ${tax.taxAmount}원, ${tax.taxDate})
					           </option>
					        </c:forEach>
					     </select>
					 </div>
				</div>
			<div class="input">
				<label class="label">납부 금액</label>
				 <input
				   type="number"
				   id="amount"
				   name="amount"
				   class="form-control"
				   value="${tax.taxAmount}"
				   required
				 />		
				 <input
				 type="hidden"
				 id="getAmount"
				 name="getAmount"
				 class="form-control"
				 value="${tax.taxAmount}"
				 required
				 />	
				
			</div>
			<div class="input">
			<label class="label">납부일</label>
			<input type="date" name="paymentDate" class="form-control" required />			
			</div>
			
			<div class="input">
				<label class="label">납부 방법</label>
				 <select name="paymentMethod" class="form-control">
				    <option>카드</option>
				    <option>계좌이체</option>
				    <option>현금</option>
				    <option>기타</option>
				 </select>		
			</div>

			<div class="input">
				<label class="label">비고</label>
				<textarea name="description" class="form-control"></textarea>						
			</div>
			
			<div class="input">			
			</div>
			</div>
			</div>
			
				<div class="modal-footer">
				<button type="submit" id="submitTax" class="btn btnPrimary">확인</button>
				<button type="button" id="closeSubmitTax" class="btn btnPrimary">취소</button>		
				</div>
				
				</form>
				</div>
				</div>
		
		
		<script>
			$("#createBtn").click(()=>{
				$("#insertTaxPaymentModal").show();
			})
			$("#closeSubmitTax").click(()=>{
				$("#insertTaxPaymentModal").hide();
			})
			$(".close-btn").click(() =>{
				$("#insertTaxPaymentModal").hide();
			})
			
			
		     $("#taxNo").on("change", function () {
		       let amount = $(this).find("option:selected").data("amount");
		       console.log("선택된 금액:", amount); // 디버그
		       $("#amount").val(amount || "");
		     });

		     $("#submitTax").click((e) => {
		       e.preventDefault();
		       const formData = $("#insertTax").serialize();
		       // 개별 필드 값 확인
		       const taxNo = $("#taxNo").val();
		       const amount = $("#amount").val();
		       const paymentDate = $("input[name='paymentDate']").val();
		       const paymentMethod = $("select[name='paymentMethod']").val();
		       const taxDate = $("#taxNo option:selected").data("taxdate");
		       console.log(paymentDate);
		       console.log(taxDate);
		       // 필수값 확인 (비었으면 return)
		       if (!taxNo) {
		         alert("세금을 선택해주세요.");
		         return;
		       }

		       if (!amount || parseInt(amount) <= 0) {
		         alert("납부 금액을 정확히 입력해주세요.");
		         return;
		       }

		       if (!paymentDate) {
		         alert("납부일을 입력해주세요.");
		         return;
		       }

		       if (!paymentMethod) {
		         alert("납부 방법을 선택해주세요.");
		         return;
		       }

		       if (taxDate && paymentDate) {
		         const taxDateObj = new Date(taxDate);
		         const paymentDateObj = new Date(paymentDate);

		         if (paymentDateObj < taxDateObj) {
		           alert("납부일은 세금 발생일 이후여야 합니다.");
		           return;
		         }
		       }

		       $.ajax({
		         url: "/insertTaxPayment", // ← 여기에 실제 전송할 URL을 입력
		         method: "POST",
		         data: formData,
		         success: function (result) {
		           if (result == "success") {
		             alert("세금 납부 등록이 완료되었습니다.");
		             location.href = "/taxPaidList";
		           } else if (result == "fail") {
		             alert("세금 등록 실패");
		           } else if (result == "overfullAmount") {
		             alert("납부할 금액이 초과되었습니다.");
		           }
		         },
		         error: function (xhr, status, error) {
		           alert("에러 발생: " + error);
		           console.log(error);
		         },
		       });
		     });
		   </script>							
													
</body>
</html>