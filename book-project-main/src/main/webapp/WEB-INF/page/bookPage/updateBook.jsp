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

    <h1>도서 목록 수정</h1>
		  도서 번호: <input type="text" value="${selectBook.bookNo}" readonly /><br>
		  <input type="hidden" id="bookNo" name="bookNo" value="${selectBook.bookNo}"  />
	      도서명 : <input type="text" id="title" name="title" value="${selectBook.title}"></br> 
	      출간일 : <input type="date"id="publishDate" name="publishDate" value="${selectBook.publishDate}"></br>
	      판매 가격 : <input type="text" id="price" name="price" value="${selectBook.price}"></br>
	
	        <button id="update" type="button">수정</button>
			<button id="cancel" type="button">취소</button>
			    
			    <script>
					$("#update").click(() => {
							    const bookNo = $("#bookNo").val();
							    const title = $("#title").val();
							    const publishDate = $("#publishDate").val();
							    const price = $("#price").val();

							    const formData = new FormData();
							    formData.append("bookNo", bookNo);
							    formData.append("title", title);
							    formData.append("publishDate", publishDate);
							    formData.append("price", price);

							    $.ajax({
							      type: "POST",
							      url: "/updateBook",
							      data: formData,
							      processData: false,
							      contentType: false,
							      success: function (result) {
							        if (result === "success") {
							          alert("수정이 완료되었습니다.");
							          location.href = "/allBook";
							        } else 	
									alert("수정 실패!");
							      },
							    });
							  });
					
					$("#cancel").click(() => {
						
					});
				</script>
	    
      
  </body>
</html>