<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>    
    
<%
	int studentNo = Integer.parseInt(request.getParameter("studentNo"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	 
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "DELETE FROM student WHERE student_no =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,studentNo);
	System.out.println(stmt+" <--stmt");
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("삭제성공");
	}	else {
		System.out.println("삭제실패");
	}
	
	// db관련 프로세스 end --> DB자원 해제 <-- 모델 레이어
	stmt.close();
	conn.close();
	

	//리다이렉션 <-- 컨트롤러 레이어
	response.sendRedirect(request.getContextPath()+"/studentList.jsp");

%>