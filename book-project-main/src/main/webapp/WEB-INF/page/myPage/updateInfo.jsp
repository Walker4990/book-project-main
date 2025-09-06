<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 페이지</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/updateInfo.css">
<body>
	<div class="updateCard">
	  <h1>회원정보 수정</h1>
	  <form id="updateForm" action="/updateInfo" method="post">
	    
	    <div class="inputGroup">
			<input type="hidden" id="id" name="id" value="${loginUser.id}" readonly />
	      <label for="name">이름</label>
	      <input type="text" id="name" name="name" value="${loginUser.name}" readonly />
	    </div>
	    
	    <div class="inputGroup">
	      <label for="memberNo">사원 번호</label>
	      <input type="text" id="memberNo" name="memberNo" value="${loginUser.memberNo}" readonly />
	    </div>
	    
	    <div class="inputGroup">
	      <label for="newPwd">변경할 비밀번호</label>
	      <input type="password" id="newPwd" name="newPwd" required />
	    </div>
	    
	    <div class="inputGroup">
	      <label for="newPwdCheck">비밀번호 확인</label>
	      <input type="password" id="newPwdCheck" name="newPwdCheck" required />
	    </div>

	    <div class="inputGroup">
	      <label for="deptNo">부서 선택</label>
	      <select id="deptNo" name="deptNo">
	        <option value="1">마케팅 팀</option>
			<option value="2">인사팀</option>
			<option value="3">회계/재무팀</option>
			<option value="4">물류(재고 관리)팀</option>
			<option value="5">영업팀</option>
	        ...
	      </select>
	    </div>

	    <div class="inputGroup">
	      <label for="addr">주소</label>
	      <input type="text" id="addr" name="addr" placeholder="${loginUser.addr}" />
	    </div>

	    <div class="inputGroup">
	      <label for="email">이메일</label>
	      <input type="email" id="email" name="email" placeholder="${loginUser.email}" required />
	    </div>

	    <div class="btn-group">
	      <button type="button" class="btn" id="cancelBtn">취소</button>
	      <button type="button" class="btn" id="updateBtn">수정</button>
	    </div>
	  </form>
	</div>
	</section>
	
	  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	  
	  <script>
		
		  // 취소 버튼 → 메인으로 이동
		  $("#cancelBtn").click(function () {
		    location.href = "/main";
		  });
		
		  // 수정 버튼 클릭 시
		  $("#updateBtn").click(function () {
		    const form = $("#updateForm")[0];         
		    const formData = new FormData(form);      
			
		    const newPwd = formData.get("newPwd");         
		    const newPwdCheck = formData.get("newPwdCheck"); 

		    // 예: 값이 같은지 비교
		    if (newPwd !== newPwdCheck) {
		      alert("비밀번호가 일치하지 않습니다.");
		      return;
		    }
			if(!newPwd||!newPwdCheck)
			{
				alert("값을 전부 입력해주세요");
				return;
			}

		    // (5) AJAX로 서버에 데이터 전송
		    $.ajax({
		      type: "POST",
		      url: "/updateInfo",
		      data: formData,
		      processData: false,
		      contentType: false,
		      success: function (result) {
				if(result == "success")
				{
		        alert("정보 수정이 완료되었습니다. 로그인 화면으로 돌아갑니다.");
		        location.href = "/login"; // 메인 페이지로 이동					
				}
				else if(result == "differentPwd")
				{
					alert("비밀번호가 다릅니다.");
				}
				else if(result == "sameEmail")
				{
					alert("이미 동일한 이메일이 존재합니다.");
				}
				
		      },
		      error: function () {
		        alert("오류가 발생했습니다.");
		      },
		    });
		  });
				
	  </script>
	  
</body>
</html>