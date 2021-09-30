<%@page import="dao.FreeboardDao"%>
<%@page import="dto.Freeboard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//수정 버튼 -> 내용 변경 -> 저장버튼으로 실행됨.
	request.setCharacterEncoding("UTF-8");	
	int pageNo = Integer.parseInt(request.getParameter("page"));
	int idx = Integer.parseInt(request.getParameter("idx"));
	String subject = request.getParameter("subject");
	//String name = request.getParameter("name");
	//String password = request.getParameter("password");
	String content = request.getParameter("content");
	//String ip = request.getRemoteAddr();
	Freeboard dto = new Freeboard();
	//dto.setIp(ip);
	//dto.setPassword(password);
	dto.setIdx(idx);
	//dto.setName(name);
	dto.setContent(content);
	dto.setSubject(subject);
	
	FreeboardDao dao = FreeboardDao.getInstance();
	dao.update(dto);
	response.sendRedirect("detailAction.jsp?idx="+idx+"&page="+pageNo);
%>