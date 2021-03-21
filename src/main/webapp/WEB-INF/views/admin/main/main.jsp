<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>관리자 메인</title>
<%-- <script src="${contextPath }/resources/lib/chart-master/Chart.js"></script> --%>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
</head>

<body>
<div class="container" style="padding-top: 110px; margin-left:280px;"> 
<!-- <div class="container" style="padding: 99px 80px 0;">  -->
	<!-- <div class="row my-3"> 
		<div class="col"> 
			<h4>신규 가입자 수</h4> 
		</div> 
	</div>  -->
	<div class="row py-2"> 
		<div class="row">
			<div class="col-md-12"> 
				<div class="card" style="height:auto"> 
					<div class="card-body"> 
						<canvas id="chLine"></canvas> 
					</div> 
				</div> 
			</div>
		</div>
		<!-- <div class="row my-3"> 
			<div class="col"> 
				<h4>매출액</h4> 
			</div> 
		</div>  -->
		<div class="row">
			<div class="col-md-6"> 
				<div class="card" style="height:auto"> 
					<div class="card-body"> 
						<canvas id="chBar"></canvas> 
					</div> 
				</div> 
			</div> 
			
			<div class="col-md-6"> 
	<!-- 		<div class="col-md-4 py-1">  -->
				<div class="card" style="height:auto"> 
					<div class="card-body"> 
						<canvas id="chDoughnut"></canvas> 
					</div> 
				</div> 
			</div> 
		</div>
		<!-- <div class="row my-3"> 
			<div class="col"> 
				<h4>상품별 수요</h4> 
			</div> 
		</div>  -->
		<%-- <div class="row">
			<div class="col-md-6"> 
				<div class="card" style="height:auto"> 
					<div class="card-body"> 
						<canvas id="chDoughnut"></canvas> 
					</div> 
				</div> 
			</div> 
		</div> --%>
		<%-- <div class="col-md-4 py-1"> 
			<div class="card"> 
				<div class="card-body"> 
					<canvas id="chDonut3"></canvas> 
				</div> 
			</div> 
		</div>  --%>
	</div> 
</div> 

