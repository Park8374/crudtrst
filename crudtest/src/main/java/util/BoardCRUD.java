package util;

import javax.servlet.http.HttpServletRequest;

import sql.SQLConnector;

public class BoardCRUD {
	public SQLConnector conn = new SQLConnector();
	
	public int Create(HttpServletRequest request) {
		String sql = """
		INSERT INTO board (
			board_title, 
			board_content, 
			board_writer,
			board_pw,
			createdate, 
			updatedate
		) VALUES(?,?,?,?,NOW(),NOW())
		""";
		String boardTitle = request.getParameter("boardTitle");
		String boardContent = request.getParameter("boardContent");
		String boardWriter = request.getParameter("boardWriter");
		String boardPw = request.getParameter("boardPw");
		
		return conn.execUpdate(sql, boardTitle, boardContent, boardWriter, boardPw);
	}
}