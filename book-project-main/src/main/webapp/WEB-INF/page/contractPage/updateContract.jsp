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
    <h1>계약 정보 수정</h1>
	
 <div>
		계약 번호 : <input type="text" value="${contract.contractNo}" readonly /><br>
		<input type="hidden" id="contractNo" name="contractNo" value="${contract.contractNo}"  />
		작가 이름 : <input type="text" id ="authorName" name="authorName" value="${contract.authorName}" readonly /><br />
        도서명 : <input type="text" id ="bookTitle" name="bookTitle" placeholder="변경된 도서명을 입력해주세요" required></br> 
		계약금 : <input type="text" id ="contractAmount" name="contractAmount" placeholder="수정된 계약금을 입력해주세요" required></br>
		인세 : <input type="text" id ="royaltyRate" name="royaltyRate" placeholder="수정된 인세를 입력해주세요" required></br>
		계약 만료 일자 : <input type="date" id ="endDate" name="endDate" placeholder="변경된 계약일자를 입력해주세요" required></br>
		원고 마감 일자 : <input type="date" id ="manuscriptDue" name="manuscriptDue" placeholder="변경된 원고 마감일자 입력해주세요" required></br>
		인쇄 일자 : <input type="date" id ="printDate" name="printDate" placeholder="변경된 인쇄일자를 입력해주세요" required></br>
		출판 일자 : <input type="date" id ="publishDate" name="publishDate" placeholder="변경된 출판일자를 입력해주세요" required></br>
	 </div>
		
		<button id="update" type="button">수정</button>
		<button id="cancel" type="button">취소</button>
									
		<script>
		

			  $("#acceptEdit").click(() => {
				
				// required 검사
						let allValid = true;
						$("input:required").each(function () {
						  if (!this.checkValidity()) { //required, type, pattern 등의 유효성 검사를 실행
						    this.reportValidity(); // 브라우저 기본 알림 띄우기
						    allValid = false;
						    return false; // break
						  }
						});
						if (!allValid) return;
				// 날짜 검사하기
						
				
			    const contractNo = $("#contractNo").val();
			    const bookTitle = $("#bookTitle").val();
			    const contractAmount = $("#contractAmount").val();
			    const royaltyRate = $("#royaltyRate").val();
			    const endDate = $("#endDate").val();
				const manuscriptDue = $("#manuscriptDue").val();
				const printDate = $("#printDate").val();
				const publishDate = $("#publishDate").val();
				const data={
					contractNo,
					bookTitle,
					contractAmount,
					royaltyRate,
					endDate,
					manuscriptDue,
					printDate,
					publishDate
				}
				if (manuscriptDue && endDate && manuscriptDue > endDate) {
					alert("원고 마감일은 계약 만료일보다 늦을 수 없습니다");
					return;
				}
				if (manuscriptDue && printDate && manuscriptDue > printDate) {
					alert("원고 마감일은 인쇄일보다 늦을 수 없습니다");
					return;
				}
				if (publishDate && printDate && publishDate < printDate) {
					alert("출판일은 인쇄일보다 이전일 수 없습니다");
					return;
				}					

				 $.ajax({
				    type: "POST",
				    url: "/updateContract",
				    contentType: "application/json",
				    data: JSON.stringify(data),
				    success: function (result) {
				      if (result === "success") {
				        alert("수정이 완료되었습니다.");
				        location.href = "/allContract";
				      } else {
				        alert("수정 실패!");
				      }
				    },
				    error: function () {
				      alert("수정 중 오류가 발생했습니다.");
				    }
				  });
				});

			  $("#cancelEdit").click(() => {
			    location.href = "/allContract";
			  });
			</script>
		
		
  </body>
</html>