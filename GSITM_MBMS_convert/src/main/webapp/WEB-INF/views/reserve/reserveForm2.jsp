<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>회의실 예약</h1>
		<ol class="breadcrumb">
			<li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">reserve</li>
		</ol>
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-md-8">
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">회의실 예약</h3>
					</div>
					<div class="box-body">
						<!-- 지사 선택 -->
						<div class="col-md-12">
							<div class="form-group">
								<div class="col-sm-6">
								<label for="buildingSelect">지사</label> 
									<select name="buildingSelect" id="buildingSelect" class="form-control" onchange="selectBuilding(this.options[this.selectedIndex].value)">
										<c:forEach var="building" items="${buildings }" varStatus="status">
											<c:if test="${status.first}">
												<option value="${building.buildNo }" selected="selected">${building.buildName }</option>
											</c:if>
											<c:if test="${!status.first}">
												<option value="${building.buildNo }">${building.buildName }</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-6">
									<label for="roomSelect">회의실</label>
									<select name="roomSelect" id="roomSelect" class="form-control">
										<c:forEach var="building" items="${buildings }" varStatus="status">
												<c:forEach var="room" items="${building.rooms }">
														<option class="building${building.buildNo }" value="${room.roomNo }">${room.roomName }</option>
												</c:forEach>
										</c:forEach>
									</select>
<!-- 									<label for="roomSelect">회의실</label>  -->
<!-- 									<select name="roomSelect" id="roomSelect" class="form-control"> -->
<!-- 										<option value="">전체</option> -->
<!-- 									</select> -->
								</div>
	
								<!-- 회의유형 선택 -->
								<div class="col-sm-12">
									<label>회의구분</label> 
									<select name="category" id="meetingCategory" class="form-control">
										<option value="고객미팅">고객미팅</option>
									</select>
								</div>
							
								<div class="col-sm-12">
									<label>시작일</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar-o"></i>
										</div>
										<input type="text" class="form-control pull-right"
											id="reservationStartDate" readonly>
									</div>
									<!-- /.input group -->
								</div>
								<div class="col-sm-12">
									<label>종료일</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar-o"></i>
										</div>
										<input type="text" class="form-control pull-right"
											id="reservationEndDate" readonly>
									</div>
									<!-- /.input group -->
								</div>
					             
							</div>

							<!-- 참석인원 -->
							<div class="col-sm-12">
								<label>참석인원 및 명단</label>
								<div class="input-group">
									<span class="input-group-addon">참석인원</span> 
									<input type="number" placeholder="최대인원 (명)" class="form-control">
									<span class="input-group-addon"><i class="fa fa-users"></i></span>
									<input type="text" class="form-control" placeholder="참석자 명단">
									<div class="input-group-btn">
										<button class="btn btn-outline-secondary" type="button"><i class="fa fa-plus"></i></button>
									</div>
								</div>
							</div>
							
							<!-- 비품 신청 -->
							<div class="col-sm-12">
								<label>비품신청</label>
								<div class="input-group">
									<span class="input-group-addon">비품명</span> 
									<input type="text" placeholder="비품명" class="form-control" readonly>
									<span class="input-group-addon">수량</span>
									<input type="number" class="form-control" placeholder="수량" readonly>
									<div class="input-group-btn">
										<button class="btn btn-outline-secondary" type="button"><i class="fa fa-plus"></i></button>
									</div>
								</div>
							</div>
							
							<!-- 네트워크 사용 유무 -->
							<div class="col-sm-12">
								<label class="control-label">네트워크 유/무</label>
								<div class="col-sm-12">
									<label class="col-sm-6"> 
										<input type="radio" name="networkYn" class="minimal" checked> Yes
									</label>
									<label class="col-sm-6">
										<input type="radio" name="networkYn" class="minimal"> No
									</label>
								</div>
							</div>
	
							<!-- 다과준비 유무 -->
							<div class="col-sm-12">
								<label class="control-label">다과준비 유/무</label>
								<div class="col-sm-12">
									<label class="col-sm-6"> <input type="radio"
										name="snackYn" class="minimal" checked> Yes
									</label> <label class="col-sm-6"> <input type="radio"
										name="snackYn" class="minimal"> No
									</label>
								</div>
							</div>
							
							<!-- 사용 목적 -->
							<div class="col-sm-12">
								<div class="form-group">
									<label class="control-label">사용 목적</label>
									<textarea class="form-control" rows="5" ></textarea>
								</div>
								<br>
							</div>
	
							<div class="col-sm-12">
								<input type="button" class="btn  btn-info col-sm-12"
									id="availableRoomSearchBtn" value="예약">
							</div>

						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.col-md-12 -->
				</div>
				<!-- /.box -->
			</div>
			<!-- /.col -->

		</div>
		<!-- /.row -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<link rel="stylesheet" href="/resources/plugins/datetimepicker/jquery.datetimepicker.css">
