<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
	$(function(){
		var today = new Date();
		var todayMonth = today.getMonth()+1;
		document.getElementById ( 'month' ).innerHTML=todayMonth;
		var resId;
		var myInfo = JSON.parse('${myInfo}');
		var myCost = JSON.parse('${myCost}');
		var mySchedule = JSON.parse('${mySchedule}');  
		document.getElementById ( 'cntSchedule' ).innerHTML=mySchedule.length;
		var currentResCost;
		var currentDeptId;
		
		function drawMySchedule(mySchedule){
			$("#meetingInfo").empty(); 
			var $meetingInfo = $("#meetingInfo");
			if(mySchedule.length==0){
				$("<h4></h4>").attr("class","tile-title").text("예정된 회의가 없습니다.").appendTo($meetingInfo);
			}
			$.each(mySchedule, function(i, $list) {	
				if(i==0){
					$("<h3></h3>").attr("class","tile-title").text($list.resStartDate).appendTo($meetingInfo);
					$("<h3></h3>").attr("class","tile-title").text($list.brName+" - "+$list.mrName).appendTo($meetingInfo);
				}else{
					$("<h3></h3>").attr("class","tile-title").appendTo($meetingInfo);
					$("<h3></h3>").attr("class","tile-title").appendTo($meetingInfo);
				}			
			});
		}
		
		
		$("#deptCost").text(comma(myCost) +"(원)");
		
		
		function drawListPeriod(myInfo){
			$("#listCondition").empty(); 
			/* listCondition  */
			var $listCondition = $("#listCondition");
			var $divDataToggle = $("<div data-toggle='buttons'></div>").attr("class","btn-group btn-group-toggle").appendTo($listCondition);
			
			var $allOfList = $("<label id='allOfList'></label>").attr("class","btn btn-primary active").text("전체").appendTo($divDataToggle);
			$("<input id='allOfList' type='radio' name='listPeriod' value='all' autocomplete='off' checked=''>").appendTo($allOfList);
			
			
			var $weekLabel = $("<label id='oneWeek'></label>").attr("class","btn btn-primary").text("일주일").appendTo($divDataToggle);
			$("<input id='oneWeek' type='radio' name='listPeriod'  autocomplete='off'>").appendTo($weekLabel);
			
			var $onemonthLabel = $("<label id='oneMonth'></label>").attr("class","btn btn-primary").text("1개월").appendTo($divDataToggle);
			$("<input id='oneMonth' type='radio' name='listPeriod' autocomplete='off'>").appendTo($onemonthLabel);
			
			var $sixmonthLabel = $("<label id='sixMonth'></label>").attr("class","btn btn-primary").text("6개월").appendTo($divDataToggle);
			$("<input id='sixMonth' type='radio' name='listPeriod'  autocomplete='off'>").appendTo($sixmonthLabel);
			
			var $yearList = $("<label id='yearList'></label>").attr("class","btn btn-primary").text("1년").appendTo($divDataToggle);
			$("<input id='yearList' type='radio' name='listPeriod'  autocomplete='off'>").appendTo($yearList);
		}
		
		
		function drawPage(myInfo){

			$("#meetingList").empty();
			/* meetingList  */
			var $meetingList = $("#meetingList");
			var $divCol12 = $("<div></div>").attr("class","card mb-3").appendTo($meetingList);
			/* 카드 헤더 */
			var $divTile = $("<div></div>").attr("class","card-header").appendTo($divCol12);
			var $divItag = $("<i></i>").attr("class","fa fa-table").text("회의실 예약 현황").appendTo($divTile);
			
			/* 카드 바디 */
			var $divCard = $("<div class='card-body'></div>").appendTo($divCol12);
			var $divRes = $("<div class='table-responsive'></div>").appendTo($divCard);
			
			var $tableTag = $("<table class='table table-hover table-bordered' id='dataTable' width='100%' cellspacing='0'></table>").appendTo($divRes);
			
			var $headTag = $("<thead></thead>").appendTo($tableTag);
			var $headTrTag= $("<tr></tr>").appendTo($headTag);
			$("<th></th>").text("예약일").appendTo($headTrTag);
			$("<th></th>").text("사용일").appendTo($headTrTag);
			$("<th></th>").text("장소").appendTo($headTrTag);
			$("<th></th>").text("상태").appendTo($headTrTag);
			$("<th></th>").text("변경").appendTo($headTrTag);
			
			var $bodyTag = $("<tbody></tbody>").appendTo($tableTag);
			
			$.each(myInfo, function(i, $list) {
				var $bodyTrTag= $("<tr></tr>").appendTo($bodyTag);
				$("<td></td>").text($list.resDate).appendTo($bodyTrTag);
				$("<td></td>").text($list.resStartTime+" ~ "+$list.resEndTime).appendTo($bodyTrTag);
				$("<td></td>").text(($list.brName) + " - " + ($list.mrName)).appendTo($bodyTrTag);
				var $currentState = $("<td></td>").text(mappingState($list.resState)).appendTo($bodyTrTag);
				var $changeState = $("<td></td>").appendTo($bodyTrTag);
				
				if(($list.resState=="res_0")||($list.resState=="res_1")||($list.resState=="res_2")){
					resId=$list.resId;
					var $divBtn = $("<div></div>").css("text-align","center").appendTo($changeState);  
					$("<button id='"+resId+"'></button>").attr("class","btn btn-info btn-sm").attr("value",$list.resCost).text("예약 취소").appendTo($divBtn); 
					 /* 이후 users로 패키지 변경 */
					$('#'+resId+'').on("click",function(e){
						currentResId=e.currentTarget.id;
						console.log(myInfo);
						
						for(var i =0; i<myInfo.length;i++){
							if(myInfo[i].resId==currentResId){
								currentResCost = myInfo[i].resCost;
								currentDeptId=myInfo[i].deptId;
								currentState = myInfo[i].resState;
								console.log(currentState);
							}
						}
						swal({
		    	      		title: "삭제하시겠습니까?",
		    	      		text: "삭제 시,해당 예약 정보 복원 불가",
		    	      		type: "warning",
		    	      		showCancelButton: true,
		    	      		confirmButtonText: "네, 삭제하겠습니다",
		    	      		cancelButtonText: "아뇨, 취소하겠습니다",
		    	      		closeOnConfirm: false,
		    	      		closeOnCancel: false
		    	      	}, function(isConfirm) {
		    	      		if (isConfirm) {
		    	      			$.ajax({
									  url : "/meeting/reservation/cancelRes/"+resId,
									  type : "post",
									  data:"_csrf=${_csrf.token}"+"&currentState="+currentState,
									  success:function(){
										  location.href= "/meeting/users/mypage"
									  }, error:function(){
						                	console.log("error")
						              }
								});
		    	      			swal("삭제 완료!", "해당 정보가 삭제되었습니다.", "success");
		    	      		} else {
		    	      			swal("삭제 취소!", "해당 정보가 삭제 되지 않았습니다.", "error");
		    	      		}
		    	      	});
					});
				}
			});
			/* 카드푸터  */
			var $divFooter = $("<div class='card-footer small text-muted'></div>").appendTo($divCol12);	
		}
		drawMySchedule(mySchedule);
		drawListPeriod(myInfo);
		drawPage(myInfo);
		//금액에 콤마
		function comma(str) {
	        str = String(str);
	        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	    }
		function mappingState(resState){
			var state = null;
			if(resState == "res_0"){
				return state = "1차승인대기"
			} else if(resState == "res_1"){
				return state = "2차승인대기"
			} else if(resState == "res_2"){
				return state = "예약완료"
			} else if(resState == "res_3"){
				return state = "반려된예약"
			} else if(resState == "res_4"){
				return state = "취소된예약"
			} else if(resState == "res_5"){
				return state = "사용종료"
			} else {
				return state = "미사용"
			} 
		}
		$(document).on('click', '.btn-primary', function(e){
		  
			  var searchtype = e.currentTarget.id;
			  $.ajax({
				  url : "/meeting/users/search/"+searchtype,
				  type : "post",
				  data:"_csrf=${_csrf.token}",
				  success:function(data){
					  var pageInfo = JSON.parse(data);
					  console.log(data);
					  // $('#meetingList').html(drawPage(myInfo));
					  drawPage(pageInfo);
					  $("#dataTable").DataTable();
				  }
			})
		}) 
		
		$('#dataTable').DataTable();
	})
