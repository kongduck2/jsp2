<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.FreeboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//request.setCharacterEncoding("UTF-8"); password는 영문+숫자라 필요없음
	int idx = Integer.parseInt(request.getParameter("idx"));
	String password = request.getParameter("password");
	
	FreeboardDao dao = FreeboardDao.getInstance();
	//2개안만들려고 Object로 만듬
	Map<String,Object> map = new HashMap<>();
	map.put("idx",idx);
	map.put("password", password);
			
	int n = dao.delete(map);
	//비밀번호가 맞으면 리스트로 이동
	//틀리면 alret창 출력하고 다시 detailView로 이동
	String message = null;
	String href = null;
	out.print("<script>");
	if(n==1){ //delete정상 실행
		message ="게시글이 삭제 되었습니다.";
		href="listAction.jsp";
	}else{ //password 틀릴때
		message ="비밀번호가 틀렸습니다.";
		href="detailAction.jsp?page=1&idx="+idx;
	}
	out.print("alert('"+message+"');");
	out.print("location.href='"+href+"';");
	out.print("</script>");
%>
