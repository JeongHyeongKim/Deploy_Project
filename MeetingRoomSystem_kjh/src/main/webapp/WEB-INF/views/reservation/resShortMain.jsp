<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1>
                <i class="fa fa-calendar"></i>회의실 예약</h1>
            <p>지사를 선택한 뒤, 회의실을 확인하세요</p>
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
    <div class="row user">
        <div class="col-md-3">
            <div class="tile p-0">
                <ul class="nav flex-column nav-tabs user-tabs">
                    <li class="nav-item">
                        <a class="nav-link">지사 선택</a>
                    </li>
                    <c:forEach items="${branchList}" var="branchList">
                        <li class="nav-item">
                            <a class="nav-link" href="/meeting/reservation/resShortMain/${branchList.brId}" id="${branchList.brId}">${branchList.brName}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="col-md-9">
        	<div class="row">
        		<c:forEach items='${resShortMain}' var="resShortList">
       			 <div class="col-lg-4">
            		<div class="tab-content">
                <!-- 회의실 정보 -->
                
                    	<input id="mrName${resShortList.mrName }" type="hidden" value="${resShortList.mrName }">
                    	<input id="mrId" type="hidden" value="${resShortList.mrId }">
                    	<input id="brName" type="hidden" value="${resShortList.brName }">
                        	<div class="tab-pane active meeting-room" id="${resShortList.mrId}" 
                        		onclick = "location.href='/meeting/reservation/resShortDetail/${resShortList.mrId}'">
                        	
                            	<div class="card">
                                	<h4 class="card-header">${resShortList.mrName }</h4>
                                	<div class="card-body">
                                    	<h5 class="card-title">${resShortList.brLocation } ${resShortList.mrLocation }</h5>
                                    	<h6 class="card-subtitle text-muted">
                                        <b>관리자</b>
                                        ${resShortList.empName}</h6>
                                	</div>
                                	<img alt="Card image" src="${resShortList.mrImg }" style="height: 200px; width: 100%; display: block;">
                                    <div class="card-body">
                                        <p class="card-text">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <b>공간유형</b>
                                                    </td>
                                                    <c:if test="${resShortList.mrType eq 'mr_type_0'}">
                                                        <td>회의실</td>
                                                    </c:if>
                                                    <c:if test="${resShortList.mrType eq 'mr_type_1'}">
                                                        <td>대회의실</td>
                                                    </c:if>
                                                    <c:if test="${resShortList.mrType eq 'mr_type_2'}">
                                                        <td>교육실</td>
                                                    </c:if>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <b>예약시간</b>
                                                    </td>
                                                    <td>최소 30분부터</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <b>수용인원</b>
                                                    </td>
                                                    <td>${resShortList.mrLimit }인</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <b>관리자</b>
                                                    </td>
                                                    <td>${resShortList.empName }</td>
                                                </tr>
                                            </table>
                                        </p>
                                        <c:set value="${resShortList.eqId}" var="eqId"/>
                                        <c:if test="${fn:contains(eqId,'M')}">
                                            <i class="fa fa-fw fa-lg fa-wifi"></i>wifi<br>
                                        </c:if>
                                        <c:if test="${fn:contains(eqId,'N')}">
                                            <i class="fa fa-fw fa-lg fa-laptop"></i>laptop<br>
                                        </c:if>
                                        <c:if test="${fn:contains(eqId,'WB')}">
                                            <i class="fa fa-fw fa-lg fa-edit"></i>White Board<br>
                                        </c:if>
                                        <c:if test="${fn:contains(eqId,'V')}">
                                            <i class="fa fa-fw fa-lg fa-video-camera"></i>Beam project<br>
                                        </c:if>
                                    </div>
                                    <div class="card-footer text-muted"></div>
                                </div>
                            </div>
                    	</div>
               		 </div>
                </c:forEach>
            </div>
        </div>
     </div> 
</main>
<script>
            
            $(document).ready(function() { 
            	
            	var btnClassClick = function(e){
            		var mrId = e.currentTarget.id;
            		window.sessionStorage.setItem("mrId",e.currentTarget.id);
            		
            	    $.ajax({
            	    	url:"/meeting/users/getCurrentInfo/"+mrId,
            	    	type:"post",
            	    	data:"_csrf=${_csrf.token}",
            	    	success:function(data){
            	    		var info = data;
            	    		window.sessionStorage.setItem("mrName",info.mrName);
                    		window.sessionStorage.setItem("brName",info.brName);		
            	    	}
            	    })
            	    
            	}

            	$('.meeting-room').on('click', btnClassClick);
            	
            	$.ajax({
                    url:"/meeting/users/getCurrentId",
                    method :"post",
                    data : "_csrf=${_csrf.token}",
                    success : function(data){
                       var emp = data
                       console.log(emp);
                       window.sessionStorage.setItem("empName",emp.empName);

                    }
                 });
            });
        </script>