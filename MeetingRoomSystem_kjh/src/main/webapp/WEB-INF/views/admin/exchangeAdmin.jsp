<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/meeting/resources/css/duallistbox/bootstrap-duallistbox.min.css">

<style>

</style>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-calendar"></i>관리자 권한 관리</h1>
            <p>
                관리자 권한을 수정합니다.
            </p>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item">
                <i class="fa fa-home fa-lg"></i>
            </li>
            <li class="breadcrumb-item">
                <a href="/meeting/recognition/exchangeAdmin">관리자 권한 관리</a>
            </li>
        </ul>
    </div>
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="tile">
                <div class="sparkline10-list">
                    <div class="sparkline10-hd">
                        <div class="main-sparkline10-hd">
                            <h1>관리자 권한 관리</h1>
                        </div>
                    </div>
                    <div class="sparkline10-graph">
                        <div class="basic-login-form-ad">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                    <div class="dual-list-box-inner">
                                        <form id="form" action="/meeting/recognition/changeAuth" method="post" class="wizard-big">
                                            <select class="form-control dual_select" id="empList" name="empList" multiple>
                                                <c:forEach var="list" items="${empAuthority}">
                                                    <c:choose>
                                                        <c:when test="${list.authority eq 'ROLE_ADMIN'}">
                                                            <option value=${list.empId } selected>${list.empName} - ${list.deptName}</option>
                                                        </c:when>
                                                        <c:when test="${list.authority eq 'ROLE_USER'}">
                                                            <option value=${list.empId }>${list.empName} - ${list.deptName}</option>
                                                        </c:when>
                                                    </c:choose>
                                                </c:forEach>
                                            </select>
                                            <input type="hidden" name="_csrf" value="${_csrf.token }">
                                            <br>
                                            <button class="btn btn-primary" type="button" id="dataChangeConfirm">수정</button>
                                        </form>
                                        <form id="hiddenForm" action="/meeting/recognition/changeAuth" method="post">
                                            <input type="hidden" name="_csrf" value="${_csrf.token }">
                                            <input id="result" type="hidden" name="resultArray">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--  modal start -->
                <div class="modal fade" id="confirm" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" style="text-align:center;">아래 내용이 맞습니까?</h4>
                                <button type="button" class="close" data-dismiss="modal">×</button>
                            </div>
                            <div class="modal-body">
                                <div class="row mb-4">
                                    <div class="col-md-8">
                                        <label>일반사용자 -> 관리자</label>
                                        <h5 id="NtoA"></h5>
                                    </div>
                                </div>
                                <div class="row mb-4">
                                    <div class="col-md-8">
                                        <label>관리자 -> 일반사용자</label>
                                        <h5 id="AtoN"></h5>
                                    </div>
                                </div>
                                <div class="modal-footer" style="margin-top:20px">
                                    <div class="row mb-10">
                                        <div class="col-md-12">
                                            <button class="btn btn-success" id="finallyConfirm" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>확인</button>
                                            <button class="btn btn-success" type="button" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-check-circle"></i>취소</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- modal end -->

                <div class="tile-footer">
                </div>
            </div>
        </div>
    </div>
