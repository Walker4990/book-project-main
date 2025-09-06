<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	<section>
	<h2>품의서 작성</h2>
	<form action="/newRequest" method="post" enctype="multipart/form-data" id="saveRequest">
	  <label>결재자: 
	    <select name="approverNo">
	      <c:forEach var="m" items="${approvers}">
	        <option value="${m.memberNo}">${m.name}</option>
	      </c:forEach>
	    </select>
	  </label>
	  <br/><br/>
	  <label>제목: <input type="text" id="title" name="title" placeholder="품의 제목을 입력해주세요." /></label><br/><br/>
	  <label>내용:<br/>
	    <textarea name="content" rows="10" id="content" cols="50"></textarea>
	  </label><br/><br/>
	  <label>파일 첨부: <input type="file" name="file" id="file" /></label><br/><br/>
	  <button type="button" id="save">저장</button>
	</form>
	</section>
	<script>
			$("#save").click((e)=>{
			e.preventDefault();	
			const title = $("#title").val();
			const content = $("#content").val();
			if(!content || !title)
			{
				alert("내용을 입력해주세요.");
				return;
			} 
			
			// FormData로 전송
			const form = $("#saveRequest")[0];
			const formData = new FormData(form);
			$.ajax({
			    url: "/newRequest",  // ← 여기에 실제 전송할 URL을 입력
			    method: "POST",
			    data: formData,
				processData: false, 
				contentType: false, 
			    success: function(result) 
			    {
			        if(result == "success"){
			         alert("품의서 등록이 완료되었습니다!");
			         location.href = "/allRequest";
			       }
			       else if(result == "fail"){
			         alert("품의서 등록에 실패하였습니다.");
			       }
			   },
			   error: function(xhr, status, error) {
			         alert("에러 발생: " + error);
			   }
			});
		});
	</script>
  </body>
</html>