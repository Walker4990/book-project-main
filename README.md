📚 Publisher ERP System — 출판사 통합 ERP 시스템

출판사의 도서·재고·발주·출고·회계·인사·급여·평가 등 전사 업무를 하나의 웹 시스템으로 통합한 ERP 프로젝트입니다.
실제 기업의 업무 흐름을 분석해, 모듈 간 데이터 정합성과 자동화 흐름을 중점으로 설계했습니다.

🔥 1. 프로젝트 핵심 요약

도서 발주 → 입고 → 재고 → 출고 → 재무(수익/지출) 자동 반영

작가 계약 / 인세 정산 / 세금 처리 자동화

인사 평가 / 급여 관리 / 초과근무 자동 계산

품질/불량률 관리, 마케팅, 배송, 거래처 관리 포함

모든 기능을 모듈 기반으로 분리해 유지보수성 강화

🏗️ 2. 핵심 기술 스택

Backend: Spring Boot, MyBatis, Java 11

DB: MySQL 8

Frontend: JSP, jQuery, Bootstrap

Infra: Tomcat 내장 서버

기타: Lombok, JSTL, Ajax, FormData 활용

📦 3. 기능별 핵심 모듈 요약

아래 폴더들은 실제 업무 단위 그대로 설계된 기능 패키지이다:

📚 Book / Author / Contract

도서 등록·관리

작가 관리

계약 등록 시 작가/도서 자동 생성

인세율, 정산 기준 등록

🏭 PrintOrder (도서 발주)

도서 발주 등록

단일 입력 → 다건 상세 발주로 확장(FormData → List 자동 바인딩)

발주 시 지출 기록 자동 생성(finance_transaction)

세금 자동 생성(tax)

📦 Inventory (재고 관리)

단일 row 기반 통합 재고 구조 (IN/OUT 가감)

출고 시 수량 감소, 0이면 자동 삭제

출고 수정 시 diff 로직으로 반영

🚚 Shipment (출고 관리)

도서 다건 출고

거래처·배송사 선택

출고 시

재고 차감

수익 자동 생성(finance_transaction)

세금 기록 생성

수정/삭제 시 재고 복원 로직 포함

💰 Finance (재무)

finance_transaction: 모든 수익/지출 기록 통합 관리

출고 → 수익 자동

발주 → 지출 자동

인세, 급여, 세금 등도 자동 집계

월별 수익/지출 대시보드

🖋️ Royalty (인세)

출고량 기반 인세 자동 계산

계약 정보의 인세율로 계산

finance_transaction과 자동 연동

🧾 Tax / TaxPayment

발주·출고·급여에 따른 세금 기록 자동 생성

세금 납부 입력/관리

👥 Member / Attendance / Overtime / Salary / Payroll

직원 등록·관리

출퇴근 기록 기반 초과근무 자동 계산

급여 등록 + 일괄 지급

급여 지급 시 finance_transaction 지출 자동 등록

평가 모듈(evaluation)로 연계

📝 Evaluation

인사 평가용 지표 생성

관리자 권한 기반 접근

승진 대상자 조회 기능

🛠 Defect (품질 보증)

불량률 관리

불량 사유별 통계

책별 재고 대비 불량률 차트

📊 Marketing

마케팅 캠페인 관리

파트너사와의 금액·지출·성과 기록

🔗 4. 패키지 구조 (실제 프로젝트 구조)

/src/main/java/com/bk/project

attendance/
author/
book/
budget/
calendar/
claim/
contract/
defect/
delivery/
department/
evaluation/
financial/
inventory/
marketing/
member/
overtime/
partner/
payroll/
printorder/
quit/
request/
royalty/
salary/
shipment/
tax/
taxPayment/


각 폴더는 Controller / Service / Mapper / XML / VO 구조를 동일하게 유지해 확장성, 유지보수성을 확보했다.

🚀 5. 핵심 기술 포인트 (면접에서 반드시 강조)
1) 모듈 간 자동화

도서 발주 → 재고 → 출고 → 재무 → 세금 → 인세까지
연결되는 모든 흐름을 자동화로 설계.

2) 트랜잭션 기반 데이터 정합성

출고 등록 시 5가지 insert/update 하나로 처리

오류 발생 시 전체 rollback

출고 수정 시 기존 수량 복원 → 변경수량 반영(diff) 로직 별도 구현

3) 확장성 있는 패키지 구조

기능별 모듈화를 통해 단위 추가·확장 용이

예: salary / payroll / evaluation이 상호 독립적이면서 연계됨

4) FormData → List 자동 바인딩

DetailList 구조를 통해 다건 입력 구현

printOrder, shipment 등에서 공통 패턴 활용

5) 중복 처리 & 상태 관리

출고, 발주, 급여지급 등에서 중복 등록 방지 로직 적용

상태 기반 UI/백엔드 처리 일원화

📎 6. 핵심 코드 링크 (너 리포지토리에 맞게 자동 생성)

👉 네 repo 기준 경로:
https://github.com/Walker4990/book-project-main/tree/main/book-project-main/src/main/java/com/bk/project

대표 기능별 링크 예시
- [PrintOrderController](https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/printorder/PrintOrderController.java)
- [ShipmentController](https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/shipment/ShipmentController.java)
- [InventoryService](https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/inventory/InventoryService.java)
- [FinanceTransactionService](https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/financial/FinanceService.java)
- [RoyaltyService](https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/royalty/RoyaltyService.java)
- [SalaryPayService](https://github.com/Walker4990/book-project-main/blob/main/book-project-main/src/main/java/com/bk/project/salary/SalaryService.java)


필요하면 각 코드의 라인 번호 하이라이트 버전도 만들어줄 수 있음.

📈 7. 발표·면접에서 이렇게 말하면 된다

“출판사 업무 전체를 하나의 ERP로 묶기 위해
발주–재고–출고–재무 흐름을 자동화하고,
수정/삭제를 고려한 트랜잭션 기반 구조로 설계했습니다.
또한 인사·급여·인세·세금 등 여러 모듈을 기능 단위 패키지로 분리해
유지보수성과 확장성을 확보했습니다.”
