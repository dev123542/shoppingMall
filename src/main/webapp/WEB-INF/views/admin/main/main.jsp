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
<!-- <script type="text/javascript">
  	/* //구글 차트 라이브러리 로딩
  	google.load('visualization','1',{
    	'packages' : ['corechart']
	});
  	
  	// 로딩 완료 후 drawChart 함수 호출
  	google.setOnLoadCallback(drawChart);
  	
  	function drawChart(){
  		var jsonData = $. ajax({
  			url: ${contextPath}/"admin/product/chart.do",
  			type: "post"
  			dataType: "json",
  			async: false
  		}).responseText;  //json 파일을 text파일로 읽음
  		
  		console.log(jsonData);
  		
  		var data = new  google.visualization.DataTable(jsonData);
  		var chart  = new google.visualization.PieChart(document.getElementById('chart_div'));
  		
  		chart.draw(data, {
  			title : "카테고리 통계",
  			width: 600,
  			height: 400
  		});
  	} */
  	
  	// chart.js 
  	// chart colors 
  	var colors = ['red','skyblue','yellowgreen','#c3e6cb','#dc3545','#6c757d']; 
  	
  	/* 3 donut charts */ 
  	var donutOptions = { 
  			cutoutPercentage: 30, //도넛두께 : 값이 클수록 얇아짐 
  			legend: {position:'bottom', padding:5, labels: {pointStyle:'circle', usePointStyle:true}} 
  	}; 
  	
  	// donut 1 
  	var chDonutData1 = { 
  			labels: ['Bootstrap', 'Popper', 'Other'], 
  			datasets: [ 
  				{ 
  					backgroundColor: colors.slice(0,3), 
  					borderWidth: 0, 
  					data: [74, 11, 40] 
  				} 
  			] 
  	}; 
  	
  	var chDonut1 = document.getElementById("chDonut1"); 
  	if (chDonut1) { 
  		new Chart(chDonut1, { 
  			type: 'pie', 
  			data: chDonutData1, 
  			options: donutOptions 
  		}); 
  	} 
  	
  	// donut 2 
  	var chDonutData2 = { 
  			labels: ['Wips', 'Pops', 'Dags'], 
  			datasets: [ 
  				{ 
  					backgroundColor: colors.slice(0,3), 
  					borderWidth: 0, 
  					data: [40, 45, 30] 
  				} 
  			] 
  	}; 
  	
  	var chDonut2 = document.getElementById("chDonut2"); 
  	if (chDonut2) { 
  		new Chart(chDonut2, { 
  			type: 'pie', 
  			data: chDonutData2,
  			options: donutOptions 
  		}); 
  	} 
  	
  	// donut 3 
  	var chDonutData3 = { 
  			labels: ['Angular', 'React', 'Other'], 
  			datasets: [ 
  				{ 
  					backgroundColor: colors.slice(0,3), 
  					borderWidth: 0, data: [21, 45, 55, 33] 
  				} 
  			] 
  	}; 
  	
  	var chDonut3 = document.getElementById("chDonut3"); 
  	if (chDonut3) { 
  		new Chart(chDonut3, { 
  			type: 'pie', 
  			data: chDonutData3, 
  			options: donutOptions 
  		}); 
  	}


  </script> -->
</head>

<body>
<!-- 차트 -->
<%-- <c:forEach items="${list }" var="memData">
	<div>${memData }</div>
