<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%
	int studentNo = Integer.parseInt(request.getParameter("studentNo"));
	String studentName = request.getParameter("studetnName");
	int teamNo = Integer.parseInt(request.getParameter("teamNo"));
	String studentGender = request.getParameter("studentGender");
	
	// Db 자원 연결
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/gdj72";
		String dbuser = "root";
		String dbpw = "java1234";
		 
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "UPDATE student SET student_name = ?, team_no = ?,student_gender = ? ,updatedate = NOW() WHERE student_no = ? ";
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(2,studentName);
		stmt.setInt(3,teamNo);
		stmt.setString(4,studentGender);
		
		
	
		
		System.out.println(stmt+" <--stmt");
		int row = stmt.executeUpdate();
		
		if(row == 1) {
			response.sendRedirect(request.getContextPath()+"/studentOne.jsp?studentNo="+studentNo);
		}	else {
			response.sendRedirect(request.getContextPath()+"/updateStudentForm.jsp?studentNo="+studentNo);
		}
		// db관련 프로세스 end -> DB자원 해제
		stmt.close();
		conn.close();
	%>	