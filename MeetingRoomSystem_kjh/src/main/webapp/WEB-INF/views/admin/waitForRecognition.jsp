<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(function(){
		var resId;
		var myInfo = JSON.parse('${resList}');
		var branchList = JSON.parse('${branchList}');
		var equipList = JSON.parse('${equipList}');
		var recogList = JSON.parse('${recogList}');
		var searchtype ;
		var brId ;
		var email;
		var resDate;
		var resStartDate;
		var resEndDate;
		var deptId;
		var resCost;
		var headEmail;
		var empName;
		
		//이메일 보낼것들
		var tempEmail;
		var tempResStartDate;
		var tempResEndDate;
		var tempResCost;
		var tempHeadEmail;
		var tempResDate;
		var tempEmpName;
		
		function drawListBranch(branchList){
			$("#listCondition").empty(); 
			$("#listBranch").empty(); 
			var $listCondition = $("#listCondition");
			var $divDataToggle = $("<div data-toggle='buttons'></div>").attr("class","btn-group btn-group-toggle").appendTo($listCondition);
			
			var $allOfList = $("<label id='allOfList'></label>").attr("class","btn btn-primary prBtn active").text("전체").appendTo($divDataToggle);
			$("<input id='al' class='listPeriod' type='radio'   autocomplete='off' checked=''>").appendTo($allOfList);

			var $weekLabel = $("<label id='oneWeek'></label>").attr("class","btn btn-primary prBtn").text("일주일").appendTo($divDataToggle);
			$("<input id='ow'  class='listPeriod'type='radio'   autocomplete='off'>").appendTo($weekLabel);
			
			var $onemonthLabel = $("<label id='oneMonth'></label>").attr("class","btn btn-primary prBtn").text("1개월").appendTo($divDataToggle);
			$("<input  class='listPeriod' type='radio'  autocomplete='off'>").appendTo($onemonthLabel);
			
			var $sixmonthLabel = $("<label id='sixMonth'></label>").attr("class","btn btn-primary prBtn").text("6개월").appendTo($divDataToggle);
			$("<input  class='listPeriod' type='radio'  autocomplete='off'>").appendTo($sixmonthLabel);
			
			var $yearList = $("<label id='yearList'></label>").attr("class","btn btn-primary prBtn").text("1년").appendTo($divDataToggle);
			$("<input  class='listPeriod' type='radio'   autocomplete='off'>").appendTo($yearList);
			/* listCondition  */
			var $listBranch = $("#listBranch");
			var $divDataToggle = $("<div data-toggle='buttons'></div>").attr("class","btn-group btn-group-toggle").appendTo($listBranch);
			
			var $allOfList =$("<label id='allBrId'></label>").attr("class","btn btn-primary brIdBtn active").text("전체").appendTo($divDataToggle);
			$("<input type='radio' name='listPeriod' value='all' autocomplete='off' >").appendTo($allOfList);
			$.each(branchList, function(i, $list) {
				$allOfList = $("<label id='"+$list.brId+"'></label>").attr("class","btn btn-primary brIdBtn").text($list.brName).appendTo($divDataToggle);
				$("<input  type='radio' name='listPeriod' value='all' autocomplete='off' >").appendTo($allOfList);
		    });
			$("<input  type='hidden' id='adminId'  autocomplete='off' >").appendTo($allOfList);
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
			$("<th></th>").text("신청자(부서명)").appendTo($headTrTag);
			$("<th></th>").text("장소").appendTo($headTrTag);
			$("<th></th>").text("상태").appendTo($headTrTag);
			$("<th></th>").text("변경").appendTo($headTrTag);
			
			var $bodyTag = $("<tbody></tbody>").appendTo($tableTag);
			$.each(myInfo, function(i, $list) {
				resCost = $list.resCost;
				headEmail = $list.headEmail;
				empName = $list.empName;
				resEndDate = $list.resEndDate;
				resDate = $list.resDate;
				resStartDate = $list.resStartDate;
				deptId= $list.deptId;
				
				var $bodyTrTag= $("<tr></tr>").appendTo($bodyTag);
				
				$("<td id='"+$list.resId+"' class='showAllInfo'></td>").attr("value",$list.resDate).text($list.resDate.substr(2,14)).appendTo($bodyTrTag);
				$("<td id='"+$list.resId+"' class='showAllInfo'></td>").attr("value",$list.resStartDate).text($list.resStartDate.substr(2,14)+" ~ "+$list.resEndDate.substr(2,14)).appendTo($bodyTrTag);
				$("<td id='"+$list.resId+"'></td>").attr("class","showAllInfo deptId").text($list.empName + "("+$list.deptName+")").appendTo($bodyTrTag);
				$("<td></td>").attr("class","showAllInfo").text(($list.brName) + " - " + ($list.mrName)).appendTo($bodyTrTag);
				
				var $currentState = $("<td data-toggle='modal' data-target='#detail'></td>").text(mappingState($list.resState)).appendTo($bodyTrTag);
				var $changeState = $("<td></td>").appendTo($bodyTrTag);
				
				
				
				if($list.resState=="res_1"){
					var $divChange = $("<div></div>").attr("class","bs-component").appendTo($changeState);
					var $urChange = $("<ul></ul>").attr("class","nav nav-pills").appendTo($divChange);
					var $liChange = $("<li></li>").attr("class","nav-item dropdown").appendTo($urChange);
					$("<a id='"+$list.resId+"' data-toggle='dropdown' href='#' role='button' aria-haspopup='true' aria-expanded='false'></a>").attr("class","nav-link dropdown-toggle").appendTo($liChange);
					var $divDropdown = $("<div></div>").attr("class","dropdown-menu showAllInfo").appendTo($liChange);
					
					$("<a id='approval' value='"+$list.resId+"'></a>").attr("class","dropdown-item").text("승인").appendTo($divDropdown);
					$("<a id='back' value='"+$list.resId+"'></a>").attr("class","dropdown-item").text("반려").appendTo($divDropdown);
					
				}
				
			});

			/* 카드푸터  */
			var $divFooter = $("<div class='card-footer small text-muted'></div>").appendTo($divCol12);	
		}
		 
		/* drawListPeriod(myInfo); */
		drawListBranch(branchList);
		drawPage(myInfo);
		console.log(recogList);
		$("#dataTable").DataTable({
			  "order":[[0,"desc"]]
		  });
		//Modal
		$('.showAllInfo').on("click",function(e){
			
			var resId = e.currentTarget.id
			var manId="승인자 없음";
			var deptHeadId="승인자 없음";
			var RecAcceptDate="승인 내역 없음";
			var recRefuse="-반려된 예약 아님-";
			for(var i=0;i<recogList.length;i++){
				console.log(recogList[i].recAcceptDate)
				if(recogList[i].resId==resId){
						var deptHeadIdTemp =recogList[i].deptHeadId; 
						console.log(deptHeadIdTemp)
						if(recogList[i].recRefuse==" "){						
							if(deptHeadIdTemp.includes("it") && recogList[i].manId==" "){ // 1차승인완료
								deptHeadId=recogList[i].deptHeadId;
								manId="2차승인없음";
							
								break;
							}else if(recogList[i].deptHeadId==" "&&recogList[i].manId==" "&&recogList[i].recAcceptDate==" "){ // 예약신청만
							
								RecAcceptDate="승인내역없음";
								break;
							}else{ // 2차 승인완료
								deptHeadId=recogList[i].deptHeadId;
								manId=recogList[i].manId;
								RecAcceptDate=recogList[i].recAcceptDate;
								break;
							}
					}else{
						recRefuse=recogList[i].recRefuse;
					}
				}
			}
			for(var i=0; i<myInfo.length; i++){
				
				var note;
				var beam;
				var white;
				var mic;
				
				if(equipList[myInfo[i].resId] == null){
					
					note = 0;
					beam = 0;
					white = 0;
					mic = 0;
				} else{
					
					note = equipList[myInfo[i].resId]['N'];
					beam = equipList[myInfo[i].resId]['V'];
					white = equipList[myInfo[i].resId]['W'];
					mic = equipList[myInfo[i].resId]['M'];
				}
					
				if(myInfo[i].resId == resId){
						
						var resAddRequest ="없음";
						if(myInfo[i].resAddRequest==(" ")){
							resAddRequest = "없음";
						}
					
						
						swal({
		 	      			title: "상세 예약 정보 확인",
		 	      			text: "\n [회의목적] "+myInfo[i].resPurpose+
		 	      		     	  "\n [회의구분] "+myInfo[i].resType+
		 	      		     	  "\n [사용비용] "+comma(myInfo[i].resCost)+"원"+
		 	      				  "\n [참석인원수] "+myInfo[i].resAttendCnt + "명"+
		 	      			 	  "\n [기자재]\n  노트북 " + note +"개/마이크 " + mic +"개/화이트보드 " + white +"개/빔프로젝터 " + beam+"개"+
		 	      			 	  "\n [추가요청사항]\n"+resAddRequest+
		 	      			 	  "\n[승인자 및 승인 날짜]\n"+deptHeadId+" / "+manId+" / "+RecAcceptDate+
		 	      			 	  "\n[반려사유]\n"+recRefuse
						 })		
					
				}	
			}
			
		}); 
		
		
		$(document).on('click', '.nav-link', function(e){
			currentResId=e.currentTarget.id;
			
			for(var i =0; i<myInfo.length;i++){
				if(myInfo[i].resId==currentResId){
					tempEmail =myInfo[i].empEmail;
					tempResStartDate=myInfo[i].resStartDate;
					tempResEndDate=myInfo[i].resEndDate;
					tempResCost=myInfo[i].resCost;
					tempHeadEmail=myInfo[i].HeadEmail;
					tempResDate=myInfo[i].resDate;
					tempEmpName=myInfo[i].empName;
				}
			}
			/* resDate=$('#resDate').attr("value");
			resStartDate=$('#resStartDate').attr("value"); 
			console.log("resStartDate: "+resStartDate);  
			console.log("resDate: "+resDate); */
		})
		
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
		$('#approval').on("click",function(e){
			
		    console.log("deptId: "+deptId); 
			console.log("resCost: "+resCost);  
			console.log("headEmail: "+headEmail);
			console.log("resStartDate: "+resStartDate);  
			console.log("resDate: "+resDate);
			
			
			var adminId = $("#adminId").attr("value");
			console.log("adminId: "+adminId);
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
	      		   var str="[회의실 예약 승인 알림]\n"+tempResDate+"에 "+tempEmpName+"님이 예약 신청하신 회의실 예약이 승인되었습니다.\n 사용 일정)\n"+tempResStartDate+" ~ "+tempResEndDate+"\n 비용)\n"+comma(tempResCost)+"(원)";
	      			$.ajax({
						  url : "/meeting/recognition/approval/"+resId,
						  type : "post",
						  data:"_csrf=${_csrf.token}"+"&str="+str+"&email="+tempEmail+"&deptId="+deptId+"&resCost="+resCost+"&headEmail="+headEmail+"&adminId="+adminId,
						  success:function(){
							  location.href= "/meeting/recognition/waitForRecognition"
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
				  var str="[회의실 예약 반려 알림]\n"+resDate+"에 예약 신청하신 회의실 예약이 해당 사유로 인해 반려되었습니다.\n반려사유)\n";
				  str+=inputValue;
				  resId =  $("#back").attr("value");	   
	      			$.ajax({
						  url : "/meeting/recognition/back/"+resId,
						  type : "post",
						  data:"_csrf=${_csrf.token}"+"&str="+str+"&email="+email+"&adminId="+adminId+"&inputValue="+inputValue,
						  success:function(){
							  location.href= "/meeting/recognition/waitForRecognition"
						  }, error:function(){
			                	console.log("error");
			              }
					});
				  swal("반려 및 메일 전송 완료!", "You wrote: " + inputValue, "success");
				});
		});	
		
		$(document).on('click', '.prBtn', function(e){
			 searchtype=e.currentTarget.id;
			 console.log(searchtype);
		})
		$(document).on('click', '.brIdBtn', function(e){
			brId=e.currentTarget.id;
			console.log(brId);
			btnClassClick();
		})
		//금액에 콤마
		function comma(str) {
	        str = String(str);
	        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	    }
		
        var btnClassClick = function(e){
		
        	$.ajax({
        	    url:"/meeting/recognition/searchByPeriod/searchtype="+searchtype+"&searchtypeByBranch="+brId,
        	    type:"post",
        	    data:"_csrf=${_csrf.token}",
        	    success:function(data){	
        	    	var pageInfo = JSON.parse(data);
					  drawPage(pageInfo);
					  $("#dataTable").DataTable();
					  
        	    }
        	   })
			   
        }
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
			<h1><i class="fa fa-calendar"></i>예약이력</h1>
			<p>
				회의실 예약 전체 현황 목록입니다.
			</p>
		</div>
		<ul class="app-breadcrumb breadcrumb">
			<li class="breadcrumb-item">
			<i class="fa fa-home fa-lg"></i>
			</li>
			<li class="breadcrumb-item">
			<a>예약이력</a>
			</li>
			<li class="breadcrumb-item">
			<a href="/meeting/recognition/waitForRecognition">예약현황</a>
			</li>
		</ul>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="tile">
				<div class="tile-body">
					<div class="bs-component" style="margin-bottom: 15px;" id="listCondition">
						
					</div>
					<div class="bs-component" style="margin-bottom: 15px;" id="listBranch">
					
					</div>
				     <div id="meetingList">
		
					</div>
					
					 <!-- <div class="modal fade" id="detail" role="dialog">
					    <div class="modal-dialog">
					      Modal content
					      <div class="modal-content">
					        <div class="modal-header">
					        	<h4 class="modal-title">예약 상세 정보</h4>
					        	<button type="button" class="close" data-dismiss="modal">×</button>
					        </div>
					        <div class="modal-body">
					         
					        </div>
					      </div>
				   	   </div>
         	        </div>  -->
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