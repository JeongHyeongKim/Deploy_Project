<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.fc-past:hover, .fc-sun:hover, .fc-sat:hover{cursor: not-allowed;}
	#reservationtime {font-size:8pt;}
</style>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			회의실 검색
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Calendar</li>
		</ol>
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="row">
		
			<div class="col-md-3">
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">조건 검색</h3>
					</div>
					<form id="availableRoomListForm" method="post" action="/reserve/availableRoomList">
						<div class="box-body">
							<!-- 지사 선택 -->
							<div class="form-group">
								<label for="buildingSelect">지사</label>
								<select name="buildingSelect" id="buildingSelect" class="form-control">
									<option value="">전체</option>
									<c:forEach var="building" items="${buildings }">
										<option value="${building.buildNo }">${building.buildName }</option>
									</c:forEach>
								</select>
							</div>
							
							<!-- 장소유형 선택 -->
							<div class="form-group">
								<label>장소유형</label>
								<select name="roomTypeSelect" id="roomTypeSelect" class="form-control">
									<option value="">전체</option>
									<option value="회의실">회의실</option>
									<option value="교육실">교육실</option>
								</select>
							</div>
							
							<!-- Date and time range -->
							<div class="form-group">
								<label>예약 날짜</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-clock-o"></i>
									</div>
									<input type="text" class="form-control pull-right" name="reservationtime" id="reservationtime">
								</div>
								<!-- /.input group -->
							</div>
							
							<!-- 회의실 규모 -->
							<div class="input-group form-group">
	    						<span class="input-group-addon">참석인원</span>
								<input type="number" name="empCount" placeholder="최대인원 (명)" min="1" value="1" class="form-control input-sm">
							</div>
							<!-- 네트워크 사용 유무 -->
							<div class="form-group">
								<div class="input-group">
									<label class="control-label">네트워크 유/무</label>
									<div class="col-sm-12">
					            	<label class="col-sm-6">
					                	<input type="radio" name="networkYn" value="Y" class="minimal" checked>
					                 	Yes
					                </label>
					                <label class="col-sm-6">
					                	<input type="radio" name="networkYn" value="N" class="minimal">
					                	No
					              	</label>
					              	</div>
				              	</div>
				            </div>
				            
				            <input type="button" class="btn  btn-info col-sm-12" id="availableRoomSearchBtn" value="검색">
	
						</div>
						<!-- /.box-body -->
					</form>
				</div>
				<!-- /.box -->
				
			<!--  예약 상태 삭제 -->
			
			</div>
			<!-- /.col(left:col-md-3) -->

			<div class="col-md-9">
				<div class="box box-primary">
					<div class="box-body no-padding">
						<!-- THE CALENDAR -->
						<div id="calendar"></div>
					</div>
					<!-- /.box-body -->
				</div>
				<!-- /. box -->
			</div>
			<!-- /.col(right:col-md-9) -->
			
		</div>
		<!-- /.row -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!-- modal -->