</c:forEach> --%>
<div class="container" style="padding: 99px 80px 0;"> 
	<div class="row my-3"> 
		<div class="col"> 
			<h4>신규 가입자 수</h4> 
		</div> 
	</div> 
	<div class="row py-2"> 
		<%-- <div class="col-md-4 py-1"> 
			<div class="card"> 
				<div class="card-body"> 
					<canvas id="chDonut1"></canvas> 
				</div> 
			</div> 
		</div>  --%>
		<div class="row">
			<div class="col-md-12"> 
	<!-- 		<div class="col-md-4 py-1">  -->
				<div class="card" style="height:auto"> 
					<div class="card-body"> 
						<canvas id="chLine"></canvas> 
					</div> 
				</div> 
			</div> 
		</div>
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




  <!-- js placed at the end of the document so the pages load faster -->
 <!-- <script type="text/javascript">
    $(document).ready(function() {
      var unique_id = $.gritter.add({
        // (string | mandatory) the heading of the notification
        title: 'Welcome to Dashio!',
        // (string | mandatory) the text inside the notification
        text: 'Hover me to enable the Close Button. You can hide the left sidebar clicking on the button next to the logo. Developed by <a href="http://alvarez.is" target="_blank" style="color:#4ECDC4">Alvarez.is</a>.',
        // (string | optional) the image to display on the left
        image: 'img/ui-sam.jpg',
        // (bool | optional) if you want it to fade out on its own or just sit there
        sticky: false,
        // (int | optional) the time you want it to be alive for before fading out
        time: 8000,
        // (string | optional) the class name you want to apply to that specific message
        class_name: 'my-sticky-class'
      });

      return false;
    });
  </script> -->
  <!-- <script type="application/javascript">
    $(document).ready(function() {
      $("#date-popover").popover({
        html: true,
        trigger: "manual"
      });
      $("#date-popover").hide();
      $("#date-popover").click(function(e) {
        $(this).hide();
      });

      $("#my-calendar").zabuto_calendar({
        action: function() {
          return myDateFunction(this.id, false);
        },
        action_nav: function() {
          return myNavFunction(this.id);
        },
        ajax: {
          url: "show_data.php?action=1",
          modal: true
        },
        legend: [{
            type: "text",
            label: "Special event",
            badge: "00"
          },
          {
            type: "block",
            label: "Regular event",
          }
        ]
      });
    });

    function myNavFunction(id) {
      $("#date-popover").hide();
      var nav = $("#" + id).data("navigation");
      var to = $("#" + id).data("to");
      console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
    }
  </script> -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script> 
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 <script type="text/javascript">
	// chart.js 
	// chart colors 
	var colors = ['red','skyblue','yellowgreen','#c3e6cb','#dc3545','#6c757d'];  
	
	/* 3 donut charts */ 
	var donutOptions = { 
			cutoutPercentage: 30, //도넛두께 : 값이 클수록 얇아짐 
			legend: {display:false}  // 라벨(범례) 안보이게 하기
/* 			legend: {position:'bottom', padding:5, labels: {pointStyle:'circle', usePointStyle:true}} 라벨 하단에 위치, 동그라미모양 */
	};
	
	// donut 1 
	/* var chDonutData1 = { 
			labels: ['Bootstrap', 'Popper', 'Other'], 
			datasets: [ 
				{ 
					backgroundColor: colors.slice(0,3), 
					borderWidth: 0, 
					data: [74, 11, 40] 
				} 
			] 
	};  
	
	var chDonut1 = document.getElementById("chDonut1"); 
	if (chDonut1) { 
		new Chart(chDonut1, { 
			type: 'pie', 
			data: chDonutData1, 
			options: donutOptions 
		}); 
	}  */  
	
	// line chart - 데이터 불러오기
	var label = [];
	var datas = [];
	
	<c:forEach items="${list }" var="memData">
		label.push({date:"${memData.member_credate}"});
		datas.push({sign:"${memData.member_id}"});
	</c:forEach>
	
	console.log(JSON.stringify(label[0].date));
	console.log(label.length);
	
	function randomColor(label) {
		var rancolors = [];
		for (let i = 0; i < label.length; i++) {
			rancolors.push("#" + Math.round(Math.random() * 0xffffff).toString(16));
		}
		return rancolors;
	}
	
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
 					lineTension: 0,		// 직선 그래프
					data: [datas[0].sign, datas[1].sign, datas[2].sign, datas[3].sign, datas[4].sign]
				} 
			] 
	};  
	
	var chLine = document.getElementById("chLine"); 
	if (chLine) { 
		new Chart(chLine, { 
			type: 'line', 
			data: chLineData2, 
			options: donutOptions 
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