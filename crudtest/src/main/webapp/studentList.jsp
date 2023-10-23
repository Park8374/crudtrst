<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Student" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234"; 
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	int beginRow = 0;
	int rowPerPage = 10;
	/*
		SELECT board_no boardNo, board_title boardTitle, createdate 
		FROM board 
		ORDER BY createdate DESC 
		LIMIT ?,?
	*/
	String sql = "SELECT student_no studentNo,student_name studentName , student_birth studentBirth FROM student ORDER BY student_name DESC";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<Student> list = new ArrayList<Student>();
	while(rs.next()) {
		Student s = new Student();
		s.studentNo = rs.getInt("studentNo");
		s.studentName = rs.getString("studentName");
		s.studentBirth= rs.getString("studentBirth");
		list.add(s);
	}
	// DB자원반납
	rs.close();
	stmt.close();
	conn.close();
	// Model Layer
%>
	<!-- View Layer -->
	<ul>
		<li><a href="<%=request.getContextPath()%>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath()%>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath()%>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath()%>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath()%>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>학생명단</h1>
	<div>
		<a href="<%=request.getContextPath()%>/addStudentForm.jsp">학생추가</a>
	</div>
	
	<table border="1">
		<tr>
			<th>학생명</th>
			<th>생일</th>
		</tr>
		<%
			for(Student s : list) {
		%>
				<tr>
					<td>
						<a href="<%=request.getContextPath()%>/studentOne.jsp?studentNo=<%=s.studentNo%>">
							<%=s.studentName%>
						</a>
					</td>
					<td>
						<%=s.studentBirth%>
					</td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>