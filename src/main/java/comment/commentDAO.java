package comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.JDBConnect;


public class commentDAO extends JDBConnect {

	
	//=======================add from saemin START=======================//
		// Home/Home - 댓글 등록
		public String insertComment(HttpServletRequest request, HttpServletResponse response, String bid, String comment, String commentDetail, String boardCount) {
			
			HttpSession session = request.getSession();
			session.setAttribute("boardCount", boardCount);
			String memberId = (String)session.getAttribute("memberId");
			String getId=""; //종욱추가
			String pageMove="";
	    	try {
	    		//종욱 추가
	    		String query = "select id from boardtbl where bid=?";
	    		psmt = con.prepareStatement(query);
	    		psmt.setString(1, bid);
	    		rs = psmt.executeQuery();
	    		
	    		if(rs.next()) {getId = rs.getString("id");}
	    		psmt.close();
	    		rs.close();
	    		//
	    		
	        	query = "INSERT INTO commenttbl(cid, content, id) VALUES(?, ?, ?)";
	            psmt = con.prepareStatement(query);
	        	psmt.setString(1, memberId);
	        	psmt.setString(2, comment);
	        	psmt.setString(3, bid);
	        	psmt.executeUpdate();
	        	psmt.close();
	        	
	        	//종욱 추가
	        	String notice = String.format("%s님이 %s게시글에 댓글을 달았습니다",memberId,bid);
	        	query = "insert into noti(getid,putid,notice,created_at) values(?,?,?,now())";	
	        	psmt = con.prepareStatement(query);
	        	psmt.setString(1, getId);
	        	psmt.setString(2, memberId);
	        	psmt.setString(3, notice);
	        	psmt.executeUpdate();
	        	//
	        	
	        	
	            System.out.println(memberId + "가 " + bid + "번 게시글에 \"" + comment + "\" 내용으로 작성 성공");
	        }
	        catch (Exception e) {
	        	System.out.println(memberId + "가 " + bid + "번 게시글에 \"" + comment + "\" 내용으로 작성 실패");
	            e.printStackTrace();
	        }
	        
	    	if (commentDetail.equals("Home")) {
				pageMove = "/Home/Home.jsp";
			}
			else if (commentDetail.equals("HomeComment")) {
				pageMove = "/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=" + bid;
			}
	    	return pageMove;
	    }
		
		
		   // Home/HomeComment - 댓글 삭제
		   public String deleteComment(HttpServletRequest request, HttpServletResponse response, String cid, String bid) {
		      
		      HttpSession session = request.getSession();
//		      session.setAttribute("boardCount", boardCount);
		      String memberId = (String)session.getAttribute("memberId");
		      String pageMove="";
		      
		       try {
		          
		          String query = "DELETE FROM commenttbl WHERE commentid = ?";
		           psmt = con.prepareStatement(query);
		           psmt.setString(1, cid);
		           psmt.executeUpdate();
		           

		            //종욱 알림 추가
		        	psmt.close();
		        	String notice = String.format("%s님이 %s게시글에 댓글을 달았습니다",memberId,bid);
		        	query = "delete from noti where notice=?";
		        	psmt = con.prepareStatement(query);
		        	psmt.setString(1, notice);
		        	psmt.executeUpdate();
		        	//
		           
		            System.out.println(memberId + "가 " + cid + "번 댓글 삭제 성공");
		        }
		        catch (Exception e) {
		           System.out.println(memberId + "가 " + cid + "번 댓글 삭제 실패");
		            e.printStackTrace();
		        }
		        
		      pageMove = "/Home/Home.jsp";
		       return pageMove;
		    }
		
		//=======================add from saemin END=======================//
}