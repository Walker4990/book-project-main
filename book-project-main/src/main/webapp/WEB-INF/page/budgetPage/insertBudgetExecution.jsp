<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예산 집행 등록</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body class="p-4">

<h2>예산 집행 등록</h2>



<form action="/insertBudgetExecution" method="post" class="mt-3" id="InsertBudgetExecution">
    <div class="mb-3">
        <label class="form-label">예산 선택</label>
        <select id="budgetNo" name="budgetNo" class="form-select" required>
            <option value="">예산 선택</option>
            <c:forEach var="b" items="${budgetList}">
                <option value="${b.budgetNo}" data-remaining="${b.remainingAmount}">
                    ${b.deptName} - ${b.budgetMonth} (남은 예산: ${b.remainingAmount}원)
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label">집행 날짜</label>
        <input type="date" id="execDate" name="execDate" class="form-control" required>
    </div>

    <div class="mb-3">
        <label class="form-label">집행 금액</label>
        <input type="number" id="amount" name="amount" class="form-control" min="0" required>
    </div>

    <div class="mb-3">
        <label class="form-label">사용 사유</label>
        <textarea name="description" id="description" class="form-control"></textarea>
    </div>

    <button type="button" id="submitInsertBudgetExecution" class="btn btn-primary">등록</button>
    <a href="/allBudgetPlan" class="btn btn-secondary">목록</a>
</form>

<script>
$("#budgetNo").on('change', function(){
    let remaining = $(this).find('option:selected').data('remaining');
    if(remaining !== undefined) {
        $("#amount").attr("max", remaining);
    }
});

$('#submitInsertBudgetExecution').click((e)=>{
	e.preventDefault();
	const formData = $("#InsertBudgetExecution").serialize(); 
	const execDate = $("#execDate").val();
	const amount = $("#amount").val();
	const description = $("#description").val();
	
	if(!execDate && !amount && !description)
	{
		alert("내용을 작성해주세요.");
		return;
	}
	if(!execDate)
	{
		alert("날짜를 작성해주세요.");
		return;
	}
	if(!amount)
	{
		alert("집행금액을 작성해주세요.");
		return;
	}
	if(!description)
	{
		alert("사유를 작성해주세요.");
		return;
	}
	if(parseInt(amount) < 0)
	{
		alert("집행 금액은 0원 이상이여야 합니다.");
		return;
	}
	
	$.ajax({
		url: "/insertBudgetExecution",
		type: "POST",
		data: formData,
		success: function(result)
		{
			if(result == "success")
			{
				alert("등록이 완료하였습니다.");
				location.href = "/allBudgetPlan";
			}
			if(result == "failDate")
			{
				alert("예산 등록일 이후 부터 가능합니다.");
			}
			if(result == "failAmount")
			{
				alert("예산을 초과하였습니다");
			}
		},
		error: function(xhr, status, error)
		{
			alert("에러 발생: " + error);
		}
	});
});

</script>

</body>
</html>