<%-- <canvas id="myChart" align="center"></canvas>
				<canvas id="myChart2"></canvas>
				<canvas id="myChart3"></canvas>
				<canvas id="myChart4"></canvas> --%>




  <!-- chart.js -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script> 
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js" type="text/javascript" ></script><!-- piece label이라는 Chart.js 확장 플러그인 -->
 <script type="text/javascript">
	// chart.js 
	//var colors = ['red','skyblue','yellowgreen','#c3e6cb','#dc3545','#6c757d', '#ddd'];  
	
	// 차트 랜덤 색상 
	function randomColor(label) {
		var rancolors = [];
		for (let i = 0; i < label.length; i++) {
			rancolors.push("#" + Math.round(Math.random() * 0xffffff).toString(16));
		}
		return rancolors;
	}
	
	// 기본 옵션
	var options = { 
			//cutoutPercentage: 30, //도넛두께 : 값이 클수록 얇아짐 
			legend: {display:false},  // 라벨(범례) 안보이게 하기
			title: {display: true, text: '제목'}
			/* scales: {
			    yAxes: [{
			    	ticks: {
	                    beginAtZero: true
	                },	
			      scaleLabel: {
			        display: true,
			        labelString: '가입자수 (명)'
			      }
			    }]
			  }    */  
/* 			legend: {position:'bottom', padding:5, labels: {pointStyle:'circle', usePointStyle:true}} 라벨 하단에 위치, 동그라미모양 */
	};
	
	// 격자 선 안보이게 하는 옵션
	var lineOption = {
			legend: {display:false},
			scales: {
		        xAxes: [{
		            gridLines: {
		                display:false
		            }
		        }],
		        yAxes: [{
		            gridLines: {
		                display:false
		            }   
		        }]
		    }
	};
	
	// bar - 매출액 통계
	var olabel = [];
	var odatas = [];
	olabel.push({date:2021-02-01});
	odatas.push({sign:100000});
	
	<c:forEach items="${orderList }" var="selData">
		olabel.push({date:"${selData.order_date}"});
		odatas.push({sign:"${selData.total_goods_price}"});
	</c:forEach>
	
	
	var chBarData1 = { 
			labels: [olabel[0].date, olabel[1].date], 
			datasets: [ 
				{ 
					backgroundColor: randomColor(olabel).slice(0,3), 
					borderWidth: 0,
					data: [odatas[0].sign, odatas[1].sign] 
				} 
			] 
	};  
	
	var chBar1 = document.getElementById("chBar"); 
	if (chBar1) { 
		new Chart(chBar1, { 
			type: 'bar', 
			data: chBarData1, 
			options: {
				legend: {display:false},  // 라벨(범례) 안보이게 하기
				title: {
					display: true, 
					text: '매출액 통계', // 차트 이름
					fontSize : '16'
				}
			}
		}); 
	} 
	
	// Doughnut - 상품 통계 임의 데이터 삽입
	var dlabel = ['래더백', '트렌드백', '에코백', '지갑', '신발', '가방악세사리', '악세사리'];
	var ddatas = [80, 55, 63, 72, 42, 10, 22];
	
	var chDoughnutData1 = { 
			labels: dlabel, 
			datasets: [ 
				{ 
					backgroundColor: randomColor(dlabel).slice(0,10), 
					borderWidth: 1,  // 간격
					data: ddatas
				} 
			] 
	};  
	
	var chDoughnut1 = document.getElementById("chDoughnut"); 
	if (chDoughnut1) { 
		new Chart(chDoughnut1, { 
			type: 'doughnut', 
			data: chDoughnutData1, 
			options: {
				legend: {
					position:'bottom', 
					padding:5, 
					labels: {
						pointStyle:'circle', 
						usePointStyle:true
					}
				}, //라벨 하단에 위치, 동그라미모양 
				//legend: {display:false},  // 라벨(범례) 안보이게 하기
				title: {
					display: true, 
					text: '상품별 수요',
					fontSize : '16'
				},
				plugins:{
					labels: { 
						mode: 'label',        // 값
						//render: 'label',	  // 라벨
				        fontColor: '#000',
				        position: 'border',
				        segment: true
			    	 } 
				}
			}
		}); 
	} 
	
	// line chart - 회원 통계
	var label = [];
	var datas = [];
	
	<c:forEach items="${list }" var="memData">
		label.push({date:"${memData.member_credate}"});
		datas.push({sign:"${memData.member_id}"});
	</c:forEach>
	
	console.log(JSON.stringify(label[0].date));
	console.log(label.length);
	
	var chLineData2 = { 
			labels: [label[0].date, label[1].date, label[2].date, label[3].date, label[4].date], 
			datasets: [ 
				{ 
					/* label: '신규 회원 수', */
					/* backgroundColor: rgba(0, 0, 0, 0.1),
					borderColor: 'black' */
 					backgroundColor: randomColor(label).slice(0,3),  
 					borderColor: 'rgba(0, 0, 0, 1)',
 					borderWidth: 0, 
 					fill: false, 		// 배경색 채우기 안함
 					//lineTension: 0,		// 직선 그래프
					data: [datas[0].sign, datas[1].sign, datas[2].sign, datas[3].sign, datas[4].sign]
				} 
			] 
	};  
	
	var chLine = document.getElementById("chLine"); 
	if (chLine) { 
		new Chart(chLine, { 
			type: 'line', 
			data: chLineData2, 
			options: {
				legend: {display:false},  // 라벨(범례) 안보이게 하기
				title: {
					display: true, 
					text: '신규 가입자',
					fontSize : '16'
				}
			}
		}); 
	}   
	
	//차트 색상 랜덤
	/* $(function() {
		function randomColor(labels) {
			var colors = [];
			for (let i = 0; i < labels.length; i++) {
				colors.push("#" + Math.round(Math.random() * 0xffffff).toString(16));
			}
			return colors;
		}
		function makeChart(ctx, type, labels, data) {
			var myChart = new Chart(ctx, {
			    type: type,
			    data: {
			        labels: labels,
			        datasets: [{
			            label: '날짜별 게시글 등록 수',
			            data: data,
			            backgroundColor: randomColor(labels)
			        }]
			    },
			    options: {
				    responsive: false,
			        scales: {
			            yAxes: [{
			                ticks: {
			                    beginAtZero: true
			                }
			            }]
			        }
			    }
			});
		}
		
		$.ajax({
			
			type: "GET",
			url: "/admin/main.do",
			dataType : "json",
			success: function(data, status, xhr) {
				
				console.log(data);
				
				
				var labels = [];
				var myData = [];
				
				//맵안에 list 였으니 for문으로 돌린다
				$.each(data.list,function (k,v){
					
					labels.push(v.member_credate);
					myData.push(v.member_id);
				});

				var newLabels = labels.slice(-5);
				var newMyData = myData.slice(-5);
				// Chart.js 막대그래프 그리기
				var ctx = $('#myChart');
				makeChart(ctx, 'bar', newLabels, newMyData);
				// Chart.js 선그래프 그리기
				ctx = $('#myChart2');
				makeChart(ctx, 'line', newLabels, newMyData);
				// Chart.js 원그래프 그리기
				ctx = $('#myChart3');
				makeChart(ctx, 'pie', newLabels, newMyData);
				ctx = $('#myChart4');
				makeChart(ctx, 'doughnut', newLabels, newMyData);
			}
		});
		
	}); */
</script>
</body>
</html>