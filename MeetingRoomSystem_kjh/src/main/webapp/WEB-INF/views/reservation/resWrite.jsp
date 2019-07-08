<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="/meeting/resources/css/jquery.datetimepicker.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/css/swiper.min.css">
<style>
    .swiper-slide {
        text-align: center;
        display: flex;
        /* 내용을 중앙정렬 하기위해 flex 사용 */
        align-items: center;
        /* 위아래 기준 중앙정렬 */
        justify-content: center;
        /* 좌우 기준 중앙정렬 */
    }

    .swiper-slide btn {
        box-shadow: 0 0 5px #555;
    }
</style>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-calendar"></i>회의실 예약</h1>
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
        <div class="col-md-12">
            <div class="tile row">
                <h3 class="tile-title">회의실 예약 신청 작성</h3>
                <div class="tile-body" style="width:100%;">
                    <form class="row" id="resForm">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="hidden" id="mrId" name="mrId" value="${mrId}">
                        <div class="form-group col-md-3">
                            <label class="control-label">신청자 명</label>
                            <input class="form-control" id="resName" type="text" readonly autocomplete="off">
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">회의실 명</label>
                            <input class="form-control" id="resMrName" type="text" readonly autocomplete="off">
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">회의 구분</label>&emsp;<button class="btn btn-info dropdown-toggle" style="display:inline; width:10px; height:10px;" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"></button>
                            <div style="width:100%;">
                                <input class="form-control" id="resType" placeholder="직접입력" type="text" name="resType" autocomplete="off">


                                <div class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-124px, 35px, 0px); top: 0px; left: 0px; will-change: transform;">
                                    <a class="dropdown-item" id="resType1">내부회의</a>
                                    <a class="dropdown-item" id="resType2">고객미팅</a>
                                    <a class="dropdown-item" id="resType3">정기회의</a>
                                    <a class="dropdown-item" id="resType4">긴급회의</a>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">최근 회의 목록 불러오기</label>
                            <input class="form-control" type="button" value="불러오기" data-target="#MyReservationList" data-toggle="modal" autocomplete="off" />
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">예약 시작 일자</label>
                            <input class="form-control" id="resStartDate" placeholder="예약 시작 일자" type="text" autocomplete="off">
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">예약 종료 일자</label>
                            <input class="form-control" id="resEndDate" placeholder="예약 종료 일자" type="text" autocomplete="off">
                        </div>
                        <div class="form-group col-md-3"></div>
                        <div class="form-group col-md-3"></div>
                        <div class="form-group col-md-12">
                            <div class="bs-component" style="width:100%;height:100%">

                                <div class="btn-group btn-group-toggle btn-group-time" style="width:100%;height:100%" data-toggle="buttons">

                                </div>

                            </div>
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">사용 목적</label>
                            <input class="form-control" placeholder="회의 목적을 작성해주십시오" type="text" id="resPurpose" name="resPurpose" autocomplete="off">
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">참석 인원 명단 <a data-target="#empList" data-toggle="modal">&emsp;<button type="button" class="btn btn-secondary" style="width:10px; height:10px;">+</button></a></label>
                            <input class="form-control" type="text" id="attendeeList" autocomplete="off">
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">외부인 참석 인원 수</label>
                            <input class="form-control" min="1" type="number" name="resOutside" id="resOutside" autocomplete="off" value="0">
                        </div>
                        <div class="form-group col-md-3">
                        </div>
                        <div class="form-group col-md-6">
                            <label class="control-label">기자재추가 <a data-target="#equipList" data-toggle="modal">&emsp;<button type="button" class="btn btn-secondary" style="width:10px; height:10px; text-align: center;">+</button></a></label>
                            <input class="form-control" type="text" id="equipElement" name="equipElement" autocomplete="off">
                        </div>

                </div>
                <div class="form-group col-md-3">
                    <label class="control-label">간식 유무</label>
                    <div class="animated-checkbox">
                        <label>
                            <input id="resSnack" name="resSnack" type="checkbox" value="1"><span class="label-text">간식 있음</span>
                        </label>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label class="control-label">네트워크 사용 유무</label>
                    <div class="animated-checkbox">
                        <label>
                            <input id="resNetwork" name="resNetwork" type="checkbox"><span class="label-text">네트워크 사용</span>
                        </label>
                    </div>
                </div>
                <textarea class="form-control" placeholder="기타 전달 사항을 입력해 주십시오" rows="4" id="resAddRequest" name="resAddRequest"></textarea>
                <div class="form-group col-md-3"></div>
                <div class="form-group col-md-3"></div>
                <div class="form-group col-md-3"></div>

                <div class="form-group col-md-3" style="padding-top:50px; text-align:right">
                    <input class="btn btn-info" id="sendForm" type="button" value="예약 신청" />
                </div>
                </form>
            </div>
        </div>
    </div>
    <!-- equipList -->
    <div class="modal fade" id="equipList" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">회의실 기자재수량</h4>
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>
                <div class="modal-body" id="equip-modal-body">
                    <div class="input-group">

                    </div>
                </div>
                <div class="modal-footer" style="margin-top:20px">
                    <div class="row mb-10">
                        <div class="col-md-12">
                            <input type="button" class="btn btn-success" data-dismiss="modal" value="작성" id="equipSubmit">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="MyReservationList" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="targetName"></h4>
                    <h4 class="modal-title">님의 최근이력 불러오기</h4>
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>
                <div class="modal-body" id="pastRes">

                </div>
            </div>
        </div>
    </div>

    <!-- EmpModal -->
    <div class="modal fade" id="empList" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">참석 명단 추가</h4>
                    <button type="button" class="close" data-dismiss="modal">×</button>

                </div>
                <div class="modal-body" id="empList-modal-body">
                    <!--  -->
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="tile">
                                <div class="sparkline10-list">
                                    <div class="sparkline10-hd">
                                        <!-- <div class="main-sparkline10-hd">
		                                    <h1>명단추가</h1>
		                                </div> -->
                                    </div>
                                    <div class="sparkline10-graph">
                                        <div class="basic-login-form-ad">
                                            <div class="row">
                                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                    <div class="dual-list-box-inner">

                                                        <select class="form-control dual_select" id="empListOption" multiple>

                                                            <c:forEach var="list" items="${empList }" begin="0">
                                                                <option value="${list.empId }" class="modal-deptName ${list.empId }" id="${list.deptName }">${list.empName } - ${list.deptName }</option>
                                                            </c:forEach>

                                                        </select>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tile-footer">

                                    <div class="row" id="mainDeptList">
                                        <div class="col-md-3">
                                            <button type="button" class="btn btn-success" id="test">주관부서선택</button>
                                            <!-- <button type="button" id="test">주관부서선택</button> -->
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer" style="margin-top:20px">
                    <div class="row mb-10">
                        <div class="col-md-12">
                            <input type="button" id="btnEmpList" class="btn btn-success" data-dismiss="modal" value="작성">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>
