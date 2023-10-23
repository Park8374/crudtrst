<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "vo.Board" %>
<%
   int boardNo = Integer.parseInt(request.getParameter("boardNo"));
   String boardPw = String.valueOf(request.getParameter("boardPw"));  
   if (boardPw.equals("null")) {
%>       
	<form>
      <input type="hidden" name="boardNo" value="<%=boardNo%>"/>
      <input name="boardPw" placeholder="설정한 비번 입력">
      <button type="submit">수정</button>
   </form>
<% 
   } else {
   // Db자원 연결
   Class.forName("org.mariadb.jdbc.Driver");
   String url = "jdbc:mariadb://localhost:3306/gdj72";
   String dbuser = "root";
   String dbpw = "java1234";
   
   Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
   String sql = "SELECT board_no AS boardNo, board_title AS boardTitle, board_content AS boardContent , board_writer AS boardWriter, board_pw AS boardPw , createdate , updatedate FROM board  WHERE board_no = ? AND board_pw = ? ";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setInt(1, boardNo);
   stmt.setString(2, boardPw);
   ResultSet rs = stmt.executeQuery();
   Board board = null;
   
   if(rs.next()) {
      board = new Board();
      board.boardNo = rs.getInt("boardNo");
      board.boardTitle = rs.getString("boardTitle");
      board.boardContent = rs.getString("boardContent");
      board.boardWriter = rs.getString("boardWriter");
      board.boardPw      = rs.getString("boardPw");
      board.createdate = rs.getString("createdate");
      board.updatedate = rs.getString("updatedate");
      
   }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h1>게시글수정</h1>
   <form action="<%=request.getContextPath()%>/updateBoardAction.jsp">
      <table border="1">
         <tr>
            <td>board_no</td>
            <td>
               <input type="number" name="boardNo" value="<%=board.boardNo%>" readonly="readonly">
            </td>
         </tr>
         <tr>
            <td>board_title</td>
            <td>
               <input type="text" name="boardTitle" value="<%=board.boardTitle%>">
            </td>
         </tr>
         <tr>
            <td>board_content</td>
            <td>
               <textarea rows="8" cols=30 name="boardContent"><%=board.boardContent%></textarea>
            </td>
         </tr>
         <tr>
            <td>board_writer</td>
            <td>
               <input type="text" name="boardWriter" value="<%=board.boardWriter%>">
            </td>
         </tr>
         <tr>
            <td>board_pw</td>
            <td>
               <input type="text" name="boardPw" value="<%=board.boardPw%>">
            </td>
         </tr>
         <tr>
            <td>createdate</td>
            <td><%=board.createdate%></td>
         </tr>
         <tr>
            <td>updatedate</td>
            <td><%=board.updatedate%></td>
         </tr> 
         <tr>
            <td colspan="2"><button type="submit">수정</button></td>
         </tr>
      </table>
   </form>

</body>
</html>
<%
}
%>