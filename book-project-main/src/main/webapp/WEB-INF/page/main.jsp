<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<section class="dashboard-section">
  <div class="chart-box">
    <!-- 1번 -->
    <h4>월별 손익</h4>
    <canvas id="financialChart"></canvas>
  </div>
  <div class="chart-box">
    <!-- 2번 -->
    <h4>예산 집행률</h4>
    <canvas id="budgetChart"></canvas>
  </div>
  <div class="chart-box">
    <!-- 3번 -->
    <h4>책별 재고 수량</h4>
    <canvas id="inventoryChartList"></canvas>
  </div>
  <div class="chart-box">
    <!-- 4번 -->
    <h4>제품별 불량 현황</h4>
    <canvas id="selectDefectStats"></canvas>
  </div>
</section>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-chart-waterfall"></script>
<script>
	let financialChart;
	let budgetChart;
	let inventoryChart;
	let defectChart;
	let revenueList = [];
	let expenseList = [];
	let profitList = [];
  Chart.register(ChartDataLabels);
  document.addEventListener("DOMContentLoaded", () => {
	const ctx1 = document.getElementById("financialChart").getContext("2d");

	fetch("${pageContext.request.contextPath}/monthly")
	  .then((res) => res.json())
	  .then((data) => {
	    const labels = data.map(i => i.month); // ex. "2025-08"
	    const revenueList = data.map(i => Number(i.revenue) || 0);
	    const expenseList = data.map(i => Number(i.expense) || 0);
	    const profitList = revenueList.map((r, idx) => r - expenseList[idx]);

	    new Chart(ctx1, {
	      type: "bar",
	      data: {
	        labels,
	        datasets: [{
	          label: "월별 손익 추세",
	          data: profitList,
	          backgroundColor: profitList.map(v => v >= 0 ? "rgba(0, 128, 0, 0.6)" : "rgba(220, 53, 69, 0.6)"),
	          borderColor: profitList.map(v => v >= 0 ? "green" : "red"),
	          borderWidth: 1
	        }]
	      },
	      options: {
	        responsive: true,
	        maintainAspectRatio: false,
	        plugins: {
	          legend: { display: true, position: "top" },
	          tooltip: {
	            callbacks: {
	              label: (ctx) => {
	                const idx = ctx.dataIndex;
	                return "📊 손익: " + profitList[idx].toLocaleString() + "원";
	              },
	              afterBody: (tooltipItems) => {
	                const idx = tooltipItems[0].dataIndex;
	                const revenue = revenueList[idx];
	                const expense = expenseList[idx];
	                return [
	                  "💰 수익: " + revenue.toLocaleString() + "원",
	                  "🧾 지출: " + expense.toLocaleString() + "원"
	                ];
	              }
	            }
	          }
	        },
	        scales: {
	          y: {
	            beginAtZero: true,
	            title: { display: true, text: "손익(원)" }
	          }
	        }
	      }
	    });
	  });
  

	    // 2. 예산 집행률
		const ctx2 = document.getElementById("budgetChart").getContext("2d");

		fetch("${pageContext.request.contextPath}/executionRate")
		  .then((res) => res.json())
		  .then((data) => {
		    if (!data || data.length === 0) {
		      return;
		    }

		    // 📌 데이터 변환 (월별 → { 부서명: 집행률 } 구조)
		    const grouped = {};
		    data.forEach(i => {
		      const month = i.budget_month;  // ex) "2025-08"
		      if (!grouped[month]) grouped[month] = {};
		      grouped[month][i.dept_name] = parseFloat(i.execution_rate) || 0;
		    });

		    // 모든 부서 이름 모으기
		    const departments = [...new Set(data.map(i => i.dept_name))];
		    const months = Object.keys(grouped);

		    // 색상 팔레트 (부서별)
		    const colors = [
		      "rgba(255, 99, 132, 0.6)",   // 인사팀
		      "rgba(255, 206, 86, 0.6)",   // 마케팅팀
		      "rgba(75, 192, 192, 0.6)",   // 물류
		      "rgba(54, 162, 235, 0.6)",   // 회계/재무팀
		      "rgba(153, 102, 255, 0.6)"   // 영업팀
		    ];

		    // 📌 부서별 dataset 생성
		    const datasets = departments.map((dept, idx) => ({
		      label: dept,
		      data: months.map(m => grouped[m][dept] || 0),
		      backgroundColor: colors[idx % colors.length],
		    }));

		    new Chart(ctx2, {
		      type: "bar",
		      data: {
		        labels: months,  // x축: 월별
		        datasets: datasets,
		      },
		      options: {
		        responsive: true,
		        maintainAspectRatio: false,
		        plugins: {
		          legend: { position: "top" },
				  tooltip: {
				    callbacks: {
				      label: (ctx) => {
				        const value = (ctx.raw ?? 0).toFixed(1); 
				        return ctx.dataset.label + ": " + value + "%";
				      }
				    }
				  }
		        },
		        scales: {
		          y: {
		            min: 0,
		            max: 100,
		            ticks: { callback: (v) => v + "%" },
		            title: { display: true, text: "집행률 (%)" },
		          }
		        }
		      }
		    });
		  });

	    // 3. 책별 재고 수량
		const ctx3 = document.getElementById("inventoryChartList").getContext("2d");
		fetch("${pageContext.request.contextPath}/getInventoryBook")
		  .then((res) => res.json())
		  .then((data) => {
		    const titles = data.map((item) => item.title);
		    const quantities = data.map((item) => {
		      const q = Number(item.quantity);
		      return isNaN(q) ? 0 : q;  // NaN 방지
		    });

		    inventoryChart = new Chart(ctx3, {
		      type: "bar",
		      data: {
		        labels: titles,
		        datasets: [
		          {
		            label: "책별 재고 수량",
		            data: quantities,
		            backgroundColor: "rgba(128, 128, 192, 0.6)",
		          },
		        ],
		      },
		      options: {
		        responsive: true,
		        plugins: { legend: { display: true } },
		        scales: { y: { beginAtZero: true } },
		        maintainAspectRatio: false,
	          },
	        });
	      });

		  // 4. 도서별 불량 현황
		  const ctx4 = document.getElementById("selectDefectStats").getContext("2d");
		  fetch("${pageContext.request.contextPath}/selectDefectStats")
		    .then((res) => res.json())
		    .then((data) => {
		      const labels = data.map((item) => item.book_title);   // 도서명
		      const defectCounts = data.map((item) => item.defect_count); // 불량 수량
		      const defectRates = data.map((item) => item.defect_rate);   // 불량률 %

		      defectChart = new Chart(ctx4, {
		        data: {
		          labels,
		          datasets: [
		            {
		              type: "bar",
		              label: "불량 건수",
		              data: defectCounts,
		              backgroundColor: "rgba(54, 162, 235, 0.7)",
		              yAxisID: "y1",
		            },
		         
		            {
		              type: "line",
		              label: "불량률 (%)",
		              data: defectRates,
		              borderColor: "rgba(255, 99, 132, 0.8)",
		              borderWidth: 2,
		              fill: false,
		              yAxisID: "y2",
		              tension: 0.3,
		            },
		          ],
		        },
		        options: {
		          responsive: true,
		          maintainAspectRatio: false,
		          interaction: { mode: "index", intersect: false },
		          stacked: false,
		          scales: {
		            y1: {
		              type: "linear",
		              position: "left",
		              title: { display: true, text: "수량" },
		              beginAtZero: true,
		            },
		            y2: {
		              type: "linear",
		              position: "right",
		              title: { display: true, text: "불량률 (%)" },
		              beginAtZero: true,
		              grid: { drawOnChartArea: false },
		            },
		          },
		        },
		      });
		    });

	    // === 실시간 반영 구독부 ===
	    stompClient.subscribe('/topic/financial', (message) => {
	      const res = JSON.parse(message.body);
	      const pos = res.data.map(v => v >= 0 ? v : NaN);
	      const neg = res.data.map(v => v < 0 ? v : NaN);
	      if (financialChart) {
	        financialChart.data.labels = res.labels;
	        financialChart.data.datasets[0].data = pos;
	        financialChart.data.datasets[1].data = neg;
	        financialChart.update();
	      }
	    });

	    stompClient.subscribe('/topic/budget', (message) => {
	      const res = JSON.parse(message.body);
	      if (budgetChart) {
	        budgetChart.data.labels = res.labels;
	        budgetChart.data.datasets[0].data = res.data;
	        budgetChart.update();
	      }
	    });

	    stompClient.subscribe('/topic/inventory', (message) => {
	      const res = JSON.parse(message.body);
	      if (inventoryChart) {
	        inventoryChart.data.labels = res.labels;
	        inventoryChart.data.datasets[0].data = res.data;
	        inventoryChart.update();
	      }
	    });

	    stompClient.subscribe('/topic/defect', (message) => {
	      const res = JSON.parse(message.body);
	      if (defectChart) {
	        defectChart.data.labels = res.labels;
	        defectChart.data.datasets[0].data = res.counts;
	        defectChart.data.datasets[1].data = res.rates;
	        defectChart.update();
	      }
	    });
	  });
	
</script>
