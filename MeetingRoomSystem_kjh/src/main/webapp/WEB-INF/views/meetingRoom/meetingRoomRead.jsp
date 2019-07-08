<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>회의실 관리</title>
    <style>
        .grid-mt {
            padding: 20px;
            display: grid;
        }

        .upload-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
        }

        .upload-wrapper input[type="file"] {
            font-size: 100px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
        }

        .col-md-4 {
            padding-top: 10px;
            padding-bottom: 10px;
        }

        .col-md-6 {
            padding-top: 10px;
            padding-bottom: 10px;
        }
    </style>

    <script>
        $(function() {

            var meetingRoom = JSON.parse('${meetingRoom}');
            //잠시 저장하기 위한 임시 버퍼	

            $('#imgArea').attr('height', $("#rightCol").height() * 0.7);
            $('#imgArea').attr("width", $("#leftCol").width() * 0.8);
            $('#leftCol').css("height", $("#rightCol").height());


            document.getElementById("imgArea").src = meetingRoom.mrImg;
            document.getElementById("branchNameSelectBox").value = meetingRoom.brId;
            document.getElementById("mrName").value = meetingRoom.mrName;
            document.getElementById("mrLimit").value = meetingRoom.mrLimit;
            document.getElementById("mrPrice").value = meetingRoom.mrPrice;
            document.getElementById("mrArea").value = meetingRoom.mrArea;
            document.getElementById("mrLocation").value = meetingRoom.mrLocation;
            if (meetingRoom.mrNetwork == "net_1") {
                document.getElementById('mrNetworkHidden').checked = false;
                document.getElementById('mrNetwork').checked = true;
            } else {
                document.getElementById('mrNetworkHidden').checked = true;
                document.getElementById('mrNetwork').checked = false;
            }
            document.getElementById("mrIdHiddenArea").value = meetingRoom.mrId;
            document.getElementById("meetingRoomTypeSelectBox").value = meetingRoom.mrType;
            document.getElementById("empNameSelectBox").value = meetingRoom.empId;
            
            $('#mrLimit').numeric();
    		$('#mrArea').numeric();
    		$('#mrPrice').numeric();
    		
    		
            //데이터 및 이미지 기본 세팅 


            $('#mrNetwork').change(function() {
                if (document.getElementById('mrNetwork').checked == true) {
                    document.getElementById('mrNetworkHidden').value = "net_1";
                } else if (document.getElementById('mrNetwork').checked == false) {
                    document.getElementById('mrNetworkHidden').value = "net_0";
                }
            });

            $("#imgUpload").change(function() {
                if (this.files[0].type.indexOf("image") == -1) {
                    swal({
                        title: "오류",
                        text: "사진 형식의 파일을 업로드 해주세요.",
                        type: "warning",
                        confirmButtonText: "확인",
                        closeOnConfirm: true,
                    });
                } else {

                    if (this.files && this.files[0]) {
                        var reader = new FileReader();

                        reader.onload = function(e) {
                            $('#imgArea').attr('src', e.target.result);
                            $('#imgArea').attr('height', $("#rightCol").height() * 0.6);
                            $('#imgArea').attr("width", $("#leftCol").width() * 0.8);
                        }
                        reader.readAsDataURL(this.files[0]);
                    }
                }
            });

            $(window).resize(function() {
                $('#imgArea').attr('height', $("#rightCol").height() * 0.7);
                $('#imgArea').attr("width", $("#leftCol").width() * 0.8);
                $('#leftCol').css("height", $("#rightCol").height());
            });


            $('#modalOpen').click(function() {
                var missingList = "";
                if ($("#branchNameSelectBox").children(":selected").attr("id") == null)
                    missingList = missingList + "소속 지사, ";
                if ($("#meetingRoomTypeSelectBox").children(":selected").attr("id") == null)
                    missingList = missingList + "회의실 유형, ";
                if ($("#mrName").val() == "")
                    missingList = missingList + "회의실 이름, ";
                if ($("#mrLocation").val() == "")
                    missingList = missingList + "회의실 위치, ";
                if ($("#mrPrice").val() == "")
                    missingList = missingList + "30분당 사용요금, ";
                if ($("#mrLimit").val() == "")
                    missingList = missingList + "수용인원, ";
                if ($("#mrArea").val() == "")
                    missingList = missingList + "회의실 면적, ";
                if ($("#empNameSelectBox").children(":selected").attr("id") == null)
                    missingList = missingList + "회의실 관리자, ";
                console.log(missingList.index);
                if (missingList != "") {
                    missingList = missingList.substr(0, missingList.length - 2);
                    swal({
                        title: "오류",
                        text: missingList + "을(를) 입력해주세요.",
                        type: "warning",
                        confirmButtonText: "OK",
                        closeOnConfirm: true,
                    });
                } else {

                    $("#confirm").modal('show');
                    $("#modalBranchName").text($("#branchNameSelectBox").children(":selected").attr("id"));
                    $("#modalMeetingRoomType").text($("#meetingRoomTypeSelectBox").children(":selected").attr("id"));
                    $("#modalMeetingRoomName").text($("#mrName").val());
                    $("#modalMeetingRoomLocation").text($("#mrLocation").val());
                    $("#modalMeetingRoomPrice").text($("#mrPrice").val());
                    $("#modalMeetingRoomLimit").text($("#mrLimit").val());
                    $("#modalMeetingRoomArea").text($("#mrArea").val());
                    $("#modalMeetingRoomAdmin").text($("#empNameSelectBox").children(":selected").attr("id"));

                    if (document.getElementById('mrNetwork').checked == true) {
                        $("#modalMeetingRoomNetwork").text("지원 가능");
                    } else {
                        $("#modalMeetingRoomNetwork").text("지원 불가");
                    }
                }
            });

            $('#finallyConfirm').click(function() {
                $('#meetingRoomUpdate').submit();
            });

        });
    </script>
