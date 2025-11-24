##  Publisher ERP System — 출판사 통합 ERP

출판사의 발주·재고·출고·회계·인사·급여·평가 전 과정을 하나의 시스템으로 통합한 ERP 프로젝트입니다.
핵심 목표는 업무 흐름 자동화, 데이터 정합성 유지, 모듈 간 확장성 확보입니다.

##  1. 핵심 요약
### ✔ 발주 → 재고 → 출고 → 재무(수익·지출) 자동화

발주 시 지출 자동 생성 (finance_transaction)

출고 시 재고 차감 + 수익 자동 생성 + 세금 자동 생성

계약된 인세율 기반으로 인세(royalty) 자동 계산

### ✔ 트랜잭션 기반의 데이터 정합성

출고 등록 시 여러 insert/update를 한 번에 처리

출고 수정 시 기존 수량 복원 → 변경분(diff)만 반영

오류 발생 시 전체 rollback

## 🏗️ 2. 기술 스택

Backend: JAVA, Spring Boot, MyBatis

DB: MySQL

Frontend: JSP, jQuery, HTML, CSS

ETC: Lombok, JSTL, Ajax, Redis

## 📦 3. 주요 기능 요약
### 📚 도서/작가/계약

도서 및 작가 관리

계약 등록 시 작가/도서 자동 생성

인세율, 정산 기준 저장

### 🏭 발주(PrintOrder)

단일 → 다건 상세 발주로 확장 (FormData → List 자동 바인딩)

발주 시 지출 + 세금 자동 반영

### 📦 재고(Inventory)

단일 row 기반 재고 통합 구조

출고 시 재고 자동 감소

수량 0이면 row 자동 삭제

출고 수정 시 diff 로직 적용

### 🚚 출고(Shipment)

도서 다건 출고

거래처·배송사 선택

출고 시 재고 차감

수익 자동 기록

세금 자동 생성

수정/삭제 시 재고 자동 복구

### 💰 재무(Financial)

모든 수익/지출을 finance_transaction에서 통합 관리

출고·발주·급여·인세·세금 자동 반영

월별 대시보드

### 🖋 인세(Royalty)

출고량 기반 인세 자동 계산

계약된 인세율 기반

### 👥 인사·근태·급여

출퇴근 기반 초과근무 자동 계산

급여 등록 및 일괄 지급

급여 지급 시 지출 자동 반영

평가(evaluation) 모듈 연계

### 🛠 품질(Defect)

불량률 관리

불량 사유별 통계

품목 대비 불량률 차트 제공

## ⚙️ 4. 기술적 해결 포인트 (면접 핵심)
### 🔹 정합성 중심 트랜잭션 설계

발주·출고 등 다중 insert/update를 하나의 트랜잭션에서 처리

부분 성공 없이 전체 성공/전체 실패 구조

### 🔹 출고 수정(diff) 알고리즘

기존 출고 수량 복원

변경된 수량만 재차 차감

수정/삭제가 발생해도 데이터 불일치가 없음

### 🔹 업무 자동화

세금, 인세, 수익/지출 등 사람이 입력하던 항목 대부분을 자동화

업무 누락 방지·정확도 증가

### 🔹 확장 가능한 패키지 설계

모듈별 책임 분리

신규 기능 추가 용이

## 🔗 6. 주요 코드 링크

PrintOrderService
https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/printorder/service/PrintOrderService.java

ShipmentService
https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/shipment/service/ShipmentService.java

InventoryService
https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/inventory/service/InventoryService.java

FinancialService
https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/financial/service/FinancialService.java

RoyaltyService
https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/royalty/service/RoyaltyService.java

## 🧩 7. 아쉬웠던 점 & 개선 계획

재고 이력 추적 미흡
단일 row 구조라 이동 이력 기록이 부족함 → inventory_history 테이블 도입 예정

월 마감(batch) 처리 미완성
재무·세금·인세 자동화는 완료했지만 월별 마감 배치 기능 추가 필요

JSP 기반 UI의 한계
화면 유지보수성이 낮아 이후 React 기반 프론트엔드 분리 계획

권한(Role) 체계 단순함
관리자/일반 사용자 수준 → 부서별 역할 기반 권한 구조로 개선 예정

배포/CI 환경 미도입
로컬 개발 중심 → Docker + GitHub Actions 기반 CI/CD 구축 계획