<script src="/resources/plugins/datetimepicker/jquery.datetimepicker.full.js"></script>
<script>

	//2. 지사 선택시 지사내 회의실 목록 roomSelect 태그에 출력
	function selectBuilding(buildNo) {
		$('#roomSelect option').hide();
		$('#roomSelect').find('.building'+buildNo).show();
		$('#roomSelect').val($('#roomSelect').find('.building'+buildNo).first().val());
		$('#roomSelect').trigger('change');
	}
	
	$(function(){
		/**
			#### Controller로부터 받아올 정보
			#	model : 지사 목록 (buildings), 전체 직원 목록 (employees)
			#	session : 예약정보 (reservationInfo)
			
			1. 지사 목록을 buildingSelect 태그에 출력
			2. 선택된 지사의 회의실 목록을 roomSelect 태그에 출력
			3. 회의실 선택 => 예약 시작일의 예약정보를 조회하여 datetimepicker에 반영
							비품 목록을 불러오기
			4. 시작일(onSelectDate) 선택 시 예약정보를 조회하여 선택가능 시간(allowTimes) 반영
			5. 시작일 시간 선택 시 시작날짜 이전일 선택을 막고 종료일 datetimepicker 생성 및 show
			6. 종료일(onSelectDate) 선택 시 예약정보를 조회하여 선택가능 시간(allowTimes) 반영
			7. 전체 직원 목록 불러오기 
		**/
		
		// 예약할 회의실 번호를 가지고 들어왔으면 초기세팅 
		if('${roomDTO}'!='') {
			$('#buildingSelect').val('${roomDTO.buildNo}');
			selectBuilding('${roomDTO.buildNo}');
			$('#roomSelect').val('${roomDTO.roomNo}');
		}else {
			$('#buildingSelect').trigger('change');
		}
		
		initDatetimePicker();
		
		//회의실 선택 시 관련 정보를 가져온다
		$('#roomSelect').change(function(){
			$.ajax({
	            type : "POST",
	            url : "/reserve/getReservationInfo",
	            data : {"buildNo" : $('#buildingSelect').val(),
	            		"roomNo" : $('#roomSelect').val(),
	            		"roomType" : ""},
	            dataType : "json",
	            success : function(data) {
	            	//회의실 변경 시 예약일 초기화
	            	initDatetimePicker();
	            	
	            	alert("roomSelect success : "+JSON.stringify(data));
	            },
	            error : function(data) {
	               alert('roomSelect click error!');
	            }
	        });
		});
		
		//회의실 검색에서 저장한 예약정보 설정
		var startDate = moment('${reservationInfo.startDate}');
		var endDate = moment('${reservationInfo.endDate}');
		console.log(startDate + " - " + endDate);
		
		// 선택한 회의실의 시작일 선택가능한 시간설정 
		function settingStartDateAllowTimes(dateString) {
			$.ajax({
	            type : "POST",
	            url : "/reserve/getTimeByDate",
	            data : {"buildNo" : $('#buildingSelect').val(),
	            		"roomNo" : $('#roomSelect').val(),
	            		"startDate" : $('#reservationStartDate').val()},
	            dataType : "json",
	            success : function(data) {
	            	console.log(JSON.stringify(data.reservationList));
	            	$('#reservationStartDate').datetimepicker('setOptions', {
	            		allowTimes: getAllowTimeList(dateString, data.reservationList)
	            	});
	            }
			});
		}
				
		// 예약 시작일(#reservationStartDate) 초기 설정
	    function initDatetimePicker() {
	    	$('#reservationStartDate').datetimepicker('reset');
	    	$('#reservationEndDate').datetimepicker('reset');
	    	$('#reservationStartDate').datetimepicker('destroy');
	    	$('#reservationEndDate').datetimepicker('destroy');
	    	
	    	$('#reservationStartDate').datetimepicker({
				lang: 'ko',
				step: 30,
				minDate: 0,
				defaultDate: new Date(),
				defaultTime: settingMinute(new Date()),
				minTime: '09:00',
				maxTime: '18:00',
				disabledWeekDays: [0, 6],
				onSelectDate: function(ct) {
					settingStartDateAllowTimes($('#reservationStartDate').val());
				},
				onSelectTime: function(ct) {
					// 예약 종료일
					$('#reservationEndDate').datetimepicker('reset');
					$('#reservationEndDate').datetimepicker('destroy');
	            	$('#reservationEndDate').datetimepicker({
	        			step: 30,
	        			minDate: moment($('#reservationStartDate').val(), 'YYYY/MM/DD HH:mm').format('YYYY/MM/DD'),
	        			defaultDate : moment($('#reservationStartDate').val(), 'YYYY/MM/DD HH:mm').format('YYYY/MM/DD'),
	        			minTime: '09:00',
	    				maxTime: '18:00',
	    				disabledWeekDays: [0, 6],
	    				onSelectDate: function(ct) {
	    					//settingStartDateAllowTimes($('#reservationStartDate').val());
	    				}
	        		});
	            	$('#reservationEndDate').datetimepicker('show');
				}
			});
	    	
	    	settingStartDateAllowTimes(moment().format('YYYY/MM/DD HH:mm'));
		}
		
	    // oneDate가 0~29분 -> 0분 / 30~59 -> 30분 
		function settingMinute(oneDate) {
			let hour = moment(oneDate).format('HH');
			let min = moment(oneDate).format('mm');
			let minute = parseInt(min/30+1)*30;
			
			return hour+':'+minute;
		}
		
		function getAllowTimeList(oneDate, disabledTimes) {
			let selectedDate = moment(oneDate);
			let year = selectedDate.format('YYYY');
			let month = selectedDate.format('MM');
			let day = selectedDate.format('DD');
			let hour = selectedDate.format('HH');
			let min = selectedDate.format('mm');
			let minute = parseInt(min/30+1)*30;
			
			// 전체 시간 셋팅
			let allowTimeList = new Array();
			for(var i = moment('09:00','HH:mm'); i<moment('18:00', 'HH:mm'); i.add(30, 'm')) {
				allowTimeList.push(i.format('HH:mm'));
			}
			
			// 선택된 날짜가 오늘이면 현재 시간전까지 선택불가 설정
			if(moment().format('YYYY/MM/DD')==selectedDate.format('YYYY/MM/DD')) {
				let from = new Date();
				from.setHours(9, 0);
				let dateRange = {STARTDATE: from, ENDDATE: new Date()}
				disabledTimes.push(dateRange);
			}
			
			$.each(disabledTimes, function(index, item) {
				console.log(moment(item.STARTDATE).format('YYYY/MM/DD HH:mm') +" - "+moment(item.ENDDATE).format('YYYY/MM/DD HH:mm'));
				for(var i = moment(item.STARTDATE); i < moment(item.ENDDATE); i.add(30, 'm')) {
					allowTimeList.splice(allowTimeList.indexOf(i.format('HH:mm')), 1);
				}
			});
			
			console.log("allowTimeList : "+allowTimeList);
			
			return allowTimeList;
		}
		
		//iCheck for checkbox and radio inputs
	    $('input[type="radio"].minimal').iCheck({
	      radioClass   : 'iradio_minimal-blue'
	    })
	    
	   	// reservationInfo 내용이 있다면 설정
	   	$('#reservationStartDate').val('${reservationInfo.startDate}');
	   	$('#reservationEndDate').val('${reservationInfo.endDate}');
	    
	});
</script>