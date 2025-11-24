# 📚 Publisher ERP System — 출판사 통합 ERP

출판사의 **발주·재고·출고·재무·인사·급여·평가** 전 과정을 하나로 연결한 통합 ERP 시스템입니다.  
흩어져 있던 업무를 한 흐름으로 자동화하고, **데이터 정합성과 확장성** 중심으로 설계했습니다.

---

## 🎯 1. 프로젝트 핵심

### ✔ 발주 → 재고 → 출고 → 재무 자동화
- 발주 시 지출 자동 기록  
- 출고 시 재고 차감 + 수익·세금 자동 생성  
- 계약된 인세율 기반 인세 자동 계산

### ✔ 정합성을 위한 트랜잭션 설계
- 출고·발주 등 다중 작업을 **단일 트랜잭션**으로 처리  
- 출고 수정 시 **기존 수량 복원 → diff 반영** 구조  
- 부분 성공 없이 **전체 성공 / 전체 실패** 원칙

### ✔ 확장 가능한 구조
- 실제 업무 단위를 기준으로 기능을 분리  
- 모듈 간 의존도를 낮춰 유지보수성 강화

---

## 🏗️ 2. 주요 기능 (간단 소개)

### 🔸 업무 자동화
- 발주/출고가 등록되면  
  → 재무·세금·인세가 자동 처리되는 일원화 구조

### 🔸 재고 정합성 관리
- 단일 row 기반 재고 관리  
- 출고·반품·수정·삭제에 따라 재고 자동 차감/복구

### 🔸 재무 통합 관리
- 모든 수익/지출을 `finance_transaction` 하나로 관리  
- 발주·출고·급여·인세·세금 자동 반영  
- 월별 통계/차트 제공

### 🔸 인사·근태·급여 흐름
- 출퇴근 → 초과근무 → 급여 → 재무  
- 급여 일괄지급 및 자동 지출 처리

### 🔸 부가 기능
- 품질·불량률 관리  
- 마케팅·파트너 관리  
- 계약·작가·도서 관리

---

## 🗂️ 3. 실제 패키지 구조

com.bk.project
├ attendance/ ├ author/ ├ book/ ├ contract/
├ defect/ ├ evaluation/ ├ financial/ ├ inventory/
├ marketing/ ├ member/ ├ overtime/ ├ partner/
├ payroll/ ├ printorder/ ├ royalty/ ├ salary/
├ shipment/ ├ tax/ └ taxPayment/


모든 모듈은 MVC 패턴에 맞춰 **Controller / Service / Mapper / XML / VO** 구조를 동일하게 유지합니다.

---

## ⚙️ 4. 기술적 해결 포인트

### ✔ 데이터 정합성 보장
- 출고/반품/수정/삭제 등 데이터 변경이 많아  
  → 모든 작업을 하나의 트랜잭션으로 묶어 처리  
- 재고 0 상태 자동 삭제  
- 수정 시 diff 기반으로 정확한 재고 재계산

### ✔ 업무 자동화 설계
- 세금(tax), 인세(royalty), 재무(finance_transaction) 모두 자동 생성  
- 사람이 입력하던 영역을 시스템이 계산하도록 구조화

### ✔ 모듈 단위 분리
- 기능별 패키지 구조로 업무 책임 명확  
- 새로운 기능 추가 시 영향 범위 최소화

---

## 🔗 5. 주요 코드 링크

- PrintOrderService  
  https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/printorder/service/PrintOrderService.java  

- ShipmentService  
  https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/shipment/service/ShipmentService.java  

- InventoryService  
  https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/inventory/service/InventoryService.java  

- FinancialService  
  https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/financial/service/FinancialService.java  

- RoyaltyService  
  https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/royalty/service/RoyaltyService.java  

---

## 🧩 6. 개선 계획

- JSP → React 리팩토링과 함께 **도메인 단위 패키지 구조로 재정비** 예정
- 출판사의 수익구조를 파악하여 수익에 대한 부분 추가 예정
- 단일 row 재고 구조의 한계를 보완하기 위해 **inventory_history 테이블 추가** 계획  
- 배포 자동화를 위해 Docker + GitHub Actions 기반 CI/CD 구축 예정

---
