<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<link href="/meeting/resources/css/jquery.datetimepicker.css" rel="stylesheet"/>
<link href="/meeting/resources/css/fullcalendar.min.css" rel="stylesheet"/>
<link href="/meeting/resources/css/fullcalendar.print.min.css" media="print" rel="stylesheet"/>
<style>
	.fc-past:hover{cursor: no-drop;}
</style>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1>
                <i class="fa fa-calendar"></i>회의실 예약</h1>
            <p>회의실 예약 현황을 확인한 뒤, 예약을 신청하세요</p>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item">
                <i class="fa fa-home fa-lg"></i>
            </li>
            <li class="breadcrumb-item">
                <a href="/meeting/reservation/resShortMain/br_0001">회의실 예약</a>
            </li>
        </ul>
    </div>
    <div class="row">
        <div class="col-md-12" style="width:100%;">
            <div class="tile row">
            <h1 id="brName"></h1>
                <div id="calendar"></div>
                 
            </div>
        </div>
    </div>
</main>
<%-- Page specific javascripts--%>
<script src="/meeting/resources/js/plugins/moment.min.js" type="text/javascript"></script>
<script src="/meeting/resources/js/plugins/fullcalendar.min.js" type="text/javascript"></script>
<script src="/meeting/resources/js/plugins/jquery-ui.min.js" type="text/javascript"></script>
<script src="/meeting/resources/js/plugins/jquery.datetimepicker.full.js"></script>
<script src="/meeting/resources/js/plugins/sweetalert.min.js"></script>
<script>
    $(document).ready(function() { 
    	sessionStorage.setItem("availTime", "");
    	$("#brName").text(sessionStorage.getItem("brName")+" - "+sessionStorage.getItem("mrName"));
    	
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,basicWeek,basicDay'
            },
            defaultDate: new Date(),
            navLinks: true, // can click day/week names to navigate views
            editable: true,
            lang : "ko",
            droppable: true, // this allows things to be dropped onto the calendar
            eventLimit: true, // allow "more" link when too many events
            timeFormat: 'HH:mm',
            events : [
            	 <c:forEach items="${mrReservationList}" var="list" varStatus="status">  
                { 
                   id : '${list.resId}', 
                   title : '${list.mrName}-${list.empName}',
                   start : '${list.resStartDate}',
                   end : '${list.resEndDate}',
                   backgroundColor:'#ffc107'
                },
            	</c:forEach> 
                ],
            dayClick: function(date, allDay, jsEvent, view) {
                //주말 선택 금지
                if(moment(date).format('E')==6 || moment(date).format('E')==7) return false;
                //과거일 선택 금지
                if(moment(date).format('YYYY-MM-DD') < moment(new Date()).format('YYYY-MM-DD')) return false;
                
            	var str="";
            	var yy=date.format("YYYY");
            	var mm=date.format("MM");
            	var dd=date.format("DD");
            	console.log(dd.length)
            	console.log(dd)
            	if(dd.length==1){
            		dd = "0"+dd;
            	}
            	str = yy+"-"+mm+"-"+dd;
            	console.log(str)
            	swal({
              		title: "예약 신청",
              		text: str+"에 예약을 진행하시겠습니까?",
              		
              		showCancelButton: true,
              		confirmButtonText: "예약 신청",
              		cancelButtonText: "취소",
              		closeOnConfirm: false,
              		closeOnCancel: false
              	}, function(isConfirm) {
              		var mrId = "";
              		var sessionMrId = sessionStorage.getItem("mrId");
              		mrId+=sessionMrId; 
              		if (isConfirm) {
              			sessionStorage.setItem("currentDateUse",str);
              			window.sessionStorage.setItem("currentDate",str);	
              			document.location.href="/meeting/reservation/resWrite/"+mrId;
              		} else {
              			location.reload();
              		}
              	});
            }
        });

        $.ajax({
            url:"/meeting/users/getCurrentId",
            method :"post",
            data : "_csrf=${_csrf.token}",
            success : function(data){
               var emp = data
             
            }
         });
        
    }); 
    
    </script>