<div class="modal fade" id="fullcalendar-event-detail-modal">
	<div class="modal-dialog">
	  <div class="modal-content">
	    <div class="modal-header">
	      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	        <span aria-hidden="true">&times;</span></button>
	      <h4 class="modal-title">Default Modal</h4>
	    </div>
	    <div class="modal-body" style="display: inline-block">
	    	<!-- 모달 내용 -->
	    	<!-- 지사 선택 -->
			<div class="col-md-12">
				<div class="form-group">
					<div class="col-sm-6">
						<label for="buildingSelect">지사</label>
						<input type="text" id="modal-buildName" class="form-control" disabled>
					</div>
					<div class="col-sm-6">
						<label for="roomSelect">회의실</label> 
						<input type="text" id="modal-roomName" class="form-control" disabled>
					</div>

					<!-- 회의유형 선택 -->
					<div class="col-sm-12">
						<label>회의구분</label> 
						<input type="text" id="modal-meetingCategory" class="form-control" disabled>
					</div>
					
					<div class="col-sm-12">
						<label>회의명</label> 
						<input type="text" id="modal-meetingTitle" class="form-control" disabled>
					</div>
					
					<div class="col-sm-12">
						<label>시작일</label>
						<div class="input-group">
							<div class="input-group-addon">
								<i class="fa fa-calendar-o"></i>
							</div>
							<input type="text" class="form-control pull-right" id="modal-reservationStartDate" disabled>
							<div class="input-group-addon">
		                    	<i class="fa fa-clock-o"></i>
		                    </div>
		                    <input type="text" id="modal-reservationStartTime" class="form-control timepicker" disabled>
						</div>
						<!-- /.input group -->
					</div>
					<div class="col-sm-12">
						<label>종료일</label>
						<div class="input-group">
							<div class="input-group-addon">
								<i class="fa fa-calendar-o"></i>
							</div>
							<input type="text" class="form-control pull-right" id="modal-reservationEndDate" disabled>
							<div class="input-group-addon">
		                    	<i class="fa fa-clock-o"></i>
		                    </div>
		                    <input type="text" id="modal-reservationEndTime" class="form-control timepicker" disabled>
						</div>
						<!-- /.input group -->
					</div>
		             
				</div>
				
				<!-- 네트워크 사용 유무 -->
				<div class="col-sm-12">
					<label class="control-label">네트워크 사용 유/무</label>
					<div class="col-sm-12">
						<label class="col-sm-6"> 
							<input type="radio" name="modal-networkYn" class="minimal" value="Y" checked disabled> Yes
						</label>
						<label class="col-sm-6">
							<input type="radio" name="modal-networkYn" class="minimal" value="N" disabled> No
						</label>
					</div>
				</div>

				<!-- 다과준비 유무 -->
				<div class="col-sm-12">
					<label class="control-label">다과준비 유/무</label>
					<div class="col-sm-12">
						<label class="col-sm-6"> <input type="radio"
							name="modal-snackYn" class="minimal" value="Y" checked disabled> Yes
						</label> <label class="col-sm-6"> <input type="radio"
							name="modal-snackYn" class="minimal" value="N" disabled> No
						</label>
					</div>
				</div>
				
				<!-- 사용 목적 -->
				<div class="col-sm-12">
					<div class="form-group">
						<label class="control-label">사용 목적</label>
						<textarea id="modal-purpose" class="form-control" rows="5" disabled></textarea>
					</div>
				</div>
				
			</div>
			<!-- /. -->
	    </div>
	    <div class="modal-footer">
	      <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	    </div>
	  </div>
	  <!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- fullCalendar customizing -->