</main>
<script src="/meeting/resources/js/duallistbox/jquery.bootstrap-duallistbox.js"></script>
<script src="/meeting/resources/js/duallistbox/duallistbox.active.js"></script>
<script type="text/javascript" src="/meeting/resources/js/plugins/sweetalert.min.js"></script>
<script>
    $(function() {

        var resultArray = new Array();
        var empId = "";
        $.ajax({
            url: "/meeting/users/getCurrentId",
            method: "post",
            data: "_csrf=${_csrf.token}",
            success: function(data) {
                empId = data.empId;
                console.log("에이작스");
                console.log(data.empId);
                console.log("로컬 변수 : " + empId);
            }
        });




        $("#dataChangeConfirm").click(function() {
            var allUsers = JSON.parse('${empAuthorityJson}');
            var originRoleAdmin = new Array();

            var newRoleAdmin = new Array();

            var sliceString = "A";

            newRoleAdmin = $("#empList").val();

            for (var i = 0; i < allUsers.length; i++) {
                if (allUsers[i].authority == 'ROLE_ADMIN') {
                    originRoleAdmin.push(allUsers[i].empId);
                }
            }
            console.log(originRoleAdmin);
            console.log("end of listing");

            console.log("원래 데이터")
            console.log(originRoleAdmin);
            console.log("바뀐 결과")
            console.log(newRoleAdmin);

            for (var i = 0; i < originRoleAdmin.length; i++) {
                for (var j = 0; j < newRoleAdmin.length; j++) {
                    if (originRoleAdmin[i] == newRoleAdmin[j]) {
                        originRoleAdmin[i] = null;
                        newRoleAdmin[j] = null;
                    }
                }
            }
            //공통요소 제거
            var allNull = 0;
            for (var i = 0; i < originRoleAdmin.length; i++) {
                if (originRoleAdmin[i] != null)
                    allNull++;
            }

            for (var i = 0; i < newRoleAdmin.length; i++) {
                if (newRoleAdmin[i] != null)
                    allNull++;
            }
            console.log("바뀐 결과2")
            console.log(newRoleAdmin);

            if (allNull == 0) {
                console.log("nothing is changed"); // 바뀐 값 없음.
                swal({
                    title: "오류",
                    text: "바뀐 데이터가 없습니다.",
                    type: "warning",
                    confirmButtonText: "OK",
                    closeOnConfirm: true,
                });
            } else { // 바뀐 값 있음!! 진행!
                var sameUserChanged = false; // 리스트에 아무것도 없다

                var nowStateRoleAdmin = $("#empList").val();
                if ($.inArray(empId, nowStateRoleAdmin) != -1) {

                    sameUserChanged = false;
                } else {

                    sameUserChanged = true;
                }
                console.log("현재 유저가 자기꺼 바꾸는지?");
                console.log(sameUserChanged);
                if (sameUserChanged == false) {

                    console.log("Admin->User")
                    console.log(originRoleAdmin);
                    console.log("User->Admin");
                    console.log(newRoleAdmin);
                    originRoleAdmin.push(sliceString);
                    resultArray = originRoleAdmin.concat(newRoleAdmin);
                    console.log("ResultArray");
                    resultArray = resultArray.filter(n => n);
                    console.log(resultArray);

                    var modalAtoN = "";
                    var modalNtoA = "";
                    var modeChange = false

                    for (var i = 0; i < resultArray.length; i++) {
                        for (var j = 0; j < allUsers.length; j++) {
                            if (resultArray[i] == 'A') {
                                modeChange = true;
                                i++;
                                continue;
                            }
                            if (modeChange == false) {
                                if (allUsers[j].empId == resultArray[i]) //아이디 비교해서
                                    modalAtoN = modalAtoN + allUsers[j].empName + " - " + allUsers[j].deptName + ", ";
                            } else if (modeChange == true) {
                                if (allUsers[j].empId == resultArray[i])
                                    modalNtoA = modalNtoA + allUsers[j].empName + " - " + allUsers[j].deptName + ", ";
                            }
                            //modeChange if end
                        }
                    }
                    $("#confirm").modal('show');
                    $("#AtoN").text(modalNtoA.substr(0, modalNtoA.length - 2));
                    $("#NtoA").text(modalAtoN.substr(0, modalAtoN.length - 2));
                } else if (sameUserChanged == true) {
                    swal({
                        title: "오류",
                        text: "자신의 권한은 수정 할 수 없습니다.",
                        type: "warning",
                        confirmButtonText: "OK",
                        closeOnConfirm: true,
                    });
                }
            }
        }); //data분석  끝

        $("#finallyConfirm").click(function() {
            var newResult = "";
            for (var i = 0; i < resultArray.length; i++) {
                if (i == resultArray.length - 1)
                    newResult = newResult + resultArray[i];
                else
                    newResult = newResult + resultArray[i] + ",";
            }
            document.getElementById("result").value = newResult;
            $("#hiddenForm").submit();
        });

        var customSettings = $('#empList').bootstrapDualListbox('getContainer');
        customSettings.find('.btn-default').remove();
        customSettings.find('.btn-group').remove();




    });
</script>