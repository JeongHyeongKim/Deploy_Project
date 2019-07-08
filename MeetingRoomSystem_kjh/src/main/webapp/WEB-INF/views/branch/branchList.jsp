<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    var buffer;
    

    function readBranch(brId) {
        location.replace('/meeting/branch/read/' + brId);
    }

    function savebrId(brId) {
        buffer = brId;
        console.log(buffer);
    }
    $(document).on('click', '.deleteAlert', function(e) {
        swal({
            title: "삭제하시겠습니까?",
            text: "삭제 시,해당 지사 정보 복원 불가",
            type: "warning",
            showCancelButton: true,
            confirmButtonText: "예",
            cancelButtonText: "아니오",
            closeOnConfirm: true,
            closeOnCancel: true
        }, function(isConfirm) {
            if (isConfirm) {
                console.log(buffer);

                $.ajax({
                    url: "/meeting/branch/delete/" + buffer,
                    data: "_csrf=${_csrf.token}",
                    method: "post",
                    success: function() {
                        location.reload();
                    },
                    error: function(resTxt) {
                        console.log(resTxt);
                        alert("실패");
                    }
                });
            }
        });
    });
</script>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1>
                <i class="fa fa-calendar"></i>지사관리</h1>
            <p>
                전체 지사 목록입니다.
            </p>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item">
                <i class="fa fa-home fa-lg"></i>
            </li>
            <li class="breadcrumb-item">
                <a>회의실관리</a>
            </li>
            <li class="breadcrumb-item">
                <a href="/meeting/branch/list">지사관리</a>
            </li>
        </ul>
    </div>
    <div style="text-align:right;">
        <a class="btn btn-primary btn-sm" href="/meeting/branch/create">지사 추가</a>
    </div>
    <div class="row">
        <c:forEach items='${branchList}' var="branchList">
            <div class="col-lg-4" id="${branchList.brId}" style="padding-top:20px">
                <div class="bs-component">
                    <div class="card" width="100%">
                        <h4 class="card-header">
                            <span onclick="readBranch('${branchList.brId}')" style="cursor:pointer;">${branchList.brName }</span>
                            <span style="float:right">
                                <a class="deleteAlert" id="demoSwal" onclick="savebrId('${branchList.brId}')" style="cursor:pointer">
                                    X
                                </a>
                            </span>
                        </h4>
                        <div class="card-body">
                            <h5 class="card-title">${branchList.brLocation }</h5>
                            <h6 class="card-subtitle text-muted">${branchList.brTel }</h6>
                        </div><img style="height: 200px; width: 100%; display: block; border-bottom: 3px solid #EEE;border-top:3px solid #EEE" src="${branchList.brImg}" alt="Card image" onclick="readBranch('${branchList.brId}')">
                        <div class="card-body">
                            <p class="card-text">
                                <b>[회의실]</b><br>
                                <c:forEach items='${meetingRoomListOrderByBranch}' var="meetingRoomList" varStatus="status">
                                    <c:if test="${meetingRoomList.BRID eq branchList.brId}">
                                        ${meetingRoomList.MRNAME} <br>
                                    </c:if>
                                </c:forEach>
                            </p>
                        </div>
                        <div class="card-footer text-muted"></div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</main>
<script type="text/javascript" src="/meeting/resources/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="/meeting/resources/js/plugins/sweetalert.min.js"></script>