<script src="/meeting/resources/js/plugins/jquery.datetimepicker.full.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/js/swiper.min.js"></script>
<script src="/meeting/resources/js/duallistbox/jquery.bootstrap-duallistbox-reservation.js"></script>
<script src="/meeting/resources/js/duallistbox/duallistbox.active.js"></script>
<script>
    $(document).ready(function() {

        // Array contains method추가      
        Array.prototype.contains = function(element) {
            for (var i = 0; i < this.length; i++) {
                if (this[i] == element) {
                    return true;
                }
            }
            return false;
        }
        var empList = JSON.parse('${empDeptList}');

        /////////////////////////////////////////////////////////////  model 클릭시 주관부서 추가

        var newDeptName = [];

        $("#test").on("click", function() {

            var empListOption = $("#empListOption").val()
            var mainDeptName = [];
            for (var i = 0; i < empListOption.length; i++) {

                for (var j = 0; j < empList.length; j++) {
                    var selectEmpId = empList[j].empId;

                    if (empListOption[i] == selectEmpId) {
                        var deptName = empList[j].deptName;
                        mainDeptName.push(deptName);
                        break;
                    }
                }
            }

            $.each(mainDeptName, function(i, el) {
                if ($.inArray(el, newDeptName) === -1) newDeptName.push(el);
            });

            for (var i = 0; i < newDeptName.length; i++) {
                var $div3col = $("<div></div>").attr("class", "col-lg-3").appendTo($("#mainDeptList"))
                var $divAlert = $("<div><div>").attr("class", "alert alert-dismissible alert-success").appendTo($div3col);
                $("<button></button>").attr("class", "close").attr("id", newDeptName[i]).attr("type", "button").attr("data-dismiss", "alert").text("×").appendTo($divAlert);
                $("<strong></strong>").text(newDeptName[i]).appendTo($divAlert);
            }

        })

        $(document).on("click", ".close", function(e) {
            console.log(e.currentTarget.id);
            newDeptName.splice(newDeptName.indexOf(e.currentTarget.id), 1);
        })

        $("#btnEmpList").on("click", function() {

            $("<input>").attr("type", "hidden").attr("name", "empList").attr("value", $("#empListOption").val()).appendTo($("#resForm"));
            if (newDeptName.length == 0) {
                var empListOption = $("#empListOption").val()
                var mainDeptName = [];
                for (var i = 0; i < empListOption.length; i++) {

                    for (var j = 0; j < empList.length; j++) {
                        var selectEmpId = empList[j].empId;

                        if (empListOption[i] == selectEmpId) {
                            var deptName = empList[j].deptName;
                            mainDeptName.push(deptName);
                            break;
                        }
                    }
                }

                $.each(mainDeptName, function(i, el) {
                    if ($.inArray(el, newDeptName) === -1) newDeptName.push(el);
                });
                $("<input>").attr("type", "hidden").attr("value", newDeptName).attr("name", "mainDept").appendTo($("#resForm"));
            } else {
                $("<input>").attr("type", "hidden").attr("value", newDeptName).attr("name", "mainDept").appendTo($("#resForm"));
            }

            var mainEmpName;
            var empListValue = $("#empListOption").val();
            for (var i = 0; i < empList.length; i++) {
                if (empList[i].empId == empListValue[0]) {
                    mainEmpName = empList[i].empName;
                }
            }

            $("#attendeeList").attr("value", mainEmpName + "외 " + (empListValue.length - 1) + "명");
        })
        ////////////////////////////////////////////////////////////  pastReservation List
        var pastRes = JSON.parse('${pastReservation}');

        for (var i = 0; i < pastRes.length; i++) {
            $("<p></p>").attr("class", "pastId").attr("id", pastRes[i].resId).text("[" + pastRes[i].resType + "]  " + pastRes[i].resStartDate + "에 예약하신 '" + pastRes[i].resPurpose + "'이력 불러오기").appendTo($("#pastRes"));
        }

        $(document).on("click", ".pastId", function(e) {

            for (var i = 0; i < pastRes.length; i++) {

                if (pastRes[i].resId == e.currentTarget.id) {
                    $.ajax({
                        url: "/meeting/reservation/pastEquip/" + pastRes[i].resId,
                        method: "post",
                        data: "_csrf=${_csrf.token}",
                        success: function(data) {
                            var pastEquip = JSON.parse(data);
                            var N = 0;
                            var W = 0;
                            var M = 0;
                            var V = 0;
                            for (var i = 0; i < pastEquip.length; i++) {
                                if (pastEquip[i].substr(0, 1) == 'N') {
                                    N++;
                                } else if (pastEquip[i].substr(0, 1) == 'M') {
                                    M++;
                                } else if (pastEquip[i].substr(0, 1) == 'V') {
                                    V++;
                                } else if (pastEquip[i].substr(0, 1) == 'W') {
                                    W++;
                                }
                            }

                            $("#equipElement").val("빔프로젝터 (" + V + "),화이트보드 (" + W + "),마이크 (" + M + "),노트북 (" + N + ")")
                            // $("<input class='form-control' id='N' name='N' type='text' value='노트북 대여 수량 : " + equipList['N'] + "'readonly>").appendTo($inputDiv);
                            $("#N").val("노트북 대여 수량 : " + N);
                            $("#M").val("마이크 대여 수량 : " + M);
                            $("#V").val("빔프로젝터 대여 수량 : " + V);
                            $("#W").val("화이트보드 대여 수량 : " + W);
                        }
                    })

                    $("#resPurpose").val(pastRes[i].resPurpose);
                    $("#resType").val(pastRes[i].resType);
                    $("#resOutside").val(pastRes[i].resOutside);

                    if (pastRes[i].resSnack == 1) {
                        $("#resSnack").prop("checked", true);
                    } else {
                        $("#resSnack").prop("checked", false);
                    }

                    if (pastRes[i].resNW == 1) {
                        $("#resNetwork").prop("checked", true);
                    } else {
                        $("#resNetwork").prop("checked", false);
                    }
                }
            }
        })

        ////////////////////////////////////////////////////////////참석자명단 id : empList-modal-body

        ///////////////////////////////////////////////////////////////회의구분 선택자
        $("#resType1").on("click", function() {
            $("#resType").attr("value", $("#resType1").text());
        })
        $("#resType2").on("click", function() {
            $("#resType").val($("#resType2").text());
        })
        $("#resType3").on("click", function() {
            $("#resType").val($("#resType3").text());
        })
        $("#resType4").on("click", function() {
            $("#resType").val($("#resType4").text());
        })

        /////////////////////////기자재 modal // id : equip-modal-body
        var equipList = JSON.parse('${equipList}');

        $("#equipElement").val("빔프로젝터 (" + equipList['V'] + "),화이트보드 (" + equipList['W'] + "),마이크 (" + equipList['M'] + "),노트북 (" + equipList['N'] + ")")

        for (var i = 0; i < Object.keys(equipList).length; i++) {
            var $inputDiv = $("<div></div>").attr("class", "input-group");

            if (Object.keys(equipList)[i] == 'N') {
                var $minusBtn = $("<div class='input-group-prepend'><button class='btn btn-secondary' type='button' id='NMinusBtn'>-</button></div>").appendTo($inputDiv);
                $("<input class='form-control' id='N' name='N' type='text' value='노트북 대여 수량 : " + equipList['N'] + "'readonly>").appendTo($inputDiv);
                var $plusBtn = $("<div class='input-group-append'><button class='btn btn-secondary' type='button' id='NPlusBtn'>+</button></div>").appendTo($inputDiv);
            } else if (Object.keys(equipList)[i] == 'V') {
                var $minusBtn = $("<div class='input-group-prepend'><button class='btn btn-secondary' type='button' id='VMinusBtn'>-</button></div>").appendTo($inputDiv);
                $("<input class='form-control' id='V' type='text' value='빔프로젝터 대여 수량 : " + equipList['V'] + "'readonly>").appendTo($inputDiv);
                var $plusBtn = $("<div class='input-group-append'><button class='btn btn-secondary' type='button' id='VPlusBtn'>+</button></div>").appendTo($inputDiv);
            } else if (Object.keys(equipList)[i] == 'M') {
                var $minusBtn = $("<div class='input-group-prepend'><button class='btn btn-secondary' type='button' id='MMinusBtn'>-</button></div>").appendTo($inputDiv);
                $("<input class='form-control' id='M' type='text' value='마이크 대여 수량 : " + equipList['M'] + "'readonly>").appendTo($inputDiv);
                var $plusBtn = $("<div class='input-group-append'><button class='btn btn-secondary' type='button' id='MPlusBtn'>+</button></div>").appendTo($inputDiv);
            } else {
                var $minusBtn = $("<div class='input-group-prepend'><button class='btn btn-secondary' type='button' id='WMinusBtn'>-</button></div>").appendTo($inputDiv);
                $("<input class='form-control' id='W' type='text' value='화이트보드 대여 수량 : " + equipList['W'] + "'readonly>").appendTo($inputDiv);
                var $plusBtn = $("<div class='input-group-append'><button class='btn btn-secondary' type='button' id='WPlusBtn'>+</button></div>").appendTo($inputDiv);
            }
            $inputDiv.appendTo($("#equip-modal-body"))
        }
        $(document).on("click", "#NMinusBtn", function() {

            if (($("#N").val().split(":")[1]) == 0) {

            } else {
                $("#N").val('노트북 대여 수량 : ' + (($("#N").val().split(":")[1]) - 1))
            }
        })
        $(document).on("click", "#NPlusBtn", function() {

            if (($("#N").val().split(":")[1]) == Number(equipList['N'])) {} else {
                $("#N").val('노트북 대여 수량 : ' + (Number(($("#N").val().split(":")[1])) + 1))
            }
        })
        $(document).on("click", "#VMinusBtn", function() {

            if (($("#V").val().split(":")[1]) == 0) {} else {
                $("#V").val('빔프로젝터 대여 수량 : ' + (($("#V").val().split(":")[1]) - 1))
            }
        })
        $(document).on("click", "#VPlusBtn", function() {

            if (($("#V").val().split(":")[1]) == Number(equipList['V'])) {} else {
                $("#V").val('빔프로젝터 대여 수량 : ' + (Number(($("#V").val().split(":")[1])) + 1))
            }
        })
        $(document).on("click", "#WMinusBtn", function() {

            if (($("#W").val().split(":")[1]) == 0) {} else {
                $("#W").val('화이트보드 대여 수량 : ' + (($("#W").val().split(":")[1]) - 1))
            }
        })
        $(document).on("click", "#WPlusBtn", function() {

            if (($("#W").val().split(":")[1]) == Number(equipList['W'])) {} else {
                $("#W").val('화이트보드 대여 수량 : ' + (Number(($("#W").val().split(":")[1])) + 1))
            }
        })
        $(document).on("click", "#MMinusBtn", function() {

            if (($("#M").val().split(":")[1]) == 0) {} else {
                $("#M").val('마이크 대여 수량 : ' + (($("#M").val().split(":")[1]) - 1))
            }
        })
        $(document).on("click", "#MPlusBtn", function() {

            if (($("#M").val().split(":")[1]) == Number(equipList['M'])) {} else {
                $("#M").val('마이크 대여 수량 : ' + (Number(($("#M").val().split(":")[1])) + 1))
            }
        })
        $("#equipSubmit").on("click", function() {
            $("#equipElement").val("빔프로젝터 (" + Number(($("#V").val().split(":")[1])) + "),화이트보드 (" + Number(($("#W").val().split(":")[1])) + "),마이크 (" + Number(($("#M").val().split(":")[1])) + "),노트북 (" + Number(($("#N").val().split(":")[1])) + ")")
        })
        //////////////////////////////////////////////////////////////////////////////////////////
        var resStartDate = sessionStorage.getItem("currentDate");
        /* 
    	resStartDate;
        
        var now = new Date();

        var year= now.getFullYear();
        var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
        var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
        var hh = now.getHours()>9 ?''+now.getHours() : '0'+now.getHours();
        var min = now.getMinutes()>9 ?''+now.getMinutes() : '0'+now.getMinutes(); 
        var today = year + '/' + mon + '/' + day+" "+hh+":"+min;
    	
 */ //////////////////////////////////////////////////////////////////////////////////
        // 시간버튼클릭시 배열에 해당시간 입력후 중복제거 
        var selectTimes = [];
        var sendTimes = [];
        console.log(resStartDate)
        $(document).on('click', '.btn-outline-secondary', function(e) {
            var rsd = $("#resStartDate").val();
            var red = $("#resEndDate").val();

            if (rsd.includes("-") && red.includes("-")) {

                if (selectTimes.length == 1) {

                    var startTime = $("#resStartDate").val();
                    var startMonth = Number(($("#resStartDate").val().split("-")[1]));
                    var endMonth = Number(($("#resEndDate").val().split("-")[1]));
                    var start = Number(($("#resStartDate").val().split("-")[2]).split(" ")[0]);
                    var end = Number(($("#resEndDate").val().split("-")[2]).split(" ")[0]);

                    var longtime = end - start;

                    if (endMonth > startMonth) {
                        longtime = 1;
                    } else if (endMonth < startMonth) {
                        longtime = -1;
                    }

                    if (longtime >= 1) {
                        alert("장기예약입니다. \n(장기예약은 상위관리자의 승인이 필요합니다.)")
                        $("<input>").attr("type", "hidden").attr("value", "res_0").attr("name", "resState").appendTo($("#resForm"));
                    } else if (longtime >= 0 && longtime < 1) {
                        $("<input>").attr("type", "hidden").attr("value", "res_1").attr("name", "resState").appendTo($("#resForm"));
                    } else if (longtime < 0) {
                        alert("시작시간보다 뒤의 날짜를 선택하세요")
                        $("#resEndDate").val("");
                    }

                }

            } else {

            }

            var choiceTime = e.currentTarget.id;

            if (selectTimes.length == 0) {
                selectTimes.push(choiceTime);
            } else {
                if (selectTimes.contains(choiceTime)) {
                    const idx = selectTimes.indexOf(choiceTime)
                    if (idx > -1) selectTimes.splice(idx, 1)
                } else {
                    selectTimes.push(choiceTime);
                }
            }

            if (selectTimes.length == 1) {
                var rrsd = $("#resStartDate").val();
                $("#resStartDate").val(rrsd.split(" ")[0] + " " + selectTimes[0]);
            } else if (selectTimes.length == 2) {
                var rred = $("#resEndDate").val();
                $("#resEndDate").val(rred.split(" ")[0] + " " + selectTimes[1]);
            }
            $("#times").remove();
            $("<input>").attr("type", "hidden").attr("name", "times").attr("id", "times").attr("value", selectTimes).appendTo($("#resForm"));

        })

        ////////////////////////////////////////////////////////////////////////////////// 

        $("#sendForm").on("click", function() {
            var form = $("#resForm").serialize();

            $.ajax({
                url: "/meeting/reservation/writeReservation",
                data: form,
                method: "post",
                success: function() {
                    location.href = "/meeting/users/mypage";
                }
            })
        })
        //////////////////////////////////////////////////////////////
        $("#resStartDate").on("focus", function() {
            sessionStorage.setItem("currentDateUse", " ");
        })


        ///////////////////////////////////////////////////////////////////////////////// 


        function drawTime() {
            $(".btn-group").empty();
            var changeTime = "09:00";
            var splitMinTime = changeTime.substr(3, 5);
            var splitHourTime = changeTime.substr(0, 2);
            var aTime = new Array();
            var sessionTime = sessionStorage.getItem("availTime");
            aTime = sessionTime.split(",");

            // 허용날짜 중복제거
            var newTimes = [];
            $.each(aTime, function(i, el) {
                if ($.inArray(el, newTimes) === -1) newTimes.push(el);
            });

            // 시간재구성
            for (var i = 0; i < newTimes.length; i++) {
                var hour = newTimes[i].substr(1, 1);
                if (hour == ":") {
                    newTimes[i] = "0" + newTimes[i]
                }
                var min = newTimes[i].substr(3, 1)
                if (min == "0") {
                    newTimes[i] = newTimes[i] + "0"
                }
            }

            // 시간뿌리기
            for (var i = 0; i < 19; i++) {

                for (var j = 0; j < newTimes.length; j++) {
                    var $label;
                    if (changeTime == newTimes[j]) { //style="height: 10px;"
                        $label = $("<button type='button'></button>").attr("class", "btn btn-warning btn-sm").attr("id", changeTime).attr("style", "width:100%;height:100%;border: 2px solid #ced4da;font-size:0.3rem;").attr("disabled", "").text(changeTime);
                        break;
                    } else {
                        $label = $("<button type='button'></button>").attr("class", "btn btn-outline-secondary btn-sm").attr("id", changeTime).attr("style", "width:100%;height:100%;border: 2px solid #ced4da;font-size:0.3rem;").text(changeTime);
                    }
                }
                var $secondLabel = $label.appendTo($(".btn-group-time"))
                var $input = $("<input>").attr("type", "checkbox").attr("autocomplete", "off").appendTo($secondLabel);

                if (splitMinTime == "00") {
                    splitMinTime = "30";
                } else if (splitMinTime == "30") {
                    splitHourTime = Number(splitHourTime) + 1;
                    splitMinTime = "00";
                } else {
                    console.log("error");
                }
                changeTime = splitHourTime + ":" + splitMinTime;
            }

            var currentTime = new Date();
            var currentMonth = String(currentTime.getMonth() + 1);
            if (currentMonth.length == 1) {
                currentMonth = "0" + currentMonth;
            }
            var currentDay = String(currentTime.getDate());
            if (currentDay.length == 1) {
                currentDay = "0" + currentDay;
            }
            var getCurrentTime = currentTime.getFullYear() + "-" + currentMonth + "-" + currentDay;

            if (sessionStorage.getItem("currentDateUse").includes("-")) {
                if ((sessionStorage.getItem("currentDateUse") == getCurrentTime && $("#resStartDate").val() == getCurrentTime)) {
                    console.log("세션있고 현재날짜가 오늘날짜")
                    console.log(getCurrentTime)
                    var currentHour = new Date();
                    ctrHour = String(currentHour.getHours());

                    if (ctrHour.length == 1) {

                        ctrHour = "0" + ctrHour;
                    }
                    ctrMinute = currentHour.getMinutes();

                    if (ctrMinute >= 0 && ctrMinute <= 30) {
                        ctrMinute = "00";
                    } else {
                        ctrMinute = "30";
                    }
                    console.log(ctrHour + ":" + ctrMinute);
                    var resultHour = "#" + ctrHour + ":" + ctrMinute;
                    drawBtn(resultHour)
                }
            } else {
                if ($("#resStartDate").val() == getCurrentTime) {
                    console.log("세션없고 현재날짜로만")
                    console.log(getCurrentTime)
                }
            }
        }

        function drawBtn(data) {

            $(data).removeClass("btn btn-outline-secondary btn-sm");
            $(data).addClass("btn btn-warning btn-sm");
        }
        var splitDate = resStartDate.split("-")[2];
        var transDate = splitDate.split(" ")[0] - 1;

        if (String(transDate).length == 1) {
            transDate = "0" + transDate;
        }
        var resultDate = resStartDate.split("-")[0] + "-" + resStartDate.split("-")[1] + "-" + transDate + " " + "09:00";

        timeAJAX(resultDate);
        drawTime();
        $(document).on("click", ".btn-sm", function() {
            if ($("#resEndDate").val() == "") {
                $("#resEndDate").focus();
            }
        })
        //변경
        //$("<div style='width:100%;height:100%'></div>").html("<p>9&emsp;&emsp;10&emsp;&emsp;11&emsp;&emsp;12&emsp;&emsp;13&emsp;&emsp;14&emsp;&emsp;15&emsp;&emsp;16&emsp;&emsp;17&emsp;&emsp;18</p>").appendTo($(".bs-component"))

        new Swiper('.swiper-container', {

            // 자동높이 사용여부 : 사용하지 않을시 기본값은 false
            autoHeight: true,
            loop: true, // 슬라이드 반복

        });
        ///////////////////////////////////////////////////////////////////////

        $('#resStartDate').val(resStartDate);
        $('#resMrName').val(sessionStorage.getItem("mrName"));
        $('#mrId').val(sessionStorage.getItem("mrId"));
        // $('#resDate').val(today);
        $.ajax({
            url: "/meeting/users/getCurrentId",
            method: "post",
            data: "_csrf=${_csrf.token}",
            success: function(data) {
                var emp = data;
                $('#empId').val(emp.empId);
                $('#resName').val(emp.empName);
                $("#targetName").text(emp.empName);
            }
        });
        $("#resEndDate").blur(function() {
            /*  
            var resStartDateArr = $('#resStartDate').val();
        	var startDateArr = resStartDateArr.split('/');
        	
            var resEndDateArr = $('#resEndDate').val();
            var endDateArr = resEndDateArr.split('/');
            
            var startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1])-1, startDateArr[2].substring(1,2),startDateArr[2].substring(3,5),startDateArr[2].substring(6,8));
            var endDateCompare = new Date(endDateArr[0], parseInt(endDateArr[1])-1, endDateArr[2].substring(1,2),endDateArr[2].substring(3,5),endDateArr[2].substring(6,8));

            if(startDateCompare > endDateCompare) {            
                console.log("시작날짜와 종료날짜를 확인해 주세요.");  
                $('#resEndDate').val("");
            }else if(((endDateArr[2].substring(3,5))-(startDateArr[2].substring(3,5))) >= 8)
           		console.log("장기")
           	 */
            var startTime = $("#resStartDate").val();

            /* if(startTime.includes("/")){
           		var startMonth = Number( ($("#resStartDate").val().split("/")[1]));
                var endMonth = Number( ($("#resEndDate").val().split("/")[1]));
                var start = Number( ($("#resStartDate").val().split("/")[2]).split(" ")[0] );
                var end = Number( ($("#resEndDate").val().split("/")[2]).split(" ")[0] );
           	} */

            var startMonth = Number(($("#resStartDate").val().split("-")[1]));
            var endMonth = Number(($("#resEndDate").val().split("-")[1]));
            var start = Number(($("#resStartDate").val().split("-")[2]).split(" ")[0]);
            var end = Number(($("#resEndDate").val().split("-")[2]).split(" ")[0]);

            var longtime = end - start;

            if (endMonth > startMonth) {
                longtime = 1;
            } else if (endMonth < startMonth) {
                longtime = -1;
            }

            if (longtime >= 1) {
                alert("장기예약입니다. \n(장기예약은 상위관리자의 승인이 필요합니다.)")
                $("<input>").attr("type", "hidden").attr("value", "res_0").attr("name", "resState").appendTo($("#resForm"));
            } else if (longtime >= 0 && longtime < 1) {
                $("<input>").attr("type", "hidden").attr("value", "res_1").attr("name", "resState").appendTo($("#resForm"));
            } else if (longtime < 0) {
                alert("시작시간보다 뒤의 날짜를 선택하세요")
                $("#resEndDate").val("");
            }

            /////////////////////////////////////////////cost계산
            var t1 = $("#resStartDate").val();
            var t2 = $("#resEndDate").val();

        });



        //////////////////////////////////////////////////////////////////////////////
        $("<input>").attr("type", "hidden").attr("id", "startTime").attr("name", "resStartDate").attr("value", sessionStorage.getItem("currentDate")).appendTo($("#resForm"));
        $('#resStartDate').datetimepicker({
            timepicker: false,
            format: 'Y-m-d',
            onSelectDate: function(data) {
                $("#startTime").val(JSON.stringify(data));

                timeAJAX(data);
            }
        });
        $('#resEndDate').datetimepicker({
            timepicker: false,
            format: 'Y-m-d',
            onSelectDate: function(data) {

                $("<input>").attr("type", "hidden").attr("name", "resEndDate").attr("value", JSON.stringify(data)).appendTo($("#resForm"));
                timeAJAX(data);
            }
        });

        function timeAJAX(data) {
            var mrId = sessionStorage.getItem("mrId");

            var availableDate = JSON.stringify(data);
            $.ajax({
                url: "/meeting/reservation/available/" + mrId + "/" + availableDate,
                type: "post",
                data: "_csrf=${_csrf.token}",
                success: function(data) {

                    var resultDate = JSON.parse(data)
                    var wantDate = new Array();
                    var count = 0;

                    for (var i = 0; i < resultDate.length; i++) {
                        var calcDate = resultDate[i];

                        for (var j = 0; j < calcDate.length; j++) {
                            wantDate[count] = calcDate[j];
                            count++;
                        }
                    }

                    sessionStorage.setItem("availTime", wantDate);
                    drawTime();
                }
            })
        }

        var customSettings = $('#empList').bootstrapDualListbox('getContainer');
        customSettings.find('.btn-default').remove();
        customSettings.find('.btn-group').remove();
    });
</script>