<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 계약 해지/ 만료 모달-->
<sec:authentication var="member" property="principal" />
		<div id="overtimeModal" class="modal-overlay" style="display:none;">
		  <div class="modal-box">
			<div class="modal-header">
				<h5 class="modal-title">야근 신청</h5>
					<button class="close-btn" onclick="closeEditModal()">✕</button>
					</div>
					
			<div class="modal-body">
			<div class="form-grid">	
			<input type="hidden" name="memberNo" id="memberNo" value="<sec:authentication property='principal.memberNo'/>" />
			<input type="hidden" name="overTimeName" id="overTimeName" value="<sec:authentication property='principal.name'/>" />
			<div class="input">
				<label class="label">등록일</label>
				<input type="date" id="overTimeDate"name="overTimeDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"readonly/><br>
				</div>
				
				<div class="input">
				<label class="label">사유</label>
				<textarea id="overTimeReason" name="reason" required></textarea>
			    </div>
			</div>
			</div>

		    <div class="modal-footer">
				<button type="button" id="saveOvertimeSubmit" class="btn btnPrimary">확인</button>
				<button type="button" id="closeOvertimeSubmit" class="btn btnPrimary">취소</button>		
		    </div>
		  </div>
		  <script src="${pageContext.request.contextPath}/resources/js/overtimeModal.js"></script>
		</div>