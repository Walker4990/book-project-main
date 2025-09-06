<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<div class="side">
  <section class="attendance">
    <div class="attendance-box">
      <span><span id="times"></span>(<span id="dateKo"></span>)</span>
      <div class="time" id="clock"></div>

      <div class="inOutBtn">
        <button id="checkIn">출근</button>
        <button id="checkOut">퇴근</button>
      </div>
    </div>
  </section>

  <section class="menu">
    <h1><a href="/main">ERP</a></h1>
    <nav>
      <div class="menu-group">
        <div class="menu-title">인적자원 관리</div>
        <div class="submenu">
          <a href="/allMember">직원 정보 조회</a>
          <a href="/newSalary">급여 등록</a>
          <a href="/attendance">출/퇴근 관리</a>
          <div class="submenu-item">
            <a href="#" class="toggle-submenu">휴가 관리</a>
            <div class="submenu1">
              <a href="/allVacation">ㆍ 휴가 신청 관리</a>
              <a href="/vacationCalendarPage">ㆍ 휴가 일정표</a>
            </div>
          </div>

          <!--<a href="/overtime">야근 신청</a>-->
          <div class="submenu-item">
            <a href="#" class="toggle-submenu">인사 평가 관리</a>
            <div class="submenu1">
              <a href="/newEvaluation" class="adminAccess">ㆍ 인사 평가 등록</a>
              <a href="/promoCandi" class="adminAccess">ㆍ 진급 대상자 조회</a>
            </div>
          </div>
          <a href="/allQuit">퇴사 관리</a>
        </div>
      </div>

      <div class="menu-group">
        <div class="menu-title">도서 관리</div>
        <div class="submenu">
          <a href="/allBook">도서 목록 조회</a>
        </div>
      </div>

      <div class="menu-group">
        <div class="menu-title">작가 계약 관리</div>
        <div class="submenu">
          <a href="/calendarPage">계약 일정</a>
          <a href="/allContract">계약 작가 등록/조회/수정</a>
          <a href="/expiredList">만료/해지 계약 조회</a>
        </div>
      </div>
      <!--
      <div class="menu-group">
        <div class="menu-title">재고 관리</div>
        <div class="submenu">
          <a href="/allInven">재고 현황 조회</a>
          <a href="/newOutInven">출고 등록</a>
          <a href="/allShipment">출고 등록/조회</a>
        </div>
      </div>
	  -->
      <div class="menu-group">
        <div class="menu-title">구매/판매 관리</div>
        <div class="submenu">
          <!--<a href="/newPrintOrder">신규 도서 발주서 등록</a>-->
          <a href="/allPrintOrder">발주서 등록/조회</a>
          <div class="submenu-item">
            <a href="#" class="toggle-submenu">재고 관리</a>
            <div class="submenu1">
              <a href="/allInven">ㆍ 재고 현황 조회</a>
              <a href="/allShipment">ㆍ 출고 등록/조회</a>
            </div>
          </div>
        </div>
      </div>

      <div class="menu-group">
        <div class="menu-title">제휴사 관리</div>
        <div class="submenu">
          <!--<a href="/newPartner">신규 거래처 등록</a>-->
          <a href="/allPartner">거래처 등록/조회/수정</a>
          <a href="/allDelivery">운송사 정보 조회/수정</a>

          <div class="submenu-item">
            <a href="#" class="toggle-submenu">마케팅 관리</a>
            <div class="submenu1">
              <a href="/allMarketing">ㆍ 프로젝트 등록/조회/수정</a>
              <a href="/marketingExpiredList">ㆍ 완료 프로모션 조회</a>
            </div>
          </div>
        </div>
      </div>
      <!--
      <div class="menu-group">
        <div class="menu-title">운송사 관리</div>
        <div class="submenu">
          <a href="/newDelivery" class="adminAccess">신규 운송사 등록</a>
          
        </div>
      </div>-->
      <!--
      <div class="menu-group">
        <div class="menu-title">마케팅 관리</div>
        <div class="submenu">
          <a href="/newMarketing">신규 프로젝트 등록</a>
          <a href="/allMarketing">프로젝트 등록/조회/수정</a>
          <a href="/marketingExpiredList">완료 프로모션 조회</a>
        </div>
      </div>
	  -->
      <div class="menu-group">
        <div class="menu-title">재무 관리</div>
        <div class="submenu">
          <a href="/insertPayroll" class="adminAccess">급여 지급</a>
          <a href="/revenue">수입/지출 내역</a>
          <div class="submenu-item">
            <a href="/taxPaidList" class="adminAccess">세무 관리</a>
          </div>
          <div class="submenu-item">
            <a href="#" class="toggle-submenu">예산 관리</a>
            <div class="submenu1">
              <a href="/allBudgetPlan">ㆍ부서별 예산 현황</a>
            </div>
          </div>
        </div>
        <!-- submenu 닫힘 -->
      </div>
      <!-- menu-group 닫힘 -->

      <div class="menu-group">
        <div class="menu-title">품질보증 관리</div>
        <div class="submenu">
          <a href="/qualityCheckTarget">품질 검수 대상 조회</a>
          <a href="/allDefect">품질 검수 보고 등록/조회/수정</a>
          <!--<a href="/newClaim" class="adminAccess">클레임 등록/조회/수정</a>-->
          <a href="/allClaim">클레임 등록/조회/수정</a>
        </div>
      </div>
    </nav>
  </section>
</div>
