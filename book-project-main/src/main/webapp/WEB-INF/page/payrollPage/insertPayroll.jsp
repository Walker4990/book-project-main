<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>전직원 급여 일괄 지급</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/financial.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  
</head>
<body>
	
  <section class="payroll">
	<div class="box">
  <h2>전직원 급여 일괄 지급</h2><br>
  
  <c:if test="${alreadyPaid}">
      <div style="color:red; font-weight:bold;">
          이미 이번 달 급여가 지급되어 등록이 불가능합니다.
      </div>
  </c:if>
  
    <div class="input">
    <label class="label">지급일자</label>
    <input type="date" name="salaryDate" id="salaryDate" required />
	</div>

	
    <table class="table" id="table">
      <thead>
        <tr>
          <th>선택</th>
          <th>사번</th>
          <th>이름</th>
          <th>총급여</th>
		  <th>급여 등록일</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="s" items="${salaryList}">
          <tr>
            <td>
              <input type="checkbox" name="salaryNoList" class="chk" value="${s.salaryNo}" checked />
			  <input type="hidden" class="memberNo" value="${s.memberNo}" />
			  <input type="hidden" class="totalSalary" value="${s.totalSalary}" />
            </td>
            <td class="memberNo">${s.memberNo}</td>
            <td>${s.name}</td>
            <td class="totalSalary">${s.totalSalary}</td>
			<td class="effectiveDate">${s.effectiveDate}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <br/>
  
	<div class="bottomBtn">
  <button type="button" id="payBtn" class="btnNavy adminAccess" 
  <c:if test="${alreadyPaid}">disabled</c:if>>일괄 지급</button>
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
  
</body>
</html>
	 
	  <script>
		$("#payBtn").click(() => {
		    const salaryDate = $("#salaryDate").val();
		    if (!salaryDate) {
		        alert("지급일자를 선택하세요.");
		        return;
		    }

		    const data = [];

		    $("#table tbody tr").each((_, row) => {
		        const $chk = $(row).find("input.chk"); // 체크박스 잡기
		        if ($chk.is(":checked")) {
		            const payroll = {
		                memberNo: parseInt($(row).find(".memberNo").text()) || 0,
		                salaryNo: parseInt($chk.val()) || 0, // 체크박스 value에서 salaryNo 추출
		                salaryDate: salaryDate,
		                payAmount: parseInt($(row).find(".totalSalary").text().replace(/,/g, "")) || 0
		            };
		            data.push(payroll);
		        }
		    });

		    if (data.length === 0) {
		        alert("선택된 사원이 없습니다.");
		        return;
		    }

		    $.ajax({
		        url: "/insertPayroll",
		        method: "POST",
		        contentType: "application/json",
		        data: JSON.stringify(data),
		        success: function (msg) {
		            alert(msg);
		            if (msg.includes("정상 지급")) {
		                location.href = "/main";
		            }
		        },
		        error: function (err) {
		            alert("에러 발생");
		            console.error(err);
		        }
		    });
		});
	</script>
	 
</body>

</html>	