<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<style>
	/* 로딩 */
#Progress_Loading
{
   position: fixed;
    left: 0;
    top: 0;
    background: #00000099;
    width: 100%;
    height: 100%;
    z-index: 1001;
}

#Progress_Loading img {
    position: fixed;
    left: 45%;
    top: 48%;
    width: 10%;
    height: auto;
    background-color: white;
    text-align: center;
    padding: 10PX;
    border-radius: 10PX;
}
@media (max-width: 768px) {
	#Progress_Loading img {
	    position: fixed;
	    left: 40%;
    }
}

</style>
</head>
<body>
	<div id="layout">
		<div id="overMenu">
			<tiles:insertAttribute name="header" />
			<tiles:insertAttribute name="nav" />
		</div>
		<div id="section">
			<tiles:insertAttribute name="section"/>
		</div>
	</div>
	<div id="footer">
		<tiles:insertAttribute name="footer" />
	</div>
	<!-- 로딩바 -->
   <div id="Progress_Loading">
        <img src="/meeting/resources/img/Progress_Loading.gif"/>
   </div>
</body>
<script>
$(document).ready(function(){
   $('#Progress_Loading').hide(); //첫 시작시 로딩바를 숨겨준다.
})
.ajaxStart(function(){
   $('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
})
.ajaxStop(function(){
   $('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
});
</script>
</html>

