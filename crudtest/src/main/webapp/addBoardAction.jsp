<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="util.BoardCRUD" %>
<%
	BoardCRUD crud = new BoardCRUD();
	int row = crud.Create(request);
	if(row == 1) {
		System.out.println("입력성공");
	}	else {
		System.out.println("입력실패");
	}
	
	// 리다이렉션 <-- 컨트롤러 레이어
	response.sendRedirect(request.getContextPath()+"/boardList.jsp");
%>