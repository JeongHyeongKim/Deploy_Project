<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	@media (max-width: 768px) { 
		.mobileDisabled{display:none;}
	}
	.chart{
	min-height:200px;
	}
	
</style>



 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        예약 통계
        <small>Statistics</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">예약 관리</a></li>
        <li class="active">통계</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">

        <!-- /.col (LEFT) -->
        <div class="col-md-12">

          <!-- BAR CHART -->
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">그래프 시각화</h3><br>
              <h3 class="box-title">　</h3>
			    <form id="availableRoomListForm" method="get" action="/stats/statsFiltering">           
			   
			
				
					<div class="col-md-4">
						<div class="form-group">
							<label>근무지명</label> <select name="buildingSelect" class="form-control">
								<option value="전체">전체</option>
								<c:forEach var="buildingDTO" items="${buildingList}">
									<option value="${buildingDTO.buildName}"   ${buildingDTO.buildName == param.buildingSelect ? 'selected="selected"'  :   '' }>${buildingDTO.buildName}</option>

								</c:forEach>
							</select>
						</div>
					</div>
				
				
				
				
				
				
				
					<div class="col-md-4">
						<div class="form-group">
							<label>부서명</label> <select name="deptSelect" class="form-control">
								<option value="전체" >전체</option>
								<c:forEach var="departmentDTO" items="${departmentList}">
									<option value="${departmentDTO.deptName}"   ${departmentDTO.deptName == param.deptSelect ? 'selected="selected"'  :   '' } >${departmentDTO.deptName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label>회의실구분</label> <select name="roomTypeSelect" class="form-control">
								<option value="전체">전체</option>
								<c:forEach var="roomtype" items="${roomTypes}">
									<option value="${roomtype}"  ${roomtype == param.roomTypeSelect ? 'selected="selected"'  :   '' } >${roomtype}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
				
				
					<div class="col-md-8">
						
						<!-- Date and time range -->
						<div class="form-group">
							<label>검색 범위 (하루라도 포함되면 리스트로 출력)</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-clock-o"></i>
								</div>
								<input type="text" class="form-control pull-right"
									name="timeSelect" id="reservationtime" value='전체'>
							</div>
							<!-- /.input group -->
						</div>
				
					</div>
				
					<div class="col-md-4">
						<div class="form-group">
							<label>검색하기</label> <input type="submit"
								class="btn  btn-info col-sm-12" value="검색">
						</div>
					</div>
				
</form>

	
              <div class="box-tools pull-right">
             
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>
            
            <div class="box-body">
            <div class="col-md-12">
            <br>
            	<table class="table table-bordered table-striped">
            	
              		<tr>
              			<td>
              				<label> 검색 필터 - 근무지 : ${filterMap.buildingSelect}, 부서명: ${filterMap.deptSelect}, 회의실구분: ${filterMap.roomTypeSelect}, 날짜: ${filterMap.timeSelectStart} ~ ${filterMap.timeSelectEnd} </label>　최종 승인된 회의 데이터와, 해당되는 회의실만 시각화됩니다. 빈도는 사용 일수로 카운팅합니다.
  						<td>
  						
              		</tr>
              		
              	</table>
              	<br>
              <div class="chart">
                <canvas id="barChart" style="height:300px"></canvas>
              </div>
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
          
          
        






<div class="box box-primary">
<!-- /.content-wrapper -->	
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
					<!-- /.box-header -->
					<h4 class="box-title">필터링된 데이터</h4>
					<div class="box-body">
					
						<table id="example1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th class = "mobileDisabled">근무지명</th>
									<th class = "">신청부서</th>
									<th class = "">회의실명</th>
									<th class = "mobileDisabled">예약자명</th>
									<th  class = "mobileDisabled">회의시작</th>
									<th  class = "mobileDisabled">회의끝</th>
									<th class = "">회의제목</th>
									<th class = "">승인여부</th>
								</tr>
							</thead>
							<tbody>
					              <c:forEach var="histDTO" items="${historyList}">
										<tr>
											
												<td class = "mobileDisabled">${histDTO.buildName}</td>
												<td>${histDTO.deptName}</td>
												<td>${histDTO.roomName}</td>
												<td class = "mobileDisabled">${histDTO.empName} ${histDTO.empPosition}</td>
												<td class = "mobileDisabled">${histDTO.startDate}</td>
												<td class = "mobileDisabled">${histDTO.endDate}</td>
												<td>${histDTO.title}</td>
												<td>
													<c:if test='${histDTO.approval2Yn==1}'><span style="color: #00a7d0;">최종승인</span></c:if>
													<c:if test='${histDTO.approval1Yn==1 && histDTO.approval2Yn==0}'><span style="color: #008d4c  ;">1차승인</span></c:if>
													<c:if test='${histDTO.approval1Yn==0 && histDTO.reason==null}'><span style="color: #db8b0b ;">미승인</span></c:if>
													<c:if test='${histDTO.reason!=null}'><span style="color: #d33724;">반려</span></c:if>
												</td>
											
										</tr>
									</c:forEach>
				                </tbody>
				                <tfoot>
				           <!--      <tr>
									<th class = "">근무지명</th>
									<th class = "">신청부서</th>
									<th class = "">회의실명</th>
									<th class = "">예약자명</th>
									<th class = "">시작날짜</th>
									<th class = "">끝날짜</th>
									<th class = "">회의종류</th>
									<th class = "">상세보기</th>
				                </tr> -->
				                </tfoot>
						</table>
					</div>
					<!-- /.box-body -->
				<!-- /.box -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</section>
	<!-- /.content -->
</div>










        </div>
        <!-- /.col (RIGHT) -->
      </div>
      <!-- /.row -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  
  
  
  
  
  

<%-- <!-- page script -->
<script>
  $(function () {
    /* ChartJS
     * -------
     * Here we will create a few charts using ChartJS
     */

    //--------------
    //- AREA CHART -
    //--------------

    // Get context with jQuery - using jQuery's .get() method.
    var areaChartCanvas = $('#areaChart').get(0).getContext('2d')
    // This will get the first returned node in the jQuery collection.
    var areaChart       = new Chart(areaChartCanvas)

    var areaChartData = {
      labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
      datasets: [
        {
          label               : 'Electronics',
          fillColor           : 'rgba(210, 214, 222, 1)',
          strokeColor         : 'rgba(210, 214, 222, 1)',
          pointColor          : 'rgba(210, 214, 222, 1)',
          pointStrokeColor    : '#c1c7d1',
          pointHighlightFill  : '#fff',
          pointHighlightStroke: 'rgba(220,220,220,1)',
          data                : [65, 59, 80, 81, 56, 55, 40]
        },
        {
          label               : 'Digital Goods',
          fillColor           : 'rgba(60,141,188,0.9)',
          strokeColor         : 'rgba(60,141,188,0.8)',
          pointColor          : '#3b8bba',
          pointStrokeColor    : 'rgba(60,141,188,1)',
          pointHighlightFill  : '#fff',
          pointHighlightStroke: 'rgba(60,141,188,1)',
          data                : [28, 48, 40, 19, 86, 27, 90]
        }
      ]
    }

    var areaChartOptions = {
      //Boolean - If we should show the scale at all
      showScale               : true,
      //Boolean - Whether grid lines are shown across the chart
      scaleShowGridLines      : false,
      //String - Colour of the grid lines
      scaleGridLineColor      : 'rgba(0,0,0,.05)',
      //Number - Width of the grid lines
      scaleGridLineWidth      : 1,
      //Boolean - Whether to show horizontal lines (except X axis)
      scaleShowHorizontalLines: true,
      //Boolean - Whether to show vertical lines (except Y axis)
      scaleShowVerticalLines  : true,
      //Boolean - Whether the line is curved between points
      bezierCurve             : true,
      //Number - Tension of the bezier curve between points
      bezierCurveTension      : 0.3,
      //Boolean - Whether to show a dot for each point
      pointDot                : false,
      //Number - Radius of each point dot in pixels
      pointDotRadius          : 4,
      //Number - Pixel width of point dot stroke
      pointDotStrokeWidth     : 1,
      //Number - amount extra to add to the radius to cater for hit detection outside the drawn point
      pointHitDetectionRadius : 20,
      //Boolean - Whether to show a stroke for datasets
      datasetStroke           : true,
      //Number - Pixel width of dataset stroke
      datasetStrokeWidth      : 2,
      //Boolean - Whether to fill the dataset with a color
      datasetFill             : true,
      //String - A legend template
      legendTemplate          : '<ul class="<%=name.toLowerCase()%>-legend"><% for (var i=0; i<datasets.length; i++){%><li><span style="background-color:<%=datasets[i].lineColor%>"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>', 
      //Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
      maintainAspectRatio     : true,
      //Boolean - whether to make the chart responsive to window resizing
      responsive              : true
    }

    //Create the line chart
    areaChart.Line(areaChartData, areaChartOptions)

    //-------------
    //- LINE CHART -
    //--------------
    var lineChartCanvas          = $('#lineChart').get(0).getContext('2d')
    var lineChart                = new Chart(lineChartCanvas)
    var lineChartOptions         = areaChartOptions
    lineChartOptions.datasetFill = false
    lineChart.Line(areaChartData, lineChartOptions)

    //-------------
    //- PIE CHART -
    //-------------
    // Get context with jQuery - using jQuery's .get() method.
    var pieChartCanvas = $('#pieChart').get(0).getContext('2d')
    var pieChart       = new Chart(pieChartCanvas)
    var PieData        = [
      {
        value    : 700,
        color    : '#f56954',
        highlight: '#f56954',
        label    : 'Chrome'
      },
      {
        value    : 500,
        color    : '#00a65a',
        highlight: '#00a65a',
        label    : 'IE'
      },
      {
        value    : 400,
        color    : '#f39c12',
        highlight: '#f39c12',
        label    : 'FireFox'
      },
      {
        value    : 600,
        color    : '#00c0ef',
        highlight: '#00c0ef',
        label    : 'Safari'
      },
      {
        value    : 300,
        color    : '#3c8dbc',
        highlight: '#3c8dbc',
        label    : 'Opera'
      },
      {
        value    : 100,
        color    : '#d2d6de',
        highlight: '#d2d6de',
        label    : 'Navigator'
      }
    ]
    var pieOptions     = {
      //Boolean - Whether we should show a stroke on each segment
      segmentShowStroke    : true,
      //String - The colour of each segment stroke
      segmentStrokeColor   : '#fff',
      //Number - The width of each segment stroke
      segmentStrokeWidth   : 2,
      //Number - The percentage of the chart that we cut out of the middle
      percentageInnerCutout: 50, // This is 0 for Pie charts
      //Number - Amount of animation steps
      animationSteps       : 100,
      //String - Animation easing effect
      animationEasing      : 'easeOutBounce',
      //Boolean - Whether we animate the rotation of the Doughnut
      animateRotate        : true,
      //Boolean - Whether we animate scaling the Doughnut from the centre
      animateScale         : false,
      //Boolean - whether to make the chart responsive to window resizing
      responsive           : true,
      // Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
      maintainAspectRatio  : true ,
      //String - A legend template
      legendTemplate       : '<ul class="<%=name.toLowerCase()%>-legend"><% for (var i=0; i<segments.length; i++){%><li><span style="background-color:<%=segments[i].fillColor%>"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>'
     }
    //Create pie or douhnut chart
    // You can switch between pie and douhnut using the method below.
    pieChart.Doughnut(PieData, pieOptions)

    //-------------
    //- BAR CHART -
    //-------------
    var barChartCanvas                   = $('#barChart').get(0).getContext('2d')
    var barChart                         = new Chart(barChartCanvas)
    var barChartData                     = areaChartData
    barChartData.datasets[1].fillColor   = '#00a65a'
    barChartData.datasets[1].strokeColor = '#00a65a'
    barChartData.datasets[1].pointColor  = '#00a65a'
    var barChartOptions                  = {
      //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
      scaleBeginAtZero        : true,
      //Boolean - Whether grid lines are shown across the chart
      scaleShowGridLines      : true,
      //String - Colour of the grid lines
      scaleGridLineColor      : 'rgba(0,0,0,.05)',
      //Number - Width of the grid lines
      scaleGridLineWidth      : 1,
      //Boolean - Whether to show horizontal lines (except X axis)
      scaleShowHorizontalLines: true,
      //Boolean - Whether to show vertical lines (except Y axis)
      scaleShowVerticalLines  : true,
      //Boolean - If there is a stroke on each bar
      barShowStroke           : true,
      //Number - Pixel width of the bar stroke
      barStrokeWidth          : 2,
      //Number - Spacing between each of the X value sets
      barValueSpacing         : 5,
      //Number - Spacing between data sets within X values
      barDatasetSpacing       : 1,
      //String - A legend template
       legendTemplate          : '<ul class="<%=name.toLowerCase()%>-legend"><% for (var i=0; i<datasets.length; i++){%><li><span style="background-color:<%=datasets[i].fillColor%>"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>',
       //Boolean - whether to make the chart responsive
      responsive              : true,
      maintainAspectRatio     : true
    }

    barChartOptions.datasetFill = false
    barChart.Bar(barChartData, barChartOptions)
  })
</script> --%>







<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script> 
<script type="text/javascript"> 

var roomnamelist = new Array();
<c:forEach var="frequencyDTO" items="${frequencyList}">
	var str;
	str="${frequencyDTO.roomName}";
	roomnamelist.push(str);
</c:forEach>
console.log(roomnamelist)

var countlist = new Array();
<c:forEach var="frequencyDTO" items="${frequencyList}">
	var str;
	str="${frequencyDTO.countint}";
	countlist.push(str);
</c:forEach>
console.log(countlist)

var allcountlist = new Array();
<c:forEach var="allfrequencyDTO" items="${allFrequencyList}">
	var str;
	str="${allfrequencyDTO.countint}";
	allcountlist.push(str);
</c:forEach>
console.log(allcountlist)



var barChartData = {        
        labels: roomnamelist,
        datasets: [{
            label: '같은 기간 중 전체부서 사용빈도 합',
            backgroundColor: "#dddddd",
            data: allcountlist
        }, {
            label: '선택한 부서의 사용빈도',
            backgroundColor: "#3c8dbc",
            data: countlist
        }]
    };
    
    
 window.onload = function() {
    var ctx = $('#barChart').get(0).getContext("2d"); 
    window.theChart = new Chart(ctx, {
         type: 'bar',
         data: barChartData,
         options: {
        	 
             scales: { //X,Y축 옵션
            	 scaleSteps : 1,
                 yAxes: [{
                     ticks: {
                         beginAtZero:true,  //Y축의 값이 0부터 시작
                         /* stepSize: 1 */
                     }
                 }]
             }
         }
 });
}
</script>









<script>
	$(function() {


		//파라미터로 전에 선택한 필터링 날짜 가져오기
		var timeSelectParam = "${param.timeSelect}";
		timeSelectParam = timeSelectParam.replace(/(\s*)/g,"");
		var startDateStr = timeSelectParam.split('-')[0];
		var endDateStr = timeSelectParam.split('-')[1];

		//파라미터 없으면 1년전~오늘
		if(timeSelectParam=="") {
			startDateStr= moment().add(-1, 'year');
			endDateStr= moment().add(0, 'year');
		};
		
		
		/** DatePicker **/
		//Date range picker with time picker
		$('#reservationtime').daterangepicker({
			timePicker : false,
			format : 'YYYY/MM/DD',
			locale: {format : 'YYYY/MM/DD'},
			startDate: startDateStr,
	      	endDate: endDateStr
	      	
		})
		

	})
</script>

<script>
	$(function() {
		$('#example1').DataTable({
			'paging' : true,
			'lengthChange' : true,
			'searching' : true,
			'ordering' : true,
			'info' : true,
			'autoWidth' : true,
			"order": [[ 4, "desc" ]]
		})
	})
</script>


