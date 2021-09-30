<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404 페이지 요청 오류</title>
<style type="text/css">
a{
	text-decoration: none;
	height: 35px;
	width : 130px;
	margin: 30px;
	color: gray;
	text-align: center;
	border: 1px solid gray;
	padding: 10px 15px;
}
.center{
	margin: 30px auto;
}

</style>
</head>
<body>
<div style="width:50%; margin: auto;padding-top: 10%;">
	<div style="width:50%;">
		<img style="width: 80%;" src="../img/404.jpg" alt="404status"><!-- alt는 이미지 안보일때 출력 텍스트 -->
	</div>
	<h2>요청하신 페이지를 찾을 수 없습니다.</h2>
	<div style="margin: 20px;">요청하신 페이지가 사라졌거나, 잘못된 경로를 이용하셨습니다.</div>
	<a href="${pageContext.request.contextPath }">HOME</a>
	<a href="javascript:history.back()">뒤로가기</a>
	<!-- 상대경로 : 현재 위치를 기준으로 ../ 또는 ./ 또는 경로명/ 
		  절대경로 : 이 애플리케이션의 context 기준으로 한다 -->
</div>

</body>
</html>