</head>


<body>
    <main class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-calendar"></i>회의실관리</h1>
                <p>
                    전체 회의실 목록입니다.
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
                    <a href="/meeting/meetingRoom/list">회의실관리</a>
                </li>
            </ul>
        </div>

        <form action="/meeting/file/meetingRoomUpdate" id="meetingRoomUpdate" method="POST" enctype="multipart/form-data">
            <div class="row">
                <input type="hidden" name="mrId" id="mrIdHiddenArea"> <!-- 바로 세팅이 안된다. 따로 해줘야할듯 -->
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <div class="col-md-4">
                    <div class="tile" style="text-align:center" id="leftCol">
                        <div class="tile-body" style="text-align:center;">
                            <img class="user-img" id="imgArea" src="/meeting/resources/img/imgVoid.JPG" style="border-radius: 10px; margin-bottom:20px">

                        </div>

                        <div class="tile-footer" style="text-align:right; vertical-align:bottom;">
                            <div class="upload-wrapper">
                                <button class="btn btn-primary"><i class="fa fa-file-image-o" aria-hidden="true"></i>업로드</button>
                                <input type="file" id="imgUpload" name="mrImg" accept="image/*" >
                            </div>
                        </div>
                        <!--                         다이어로그가 안뜨고 submit 되어버리는 오류 -->
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="tile" id="rightCol">
                        <h3 class="tile-title" style="padding-bottom:10px; border-bottom:1px solid #ddd">회의실 정보를 입력하여 주십시오</h3>
                        <div class="tile-body">
                            <div class="form-horizontal">
                                <div class="form-group row" style="padding-bottom:10px">
                                    <div class="col-md-4">
                                        <select class="form-control" name="brId" id="branchNameSelectBox">
                                            <!-- 보여지는거는 네임으로, 보내지는 파라미터는 지사이름으로 보내져야한다. -->
                                            <option value="none" hidden>지사 선택</option>
                                            <c:forEach items='${branchList}' var="branchList">
                                                <option value="${branchList.brId}" id="${branchList.brName}">${branchList.brName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <select class="form-control" name="mrType" id="meetingRoomTypeSelectBox">
                                            <option value="" hidden>회의실 유형 선택</option>
                                            <option value="mr_type_0" id="회의실">회의실</option>
                                            <option value="mr_type_1" id="대회의실">대회의실</option>
                                            <option value="mr_type_2" id="교육실">교육실</option>
                                        </select>
                                    </div> 
                                    <div class="col-md-4">
                                        <input class="form-control" id="mrName" name="mrName" type="text" placeholder="회의실 이름을 입력해주세요">
                                    </div>
                                </div>
                                <div class="form-group row" style="padding-bottom:10px">
                                    <div class="col-md-12">
                                        <input class="form-control" id="mrLocation" type="text" placeholder="주소를 입력해주세요" name="mrLocation" autocomplete="off">
                                    </div>
                                </div>
                                <div class="form-group row" style="padding-bottom:10px">
                                    <div class="col-md-6">
                                        <input class="form-control" id="mrPrice" type="text" placeholder="30분당 비용을 입력헤주세요" name="mrPrice" autocomplete="off">
                                    </div>
                                    <div class="col-md-6">
                                        <input class="form-control" id="mrLimit" type="text" placeholder="최대 수용인원을 입력해주세요" name="mrLimit" autocomplete="off">
                                    </div>
                                </div>
                                <div class="form-group row" style="padding-bottom:10px">
                                    <div class="col-md-4">
                                        <input class="form-control" id="mrArea" type="text" placeholder="면적(m²)를 입력해주세요" name="mrArea" autocomplete="off">
                                    </div>
                                    <div class="col-md-4">
                                        <select class="form-control" name="empId" id="empNameSelectBox">
                                            <option value="none" hidden>관리자 선택</option>
                                            <c:forEach items='${administrator}' var="administrator">
                                                <option value="${administrator.empId}" id="${administrator.empId}">${administrator.empName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="animated-checkbox">
                                            <label>
                                                <input type="checkbox" value="net_1" id="mrNetwork"><span class="label-text">네트워크 지원</span>
                                                <input type="hidden" name="mrNetwork" value="net_0" id="mrNetworkHidden" style="display:none;" />
                                                <!-- 여기서 엠알 타입 둘다 들어가는 현상이 있는데 이를 해결하는 jsp가 필요하다. -->
                                            </label>
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="tile-footer">
                            <!--  modal start -->
                            <!-- 지사, 회의실 유형, 회의실이름, 주소, 30분당 비용, 최대 수용인원, 면적, 관리자, 네트워크 지원 유무 -->
                            <div class="modal fade" id="confirm" role="dialog">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title" style="text-align:center;">입력 확인</h4>
                                            <button type="button" class="close" data-dismiss="modal">×</button>
                                        </div>


                                        <div class="modal-body">
                                            <div class="row mb-4">
                                                <div class="col-md-4">
                                                    <label><h5>소속 지사</h5></label>
                                                    <p id="modalBranchName"></p>
                                                </div>

                                                <div class="col-md-4">
                                                    <label><h5>회의실 유형</h5></label>
                                                    <p id="modalMeetingRoomType"></p>
                                                </div>
                                                <div class="col-md-4">
                                                    <label><h5>회의실 이름</h5></label>
                                                    <p id="modalMeetingRoomName"></p>
                                                </div>
                                            </div>
                                            <div class="row mb-4">
                                                <div class="col-md-6">
                                                    <label><h5>회의실 층수</h5></label>
                                                    <p id="modalMeetingRoomLocation"></p>
                                                </div>
                                                <div class="col-md-6">
                                                    <label><h5>30분당 회의실 사용료</h5></label>
                                                    <p id="modalMeetingRoomPrice"></p>
                                                </div>
                                            </div>
                                            <div class="row mb-4">
                                                <div class="col-md-6">
                                                    <label><h5>최대 수용인원</h5></label>
                                                    <p id="modalMeetingRoomLimit"></p>
                                                </div>
                                                <div class="col-md-6">
                                                    <label><h5>회의실 면적</h5></label>
                                                    <p id="modalMeetingRoomArea"></p>
                                                </div>
                                            </div>
                                            <div class="row mb-4">
                                                <div class="col-md-6">
                                                    <label><h5>회의실 관리자</h5></label>
                                                    <p id="modalMeetingRoomAdmin"></p>
                                                </div>
                                                <div class="col-md-6">
                                                    <label><h5>네트워크 지원 유무</h5></label>
                                                    <p id="modalMeetingRoomNetwork"></p>
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

                            <div class="row">
                                <div class="col-md-8 col-md-offset-3">
                                    <button class="btn btn-primary" type="button" id="modalOpen"><i class="fa fa-fw fa-lg fa-check-circle"></i>확인</button>&nbsp;&nbsp;&nbsp;
                                    <a class="btn btn-secondary" href="/meeting/branch/list"><i class="fa fa-fw fa-lg fa-times-circle"></i>취소</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </main>
</body>
<script type="text/javascript" src="/meeting/resources/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="/meeting/resources/js/plugins/sweetalert.min.js"></script>
<script type="text/javascript" src="/meeting/resources/js/plugins/jquery.numeric.min.js"></script>

</html>