</script>

 <script type="text/javascript" src="/meeting/resources/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="/meeting/resources/js/plugins/sweetalert.min.js"></script>
<main class="app-content">
	<div class="app-title">
		<div>
			<h1><i class="fa fa-calendar"></i>마이페이지</h1>
			<p>
				나의 회의실 예약 이력과 비용을 확인할 수 있습니다
			</p>
		</div>
		<ul class="app-breadcrumb breadcrumb">
			<li class="breadcrumb-item">
				<i class="fa fa-home fa-lg"></i>
			</li>
			<li class="breadcrumb-item">
				<a href="/meeting/users/mypage">예약이력</a>
			</li>
		</ul>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="tile" style="width:100%;height:250px">
				<p><b id="month"></b>월달에 총 <b id="cntSchedule"></b>번의 회의일정이 있습니다.</p>
				<p>예정된 회의실 사용일정 : </p>
				<hr>
				<div id="meetingInfo" style="float:left;">
				</div>
				
				<div id="deptCostInfo" style="float:right;text-align:right">
					<h4 class="tile-title">부서별 연간 누적금액</h4>
					<h3 class="tile-title" id="deptCost"></h3>
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="tile">
				<div class="tile-body">
					<div class="bs-component" style="margin-bottom: 15px;" id="listCondition">
						
					</div>
				     <div id="meetingList">
		
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<script src="/meeting/resources/js/datatables/jquery.dataTables.js"></script>
<script src="/meeting/resources/js/datatables/dataTables.bootstrap4.js"></script>
<script src="/meeting/resources/js/plugins/sb-admin-datatables.min.js"></script>
<script src="/meeting/resources/js/plugins/sweetalert.min.js"></script>

