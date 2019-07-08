<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function(){
	var email;
	var resDate;
	var resStartDate;
	var resEndDate;
	
	var empName;
	var myInfo = JSON.parse('${resListForHead}');
	//이메일 보낼것들
	var tempEmail;
	var tempResStartDate;
	var tempResEndDate;
	var tempResCost;
	var tempHeadEmail;
	var tempResDate;
	var tempEmpName;
	function drawPage(myInfo){
	
		$("#meetingList").empty();
		/* meetingList  */
		var $meetingList = $("#meetingList");
		var $divCol12 = $("<div></div>").attr("class","card mb-3").appendTo($meetingList);
		/* 카드 헤더 */
		var $divTile = $("<div></div>").attr("class","card-header").appendTo($divCol12);
		var $divItag = $("<i></i>").attr("class","fa fa-table").text("회의실 예약 현황").appendTo($divTile);
		$("<input  type='hidden' id='adminId'  autocomplete='off' >").appendTo($divItag);
		/* 카드 바디 */
		var $divCard = $("<div class='card-body'></div>").appendTo($divCol12);
		var $divRes = $("<div class='table-responsive'></div>").appendTo($divCard);
		
		var $tableTag = $("<table class='table table-bordered' id='dataTable' width='100%' cellspacing='0'></table>").appendTo($divRes);
		
		var $headTag = $("<thead></thead>").appendTo($tableTag);
		var $headTrTag= $("<tr></tr>").appendTo($headTag);
		$("<th></th>").text("예약일").appendTo($headTrTag);
		$("<th></th>").text("사용일").appendTo($headTrTag);
		$("<th></th>").text("부서").appendTo($headTrTag);
		$("<th></th>").text("신청자").appendTo($headTrTag);
		$("<th></th>").text("장소").appendTo($headTrTag);
		$("<th></th>").text("회의목적").appendTo($headTrTag);
		$("<th></th>").text("상태").appendTo($headTrTag);
		$("<th></th>").text("변경").appendTo($headTrTag);
		
		var $bodyTag = $("<tbody></tbody>").appendTo($tableTag);
		$.each(myInfo, function(i, $list) {
			resCost = $list.resCost;
			email = $list.empEmail;
			empName = $list.empName;
			resStartDate = $list.resStartDate;
			resEndDate = $list.resEndDate;
			deptId= $list.deptId;
			var $bodyTrTag= $("<tr></tr>").appendTo($bodyTag);
			
			$("<td id='resDate' class='showAllInfo'></td>").attr("value",$list.resDate).text($list.resDate).appendTo($bodyTrTag);
			$("<td id='resStartDate' class='showAllInfo'></td>").attr("value",$list.resStartDate).text($list.resStartDate+" ~ "+$list.resEndDate).appendTo($bodyTrTag);
			$("<td></td>").attr("class","showAllInfo deptId").text($list.deptName).appendTo($bodyTrTag);
			$("<td></td>").attr("class","showAllInfo").text($list.empName).appendTo($bodyTrTag);
			$("<td></td>").attr("class","showAllInfo").text(($list.brName) + " - " + ($list.mrName)).appendTo($bodyTrTag);
			$("<td></td>").attr("class","showAllInfo").text($list.resPurpose).appendTo($bodyTrTag);

			var $currentState = $("<td data-toggle='modal' data-target='#detail'></td>").text("1차승인대기").appendTo($bodyTrTag);
			var $changeState = $("<td></td>").appendTo($bodyTrTag);
			
			
			if($list.resState=="res_0"){
				var $divChange = $("<div></div>").attr("class","bs-component").appendTo($changeState);
				var $urChange = $("<ul></ul>").attr("class","nav nav-pills").appendTo($divChange);
				var $liChange = $("<li></li>").attr("class","nav-item dropdown").appendTo($urChange);
				$("<a id='"+$list.resId+"' data-toggle='dropdown' href='#' role='button' aria-haspopup='true' aria-expanded='false'></a>").attr("class","nav-link dropdown-toggle").text("상태").appendTo($liChange);
				var $divDropdown = $("<div></div>").attr("class","dropdown-menu showAllInfo").appendTo($liChange);
				
				$("<a id='approval' value='"+$list.resId+"'></a>").attr("class","dropdown-item").text("승인").appendTo($divDropdown);
				$("<a id='back' value='"+$list.resId+"'></a>").attr("class","dropdown-item").text("반려").appendTo($divDropdown);
				
			}
			
		});
	
		/* 카드푸터  */
		var $divFooter = $("<div class='card-footer small text-muted'></div>").appendTo($divCol12);	
	}
	
	drawPage(myInfo);
	
	$(document).on('click', '.nav-link', function(e){
		currentResId=e.currentTarget.id;
		
		for(var i =0; i<myInfo.length;i++){
			if(myInfo[i].resId==currentResId){
				tempEmail =myInfo[i].empEmail;
				tempResStartDate=myInfo[i].resStartDate;
				tempResEndDate=myInfo[i].resEndDate;
				tempResCost=myInfo[i].resCost;
				tempResDate=myInfo[i].resDate;
				tempEmpName=myInfo[i].empName;
			}
		}
		console.log(tempEmail);
		console.log(tempResStartDate);
		console.log(tempResEndDate);
		console.log(tempResCost);
		console.log(tempResDate);
		console.log(tempEmpName);
		/* resDate=$('#resDate').attr("value");
		resStartDate=$('#resStartDate').attr("value"); 
		console.log("resStartDate: "+resStartDate);  
		console.log("resDate: "+resDate); */
	})
	//금액에 콤마
	function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
	$('#approval').on("click",function(e){
		var adminId = $("#adminId").attr("value");
		console.log(adminId)
	    console.log("deptId: "+deptId); 
		console.log("resCost: "+resCost);  
		console.log("Email: "+email);
		swal({
      		title: "승인하시겠습니까?",
      		type: "warning",
      		showCancelButton: true,
      		confirmButtonText: "네",
      		cancelButtonText: "아뇨",
      		closeOnConfirm: false,
      		closeOnCancel: false
      	}, function(isConfirm) {
      		if (isConfirm) {
      		  resId =  $("#approval").attr("value");
      		   var str="[회의실 예약 승인 알림]\n"+tempResDate+"에 "+tempEmpName+"님이 예약 신청하신 회의실 예약이 1차 승인되었습니다.\n 사용 일정)\n"+tempResStartDate+" ~ "+tempResEndDate+"\n 비용)\n"+comma(tempResCost)+"(원)";
      			$.ajax({
					  url : "/meeting/recognition/approvalByHead/"+resId,
					  type : "post",
					  data:"_csrf=${_csrf.token}"+"&str="+str+"&email="+tempEmail+"&adminId="+adminId,
					  success:function(){
						  location.href= "/meeting/recognition/waitForRecognitionByHead"
					  }, error:function(){
		                	console.log("error");
		              }
				});
      			swal("승인 완료!", "해당 예약 정보가 승인되었습니다.", "success");
      		} else {
      			swal("승인 취소!", "해당 예약 정보가 승인 되지 않았습니다.", "error");
      		}
      	});
	});
	$('#back').on("click",function(e){
		var adminId = $("#adminId").attr("value");
		swal({
			  title: "반려하시겠습니까?",
			  text: "반려 사유를 입력해주십시오(메일 발송):",
			  type: "input",
			  showCancelButton: true,
			  closeOnConfirm: false,
			  animation: "slide-from-top",
			  inputPlaceholder: "반려 사유를 입력해주십시오"
			},
			function(inputValue){
			  if (inputValue === false) return false;
				
			  if (inputValue === "") {
			    swal.showInputError("반려 사유가 입력되지 않았습니다!");
			    return false
			  }
			  var str="[회의실 예약 반려 알림]\n"+tempResDate+"에 예약 신청하신 회의실 예약이 해당 사유로 인해 [1차 승인]에서 반려되었습니다.\n반려사유)\n";
			  str+=inputValue;
			  resId =  $("#back").attr("value");	   
      			$.ajax({
					  url : "/meeting/recognition/backByHead/"+resId,
					  type : "post",
					  data:"_csrf=${_csrf.token}"+"&str="+str+"&email="+tempEmail+"&adminId="+adminId+"&inputValue="+inputValue,
					  success:function(){
						  location.href= "/meeting/recognition/waitForRecognitionByHead"
					  }, error:function(){
		                	console.log("error");
		              }
				});
			  swal("반려 및 메일 전송 완료!", "You wrote: " + inputValue, "success");
			});
	});	
	$.ajax({
        url:"/meeting/users/getCurrentId",
        method :"post",
        data : "_csrf=${_csrf.token}",
        success : function(data){
           var emp = data
           $('#adminId').attr("value",emp.empId);
           console.log(emp.empName);
        }
     })
});
</script>
<main class="app-content">
	<div class="app-title">
		<div>
			<h1><i class="fa fa-calendar"></i>승인 대기 목록</h1>
			<p>
				1차 승인 대기 목록입니다.
			</p>
		</div>
		<ul class="app-breadcrumb breadcrumb">
			<li class="breadcrumb-item">
			<i class="fa fa-home fa-lg"></i>
			</li>
			<li class="breadcrumb-item">
			<a href="#">승인 대기 목록</a>
			</li>
		</ul>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="tile">
				<div class="tile-body">
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
<script type="text/javascript" src="/meeting/resources/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="/meeting/resources/js/plugins/sweetalert.min.js"></script>