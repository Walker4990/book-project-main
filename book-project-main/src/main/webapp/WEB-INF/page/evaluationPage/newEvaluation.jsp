<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/evaluation.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	<section class="evaluation">
		<div class="box">
	<h1>직원 평가 등록</h1><br>
	
	<div class="form-grid">
		
	<div class="input">
		<label class="label" for="evalDate">평가 일자</label>	
		<input type="date" id="evalDate" name="evalDate">
	</div>
	
	<div class="input">
		</div>
	
	<div class="input">
		<label class="label" for="evaluatorNo">평가자</label>	
		<select id="evaluatorNo" name="evaluatorNo" required>
			<c:forEach var="eval" items="${evaluator}">
				    <option value="${eval.memberNo}">${eval.name}</option>
		    </c:forEach>
		</select>
	</div>
	
	<div class="input">
			</div>

	<div class="input">
		<label class="label" for="memberNo">피평가자</label>	
		<select id="memberNo" name="memberNo" required>
			<c:forEach var="mem" items="${memberList}">
				    <option value="${mem.memberNo}">${mem.name}</option>
			 </c:forEach>
		</select>
	</div>
	
	<div class="input">
				</div>
	
	<div class="reson">
		<label class="label" for="reason">평가 내용</label>	
		<textarea id="reason" name="reason" rows="5" cols="50" placeholder="평가 사유를 입력하세요."></textarea>
	</div>
	
	<div class="input">
	</div>
	
	<div class="input">
		<label class="label" for="grade">등급</label>	
		<select id="grade" name="grade">
			<option value="A">A</option>
			<option value="B">B</option>
			<option value="C">C</option>
			<option value="D">D</option>
			</select>
	</div>
	
	<div class="input">
	</div>

	<div class="submit">
		<button type="button" id="evalBtn">평가 등록</button>
		<button type="button" id="evalCancel">취소</button>
	</div>
	</form>
	</div>
	</div>
	</section>
	
	<script>
		
		  $("#evalCancel").click(() => {
		    location.href = "/main";
		  });

		  $("#evalBtn").click(() => {
		   const evaluatorNo = $("select#evaluatorNo option:selected").val();
		   const memberNo = $("select#memberNo option:selected").val();
			console.log("평가자 번호:", evaluatorNo);
			console.log("피평가자 번호:", memberNo);
		    const reason = $("#reason").val();
		    const grade = $("#grade").val();
		    const evalDate = $("#evalDate").val();
			
			if(!evaluatorNo||!memberNo||!reason||!grade||!evalDate)
			{
				alert("값을 입력해주세요.");
				return;
			}
		    const formData = new FormData();
		    formData.append("evaluatorNo", evaluatorNo);
		    formData.append("memberNo", memberNo);
		    formData.append("reason", reason);
		    formData.append("grade", grade);
		    formData.append("evalDate", evalDate);

		    $.ajax({
		      type: "POST",
		      url: "/newEvaluation",
		      data: formData,
		      processData: false,
		      contentType: false,
		      success: function (result) {
		        if (result === "success") {
		          alert("평가 완료했습니다.");
		          location.href = "/promoCandi";
		        }
		      },
		      error: function () {
		        alert("서버 오류 발생");
		      },
		    });
		  });
	
	</script>
	
  </body>
</html>
