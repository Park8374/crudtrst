<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "vo.Student"%>
<%
   int studentNo = Integer.parseInt(request.getParameter("studentNo"));
   Class.forName("org.mariadb.jdbc.Driver");
   String url = "jdbc:mariadb://localhost:3306/gdj72";
   String dbuser = "root";
   String dbpw = "java1234";
   
   Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
   String sql = "SELECT student_no studentNo,student_name studentName,student_birth studentBirth,student_gender studentGender,createdate ,Updatedate,team_no teamNo FROM student WHERE student_no = ?";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setInt(1, studentNo);
   ResultSet rs = stmt.executeQuery();
   Student student = null;
   if(rs.next()) {
	  student  = new Student();
	  student.studentNo = rs.getInt("studentNo");
	  student.studentName = rs.getString("studentName");
	  student.studentBirth = rs.getString("studentBirth"); 
	  student.studentGender = rs.getString("studentGender");
	  student.createdate = rs.getString("createdate");
	  student.updatedate = rs.getString("updatedate");
	  student.teamNo = rs.getInt("teamNo");
   }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h1>학생 정보 수정</h1>
   <form action="<%=request.getContextPath()%>/updateStudentAction.jsp">
      <table border="1">
         <tr>
            <td>student_no</td>
            <td>
               <input type="number" name="studentNo" value="<%=student.studentNo%>" readonly="readonly">
            </td>
         </tr>
         <tr>
            <td>student_name</td>
            <td>
               <input type="text" name="studentName" value="<%=student.studentName%>">
            </td>
         </tr>
          <tr>
            <td>student_gender</td>
            <td>
               <input type="text" name="studentName" value="<%=student.studentGender%>">
            </td>
         </tr>
         <tr>
            <td>student_birth</td>
            <td><%=student.studentBirth%></td>
         </tr>
         <tr>
            <td>team_no</td>
            <td>
               <input type="number" name="teamNo" value="<%=student.teamNo%>">
            </td>
         </tr>
         <tr>
            <td>createdate</td>
            <td><%=student.createdate%></td>
         </tr>
         <tr>
            <td>updatedate</td>
            <td><%=student.updatedate%></td>
         </tr>
         <tr>
            <td colspan="2"><button type="submit">수정</button></td>
         </tr>
      </table>
   </form>
</body>
</html>