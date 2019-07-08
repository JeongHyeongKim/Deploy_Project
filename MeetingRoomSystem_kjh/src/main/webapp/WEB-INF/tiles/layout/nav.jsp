<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>

<html>
<script type="text/javascript">
	$(function(){
		$.ajax({
			url:"/meeting/users/getCurrentId",
			method :"post",
			data : "_csrf=${_csrf.token}",
			success : function(data){
				var emp = data;
				$("#part").text(emp.deptName);
				$("#name").text(emp.empName);
			}
		})
	})
</script>
  <body class="app sidebar-mini rtl">
    <!-- Sidebar menu-->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
      <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/48.jpg" alt="User Image">
        <div>
          <p class="app-sidebar__user-name"></p>
          
          <p class="app-sidebar__user-designation" id="name"></p>
          <p class="app-sidebar__user-designation" id="part"></p>
        </div>
      </div>
      <ul class="app-menu">
      <security:authorize access="hasRole('ROLE_ADMIN')">
 		<li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-cogs"></i><span class="app-menu__label">예약 이력 관리</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="/meeting/recognition/waitForRecognition"><i class="icon fa fa-circle-o"></i>예약현황</a></li>
            <li><a class="treeview-item" href="/meeting/recognition/paymentManagement"><i class="icon fa fa-circle-o"></i>결제관리</a></li>
          </ul>
        </li>
        <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-wrench"></i><span class="app-menu__label">회의실 관리</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="/meeting/branch/list"><i class="icon fa fa-circle-o"></i>지사관리</a></li>
            <li><a class="treeview-item" href="/meeting/meetingRoom/list"><i class="icon fa fa-circle-o"></i>회의실관리</a></li>
            <li><a class="treeview-item" href="/meeting/equipment/list"><i class="icon fa fa-circle-o"></i>기자재관리</a></li>
          </ul>
        </li>
        <li><a class="app-menu__item" href="/meeting/recognition/exchangeAdmin"><i class="app-menu__icon fa fa-exchange"></i><span class="app-menu__label">관리자 권한 관리</span></a></li>
		
        </security:authorize>
        	
        
        <li><a class="app-menu__item" href="/meeting/reservation/resShortMain/br_0001"><i class="app-menu__icon fa fa-calendar-check-o"></i><span class="app-menu__label">예약</span></a></li>
        <li><a class="app-menu__item" href="/meeting/notice/list/1"><i class="app-menu__icon fa fa-file-text-o"></i><span class="app-menu__label">공지사항</span></a></li>
        <li><a class="app-menu__item" href="/meeting/users/mypage"><i class="app-menu__icon fa fa-id-card"></i><span class="app-menu__label">마이페이지</span></a></li>
		<security:authorize access="hasRole('ROLE_HEAD')">
			<li><a class="app-menu__item" href="/meeting/recognition/waitForRecognitionByHead"><i class="app-menu__icon fa fa-pause"></i><span class="app-menu__label">승인 대기 목록</span></a></li>
		</security:authorize>
      </ul>
    </aside>
  </body>
  <!-- Essential javascripts for application to work-->
    <!-- The javascript plugin to display page loading on top-->
    <script src="/meeting/resources/js/plugins/pace.min.js"></script>
    <script src="/meeting/resources/js/main.js"></script>
</html>