<style>
	.fc-day-top.fc-sat > .fc-day-number { color:#0000FF; }     /* 토요일 */
    .fc-day-top.fc-sun > .fc-day-number { color:#FF0000; }    /* 일요일 */
    .fc-reserveBtn-button {background: '#3c8dbc'; }
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.0/gcal.js"></script>
<!-- Page specific script -->
<script>
	$(function() {
		
		var colorMap = new Map();
		colorMap.set('00', '#f39c12'); // 미승인
		colorMap.set('10', '#00a65a'); // 1차 승인
		colorMap.set('11', '#3c8dbc'); // 최종 승인
		colorMap.set('20', '#dd4b39'); // 반려
		colorMap.set('12', '#dd4b39'); // 반려
		
		/* initialize the calendar
		 -----------------------------------------------------------------*/
		//Date for the calendar events (dummy data)
		var date = new Date();
		var d = date.getDate(), m = date.getMonth(), y = date.getFullYear();
		var selectedStart;
		var selectedEnd;
		var calendar = $('#calendar').fullCalendar({
			header : {
				left : 'prev,next today reserveBtn',
				center : 'title',
				right : 'month,agendaWeek,agendaDay'
			},
			buttonText : {
				today : 'today',
				month : 'month',
				week : 'week',
				day : 'day'
			},
			customButtons: {
				reserveBtn: {
					text: '예약하기',
					color : '#3c8dbc',
					click: function(event) {
						console.log(selectedStart +" - "+ selectedEnd);
						$('#availableRoomListForm').submit();
					}
				}
			},
			selectable: true,
			selectAllow: function(selectInfo) {
				//주말 선택 금지
				if(moment(selectInfo.start).format('E')==6 || moment(selectInfo.start).format('E')==7) return false;
				//과거일 선택 금지
				if(moment(selectInfo.start).format('YYYY-MM-DD') < moment(new Date()).format('YYYY-MM-DD')) return false;
				return true;				
			},
			select: function(startDate, endDate, jsEvent, view, resource) {
				selectedStart = startDate.format('YYYY-MM-DD 09:00');
				selectedEnd = endDate.add(-1,'d').format('YYYY-MM-DD 18:00');
				$('#reservationtime').data('daterangepicker').setStartDate(selectedStart);
				$('#reservationtime').data('daterangepicker').setEndDate(selectedEnd);
			},
			eventClick: function(event){
				console.log(event);
				$('#fullcalendar-event-detail-modal .modal-title').text(event.title);
				$('#modal-buildName').val(event.buildName);
				$('#modal-roomName').val(event.roomName);
				$('#modal-meetingCategory').val(event.category);
				$('#modal-meetingTitle').val(event.title);
				$('#modal-reservationStartDate').val(moment(event.startDate).format("YYYY-MM-DD"));
				$('#modal-reservationEndDate').val(moment(event.endDate).format("YYYY-MM-DD"));
				$('#modal-reservationStartTime').val(moment(event.startDate).format("HH:mm"));
				$('#modal-reservationEndTime').val(moment(event.endDate).format("HH:mm"));
				$('#modal-empCount').val(event.empCount);
				$('input:radio[name=modal-networkYn]:input[value="'+event.networkYn+'"]').iCheck('check');
				$('input:radio[name=modal-snackYn]:input[value="'+event.snackYn+'"]').iCheck('check');
				$('#modal-purpose').text(event.purpose);
				
				$('#fullcalendar-event-detail-modal').modal('show');
			},
			dayClick: function(date, event, view) {
				console.log(moment(date).format('YYYY/MM/DD HH:mm'));
				console.log(event);
				console.log(view);
			},
			contentHeight: "auto",
			timeFormat: 'HH:mm'
// 			,eventLimit: true, // for all non-TimeGrid views
// 			views: {
// 		    	timeGrid: {
// 					eventLimit: 6 // adjust to 6 only for timeGridWeek/timeGridDay
// 		    	}
// 			}
		});
		
		//회의실 예약 : 지사, 회의실구분별 예약목록 조회
		function getReservationList() {
			$.ajax({
	            type : "POST",
	            url : "/reserve/getReservationList",
	            data : {"buildNo" : $('#buildingSelect').val(),
	            		"roomType" : $('#roomTypeSelect').val()},
	            dataType : "json",
	            success : function(data) {
	            	var events = [];
	            	$.each(data.reservationList, function(index, item) {
	            		var oneEvent = new Object();
	            		oneEvent.id = item.RESERVENO;
	            		oneEvent.title = item.TITLE;
	            		oneEvent.start = new Date(item.STARTDATE);
	            		oneEvent.end = new Date(item.ENDDATE);
	            		oneEvent.backgroundColor = colorMap.get(''+item.APPROVAL1YN+item.APPROVAL2YN);
	            		oneEvent.borderColor = colorMap.get(''+item.APPROVAL1YN+item.APPROVAL2YN);
	            		//추가정보
	            		oneEvent.roomName = item.ROOMNAME;
	            		oneEvent.roomNo = item.ROOMNO;
	            		oneEvent.networkYn = item.NETWORKYN;
	            		oneEvent.buildNo = item.BUILDNO;
	            		oneEvent.buildName = item.BUILDNAME;
	            		oneEvent.reserveNo = item.RESERVENO;
	            		oneEvent.startDate = item.STARTDATE;
	            		oneEvent.endDate = item.ENDDATE;
	            		oneEvent.purpose = item.PURPOSE;
	            		oneEvent.category = item.CATEGORY;
	            		oneEvent.empCount = item.EMPCOUNT;
	            		oneEvent.snackYn = item.SNACKYN;
	            		//이벤트 목록에 추가
	            		events[index] = oneEvent;
	            	});
	            	
	            	$('#calendar').fullCalendar('removeEvents');
	            	$('#calendar').fullCalendar('removeEvents', 'koHolidays');
        		    $('#calendar').fullCalendar('addEventSource', events);
        		    $('#calendar').fullCalendar('rerenderEvents');
	            },
	            error : function(data) {
	               alert('roomSelect click error!');
	            }
	        });
		}
		
		//페이지로딩시 전체 예약현황 셋팅
		getReservationList();
		
		//좌측 검색창에서 지사와 회의실구분 변경 시 달력 업데이트
		$('#buildingSelect, #roomTypeSelect').change(function() {
			getReservationList();
		});
		
		/** DatePicker **/
		//좌측 회의실 검색부분
		$('#reservationtime').daterangepicker({
			timePicker : true,
			timePickerIncrement : 30,
			timePicker24Hour: true,
			minDate : moment().format('YYYY-MM-DD 09:00'),
			startDate: moment().format('YYYY-MM-DD 09:00'),
			endDate: moment().format('YYYY-MM-DD 18:00'),
			format : 'YYYY/MM/DD HH:mm',
			locale : {
				format : 'YYYY/MM/DD HH:mm'
			}
		})
		
		//iCheck for checkbox and radio inputs
	    $('input[type="radio"].minimal').iCheck({
	      radioClass   : 'iradio_minimal-blue'
	    });
	    
	    //검색 버튼 클릭
	    $('#availableRoomSearchBtn').click(function(){
	    	let picker = $('#reservationtime').data('daterangepicker');
	    	console.log(moment(picker.startDate).format('YYYY/MM/DD HH:mm') + " - " + moment(picker.endDate).format('YYYY/MM/DD HH:mm'));
	    	$('#availableRoomListForm').submit();
	    });
	    
	})
</script>