package board;

import db.JDBConnect;
import member.memberDTO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import comment.commentDTO;

public class boardDAO extends JDBConnect {
	
	//dto에 게시글정보 세팅한후 dto리턴
	public boardDTO setBoard(HttpServletRequest request,HttpServletResponse response, String ImageFilePath) {
		HttpSession session = request.getSession();
		boardDTO dto = new boardDTO();
		
		String memberID = (String)session.getAttribute("memberId");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		dto.setId(memberID);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setPhoto(ImageFilePath);
		
		return dto;
	}
	// 데이터베이스에 게시글 업로드
	public void uploadBoard(HttpServletRequest request,HttpServletResponse response, String ImageFilePath) {
		boardDTO dto = setBoard(request,response,ImageFilePath);
		String uploadSql = "insert into boardtbl(id,content,photo) value(?,?,?)";
		
		try {
			psmt = con.prepareStatement(uploadSql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getPhoto());
			psmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
	}
	
	//boardID를 가지고 보드의 게시물 가져와서 DTO저장하는 메서드
	public boardDTO getBoard(String bid) {
		String sql = "select * from board where bid=" + bid;
		boardDTO dto = new boardDTO();
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				dto.setBid(rs.getString("bid"));
				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
				dto.setBirth(sd.format(rs.getDate("birth")));
				dto.setContent(rs.getString("content"));
				dto.setLikeCount(Integer.toString(rs.getInt("likecount")));
				dto.setPhoto(rs.getString("photo"));
				dto.setId(rs.getString("id"));
				dto.setLikeWho(rs.getString("likeWho"));
			}
			
		}catch(Exception e) {
			System.out.println("getBoard Failed");
			e.printStackTrace();
		}
		return dto;
		
	}
	
	//=======================add from saemin START=======================//
	// Home/Home - 게시물 조회
	public String selectBoard(HttpServletRequest request, HttpServletResponse response, String bid, 
	         String comment, String commentDetail, String pageRoute, String m2id, String index) {
	      String pageMove = "/Home/Home.jsp";
	      ArrayList<boardDTO> listBoard = new ArrayList<boardDTO>();
	      ArrayList<commentDTO> listComment = new ArrayList<commentDTO>();
	      ArrayList<boardDTO> likeWhoId = new ArrayList<boardDTO>();
	      ArrayList<boardDTO> photo = new ArrayList<boardDTO>();

	      HttpSession session = request.getSession();
	      String memberId = (String)session.getAttribute("memberId");
	      ResultSet rs2;

	      try {
	         String query = "SELECT A.bid, A.content, A.likecount, A.birth, A.id, A.photo, B.pfp, A.likeWho,\r\n"
	               + "(SELECT count(content) FROM commenttbl C WHERE A.bid = C.id)\r\n"
	               + "FROM boardtbl A LEFT OUTER JOIN membertbl B \r\n"
	               + "ON A.id = B.mid ORDER BY A.birth DESC";
	         //                   + "ON A.id = B.mid WHERE NOT A.id IN (?) ORDER BY A.birth DESC";

	         if(m2id!=null) {
	            pageMove = "/board/AcContent.jsp?m2id="+m2id+"&index="+index;
	            query = "SELECT A.bid, A.content, A.likecount, A.birth, A.id, A.photo, B.pfp, A.likeWho,\r\n"
	                  + "(SELECT count(content) FROM commenttbl C WHERE A.bid = C.id)\r\n"
	                  + "FROM boardtbl A LEFT OUTER JOIN membertbl B \r\n"
	                  + "ON A.id = B.mid where A.id='"+m2id+"' ORDER BY A.birth DESC";
	         }

	         psmt = con.prepareStatement(query);
	         rs = psmt.executeQuery();


	         // commenttbl에 댓글이 1개 이상일때
	         if (rs.next()) {
	            rs = psmt.executeQuery();

	            while (rs.next()) {
	               boardDTO bdto = new boardDTO();
	               bdto.setBid(rs.getString("bid"));
	               bdto.setId(rs.getString("id"));
	               bdto.setContent(rs.getString("content"));     
	               bdto.setLikeCount(rs.getString("likeCount"));
	               String[] birth = rs.getString("birth").substring(0, 10).split("-");
	               if (birth[1].substring(0, 1).equals("0")) {
	                  birth[1] = birth[1].substring(1);
	               }
	               if (birth[2].substring(0, 1).equals("0")) {
	                  birth[2] = birth[2].substring(1);
	               }
	               bdto.setBirth(birth[0] + "년 " + birth[1] + "월 " + birth[2] + "일");
	               bdto.setPfp(rs.getString("pfp"));
	               bdto.setCommentCount(rs.getString(9));

	               // 좋아요 쉼표 분리
	               String db =  rs.getString("likeWho"); // a, b
	               String[] db2 = db.split(", ");


	               for (int i = 0; i < db2.length; i++) {
	                  boardDTO bdtoLike = new boardDTO();
	                  bdtoLike.setLikeId(db2[i]);
	                  bdtoLike.setBid(rs.getString("bid"));
	                  likeWhoId.add(bdtoLike);
	                  
	                  // 좋아요(하트) 색상 바뀌게 하려고
	                  if (memberId != null && memberId.equals(db2[i])) {
	                     bdto.setLikeCondition("Y");
	                  }
	               }
	               
	               

	               // photo 쉼표 분리
	               String db3 =  rs.getString("photo");
	               String[] db4 = db3.split(",");       

	               for (int i = 0; i < db4.length; i++) {
	                  boardDTO bdtoPhoto = new boardDTO();
	                  bdtoPhoto.setBid(rs.getString("bid"));
	                  bdtoPhoto.setPhoto(db4[i]);
	                  bdtoPhoto.setPhoto2(db4[i].replace("\\", "\\\\"));
	                  photo.add(bdtoPhoto);
	               }

	               listBoard.add(bdto);

	               if (!rs.getString(9).equals("0")) {
	                  query = "SELECT DISTINCT C.cid, C.content, C.birth, C.likeCount, C.id\r\n"
	                        + ", (SELECT B.pfp FROM membertbl B WHERE C.cid=B.mid), C.commentid\r\n"
	                        + "FROM membertbl B, commenttbl C WHERE id=?";
	                  psmt = con.prepareStatement(query);
	                  psmt.setString(1, rs.getString("bid"));
	                  rs2 = psmt.executeQuery();

	                  while (rs2.next()) {
	                     commentDTO cdto = new commentDTO();
	                     cdto.setContent(rs2.getString("content"));
	                     String[] birth2 = rs2.getString("birth").substring(0, 10).split("-");
	                     if (birth2[1].substring(0, 1).equals("0")) {
	                        birth2[1] = birth2[1].substring(1);
	                     }
	                     if (birth[2].substring(0, 1).equals("0")) {
	                        birth2[2] = birth2[2].substring(1);
	                     }
	                     cdto.setBirth(birth2[0] + "년 " + birth2[1] + "월 " + birth2[2] + "일");
	                     cdto.setLikeCount(rs2.getString("likeCount"));
	                     cdto.setId(rs2.getString("id"));
	                     cdto.setCid(rs2.getString("cid"));
	                     cdto.setCommentId(rs2.getString("commentid"));
	                     cdto.setPfp(rs2.getString(6));
	                     listComment.add(cdto);
	                  }
	               }
	            }
	         }

	         // commenttbl에 댓글이 없을때
	         else {
	            try {
	               query = "SELECT A.bid, A.content, A.likecount, A.birth, A.id, A.photo, B.pfp, A.likeWho\r\n"
	                     + "FROM boardtbl A LEFT OUTER JOIN membertbl B \r\n"
	                     + "ON A.id = B.mid ORDER BY A.birth DESC";
	               //                 + "ON A.id = B.mid WHERE NOT A.id IN (?) ORDER BY A.birth DESC";
	               psmt = con.prepareStatement(query);
	               rs = psmt.executeQuery();

	               while (rs.next()) {
	                  boardDTO bdto = new boardDTO();
	                  bdto.setBid(rs.getString("bid"));
	                  bdto.setContent(rs.getString("content"));     
	                  bdto.setLikeCount(rs.getString("likeCount"));
	                  String[] birth = rs.getString("birth").substring(0, 10).split("-");
	                  if (birth[1].substring(0, 1).equals("0")) {
	                     birth[1] = birth[1].substring(1);
	                  }
	                  if (birth[2].substring(0, 1).equals("0")) {
	                     birth[2] = birth[2].substring(1);
	                  }
	                  bdto.setBirth(birth[0] + "년 " + birth[1] + "월 " + birth[2] + "일");
	                  bdto.setPfp(rs.getString("pfp"));
	                  bdto.setId(rs.getString("id"));
	                  bdto.setPhoto(rs.getString("photo"));
	                  bdto.setCommentCount("0");
	                  listBoard.add(bdto);
	               }
	            } catch (Exception e) {
	               e.printStackTrace();
	            }
	         }

	         // board
	         request.setAttribute("listBoard", listBoard);
	         Collections.reverse(listComment);
	         request.setAttribute("listComment", listComment);
	         request.setAttribute("boardCount", session.getAttribute("boardCount"));
	         request.setAttribute("len", listBoard.size());
	         session.removeAttribute("boardCount");

	         // 좋아요
	         Collections.reverse(likeWhoId);
	         request.setAttribute("likeWhoId", likeWhoId);

	         // 댓글
	         request.setAttribute("bid", bid);
	         request.setAttribute("comment", comment);
	         request.setAttribute("commentDetail", commentDetail);
	         request.setAttribute("pageRoute", pageRoute);

	         // Photo
	         request.setAttribute("photo", photo);

	         //index
	         request.setAttribute("indes", index);

	         if(m2id !=null) {
	            request.setAttribute("m2id", m2id);
	         }

	         System.out.println("게시물 조회 성공");
	      }
	      catch (Exception e) {
	         System.out.println("게시물 조회 실패");
	         e.printStackTrace();
	      }
	      return pageMove;
	   }
			
		

		// Home/Home.jsp - 게시물 좋아요 누가누가 조회
	// Home/Home.jsp - 게시물 좋아요 누가누가 조회
    public String likeWho(HttpServletRequest request, HttpServletResponse response, String bid, String boardCount,String index, String m2id) {
       
         String pageMove = "/Home/Home.jsp";
         if(m2id!=null) {
        	pageMove = "/board/AcContent.jsp?index="+index+"&m2id="+m2id;
    	 }//현준추가         
         HttpSession session = request.getSession();
         String memberId = (String)session.getAttribute("memberId");
         
         String getId=""; //종욱추가
         
         try {
            String query = "SELECT likeWho,id FROM boardtbl WHERE bid=?";
            
            psmt = con.prepareStatement(query);
            psmt.setString(1, bid);
            rs = psmt.executeQuery();
          
            // null만 아니면 if 들어감(사실상 무조건 들어감. 왜 이렇게 해놨지?)
            if (rs.next()) {
             String db = rs.getString(1);
             getId = rs.getString("id"); // 종욱추가
             // 좋아요 아무도 안눌렀으면 첫 좋아요
             if (db.equals("")) {
                try {
                   query = "UPDATE boardtbl SET likeWho = ? WHERE bid = ?";
                   psmt.close();
                   rs.close();
                     psmt = con.prepareStatement(query);
                     psmt.setString(1, memberId);
                     psmt.setString(2, bid);
                     psmt.executeUpdate();
                     
                     query = "UPDATE boardtbl SET likecount = likecount + 1 WHERE bid = ?";
                     psmt.close();
                   rs.close();
                     psmt = con.prepareStatement(query);
                     psmt.setString(1, bid);
                     psmt.executeUpdate();
                     
                     // 종욱 알림 추가
                     psmt.close();
                   rs.close();
                   String notice = String.format("%s님이 %s게시글에 좋아요를 눌렀습니다",memberId,bid);
                     query = "insert into noti(getid,putid,notice,created_at) values(?,?,?,now())";   
                     psmt = con.prepareStatement(query);
                   psmt.setString(1, getId);
                   psmt.setString(2, memberId);
                   psmt.setString(3, notice);
                   psmt.executeUpdate();
                   // 종욱 추가 끝
                     
                   System.out.println(memberId + "가 " + bid + "번 게시글 첫 좋아요 성공");
                } 
                catch (Exception e) {
                   System.out.println(memberId + "가 " + bid + "번 게시글 첫 좋아요 실패");
                   e.printStackTrace();
                }
             }
             
             // 좋아요 1 이상일때
             else {

                String[] db2 = db.split(", ");
                   ArrayList<boardDTO> likeWho = new ArrayList<boardDTO>();
                   
                   // 변수 db에 담긴 문자열들(아이디들)을 ,와 공백을 제거하여(숫자만 골라내기위해서) ArrayList에 담는다
                   for (int i = 0; i < db2.length; i++) {
                      boardDTO bdto = new boardDTO();
                      bdto.setId(db2[i]);
                      likeWho.add(bdto);
                  }
                   
                   // 현재 로그인한 아이디가 ArrayList에 있는지 검색
                   for (int i = 0; i < likeWho.size(); i++) {
                      
                      // 현재 로그인한 아이디가 ArrayList에 있으면(이미 좋아요를 눌렀으면) likeWho 배열에서 아이디 삭제
                   if (likeWho.get(i).getId().equals(memberId)) {
                      likeWho.remove(i);
                      db = "";
                   }
                   }
                   
                   // 현재 로그인한 아이디가 ArrayList에 있으면 좋아요 취소                  
                   if (db.equals("")) {
                   
                      // 현재 로그인한 아이디가 삭제된 ArrayList에 있는 값들을 다시 Database에 넣기위해 변수 db에 담는다
                      for (int k = 0; k < likeWho.size(); k++) {
                        if (k == likeWho.size() - 1) {
                           db += likeWho.get(k).getId();
                           break;
                        }
                        db += likeWho.get(k).getId() + ", ";
                     }
                      
                      try {
                         query = "UPDATE boardtbl SET likeWho = ? WHERE bid = ?";
                      psmt.close();
                      rs.close();
                        psmt = con.prepareStatement(query);
                        psmt.setString(1, db);
                        psmt.setString(2, bid);
                        psmt.executeUpdate();
                        
                        query = "UPDATE boardtbl SET likecount = likecount - 1 WHERE bid = ?";
                        psmt.close();
                      rs.close();
                        psmt = con.prepareStatement(query);
                        psmt.setString(1, bid);
                        psmt.executeUpdate();
                        
                        // 종욱 알림 추가
                        psmt.close();
                      rs.close();
                      String notice = String.format("%s님이 %s게시글에 좋아요를 눌렀습니다",memberId,bid);
                        query = "delete from noti where notice=?";
                        psmt = con.prepareStatement(query);
                      psmt.setString(1, notice);
                      psmt.executeUpdate();
                      // 종욱 추가 끝
                        
                        System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 취소 성공");
                   } catch (Exception e) {
                      e.printStackTrace();
                      System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 취소 실패");
                   }
                }
                      
                // 현재 로그인한 아이디가 ArrayList에 없으면 좋아요
                else {
                   try {
                      query = "UPDATE boardtbl SET likeWho = CONCAT(likeWho, ?) WHERE bid = ?";
                      psmt.close();
                      rs.close();
                        psmt = con.prepareStatement(query);
                        psmt.setString(1, ", " + memberId);
                        psmt.setString(2, bid);
                        psmt.executeUpdate();

                        query = "UPDATE boardtbl SET likecount = likecount + 1 WHERE bid = ?";
                        psmt.close();
                      rs.close();
                        psmt = con.prepareStatement(query);
                        psmt.setString(1, bid);
                        psmt.executeUpdate();
                        
                        // 종욱 알림 추가
                        psmt.close();
                      rs.close();
                      String notice = String.format("%s님이 %s게시글에 좋아요를 눌렀습니다",memberId,bid);
                        query = "insert into noti(getid,putid,notice,created_at) values(?,?,?,now())";   
                        psmt = con.prepareStatement(query);
                      psmt.setString(1, getId);
                      psmt.setString(2, memberId);
                      psmt.setString(3, notice);
                      psmt.executeUpdate();
                      // 종욱 추가 끝
                      
                        System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 성공");
                   } catch (Exception e) {
                      e.printStackTrace();
                      System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 실패");
                      
                   }
                }
                request.setAttribute("likeWho", likeWho);
             }
          }
            session.setAttribute("boardCount", boardCount);
             System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 조회 성공");
         }
         
         
         catch (Exception e) {
            System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 조회 실패");
             e.printStackTrace();
         }
         return pageMove;
     }
		
	
		
	
	//=======================add from saemin END=======================//
		
	//=======================add from hyunjun START=======================//
    public String selectAc(HttpServletRequest req, HttpServletResponse res, String m2id, String index, String memberId){      
        String pageMove = "/Home/AcHome.jsp";
        
        if(memberId!=null) {
           pageMove="/Home/SelfHome.jsp";
        }      
        if(index!=null) {
           pageMove="/board/AcContent.jsp";
        }
        
        String sql = "select * from boardtbl where id=?";
          String sql2 = "select * from membertbl where mid=?";
          
          List<boardDTO> boardlist=new ArrayList<boardDTO>();
          
          ArrayList<boardDTO> photo = new ArrayList<boardDTO>();
          ArrayList<boardDTO> firstphoto = new ArrayList<boardDTO>();
          
          memberDTO memberlist=new memberDTO();
          
          int follower = 0;
          
          ResultSet rs2 = null; 
          
         PreparedStatement pstmt=null;
         PreparedStatement pstmt2=null;
         
          try {
             pstmt= con.prepareStatement(sql);
           if(memberId!=null) {
              pstmt.setString(1,memberId);
           } else {pstmt.setString(1,m2id);}
             rs = pstmt.executeQuery();
             
             pstmt2= con.prepareStatement(sql2);    
             if(memberId!=null) {
              pstmt2.setString(1,memberId);
           } else {pstmt2.setString(1,m2id);}              
             rs2 = pstmt2.executeQuery();
             
             while(rs.next()) {
                boardDTO bdto=new boardDTO();
                bdto.setBid(rs.getString(1));                 
                bdto.setContent(rs.getString(2));
                bdto.setBirth(rs.getString(3));
                bdto.setLikeCount(rs.getString(4));
                bdto.setPhoto(rs.getString(5));
                bdto.setId(rs.getString(6));   
                bdto.setLikeWho(rs.getString(7));
                boardlist.add(bdto);
                
                
                //photo list 생성
                   String[] db4 =  rs.getString("photo").split(","); 
              for (int i = 0; i < db4.length; i++) {
                 boardDTO bdtoPhoto = new boardDTO();
                 bdtoPhoto.setBid(rs.getString("bid"));
                 bdtoPhoto.setPhoto(db4[i]);
                  
                  ///////////////
                 bdtoPhoto.setPhoto2(db4[i].replace("\\", "\\\\"));
                  ///////////////
                 photo.add(bdtoPhoto);
              }
              boardDTO bdtoPhotos = new boardDTO();
              bdtoPhotos.setBid(rs.getString("bid"));
              bdtoPhotos.setPhoto(db4[0]);
              firstphoto.add(bdtoPhotos);                 
                
             }
             while(rs2.next()) {                 
                memberlist.setMid(rs2.getString(1));
                memberlist.setPw(rs2.getString(2));
                memberlist.setEmail(rs2.getString(3));
                memberlist.setPfp(rs2.getString(4));
                memberlist.setPhone(rs2.getString(5));
                memberlist.setName(rs2.getString(6));
                memberlist.setBirth(rs2.getString(7));
                memberlist.setIntro(rs2.getString(8));
                memberlist.setFollower(rs2.getString(9));
                memberlist.setIsprivate(rs2.getString(10));
                
                String Followers=rs2.getString(9);
                String[] Follower = Followers.split(",");
                follower = Follower.length;
             }
             System.out.println("보드,멤버 리스트 생성");
         }
          catch (Exception e) {
              System.out.println("보드,멤버 리스트 구하는 중 예외 발생");
              e.printStackTrace();
          }   
          req.setAttribute("firstphoto", firstphoto);
          req.setAttribute("photo", photo);
          req.setAttribute("len", boardlist.size());
          req.setAttribute("boardlist", boardlist);           
          req.setAttribute("memberlist", memberlist); 
          req.setAttribute("follower", follower); 
          System.out.println("보드,멤버 리스트 생성");
          
          return pageMove;
      }
		
		public String delete(HttpServletRequest request, HttpServletResponse response, String bid, String boardCount,String index, String m2id) {
			
	        String pageMove = "/board/AcContent.jsp?index="+index;
	        HttpSession session = request.getSession();
	        String memberId = (String)session.getAttribute("memberId");
	        
	        try {
	        	String query = "delete from boardtbl where bid=?;";
	        	
	            psmt = con.prepareStatement(query);
	        	psmt.setString(1, bid);
	        	psmt.executeUpdate();
				
	        	request.setAttribute("m2id", m2id);
	        	request.setAttribute("index", index);	
	        	System.out.println(m2id + "가 " + bid + "번 게시글 삭제 성공");
	        }	        
	        catch (Exception e) {
	        	System.out.println(m2id + "가 " + bid + "번 게시글 삭제 실패");
	            e.printStackTrace();
	        }
	        return pageMove;
	    }	
		
		
		
	
		
	//=======================add from hyunjun END=======================//
	//기랑추가
		public void postList(HttpServletRequest request, HttpServletResponse response, String id){
			HttpSession session = request.getSession();
			ArrayList<boardDTO> list2 = new ArrayList<boardDTO>();
			
			try{ 		
				String sql= "select * from boardtbl where id=?";
			

				psmt = con.prepareStatement(sql); // sql문을 일단 올려둠
				psmt.setString(1,id); // (?자리,?에넣을값)  // 올려둔 것을 셋팅
				rs = psmt.executeQuery();  // 올려둔 값을 실행하고 결과를 rs에 저장
				
				while(rs.next()){ // 다음 값이 있을동안 계속 돈다 
					boardDTO dto = new boardDTO(); 
					String id2 = rs.getString("id");
					String bid = rs.getString("bid");
					String content = rs.getString("content");
					String birth = rs.getString("birth");
					String photo = rs.getString("photo");
					
					dto.setId(id2);
					dto.setBid(bid);
					dto.setContent(content);
					dto.setBirth(birth);
					dto.setPhoto(photo);
					list2.add(dto);
				}
				request.setAttribute("list2", list2);
				System.out.println("board 불러오기 성공");
			}catch(SQLException ex){
				System.out.println("board 불러오기 실패");
				System.out.println("SQLException : " + ex.getMessage());
			}finally{ //not null이라면( 잘만들어젔다면)
				close();
			}
		
		}
		
		
		public void postDel(HttpServletRequest request, HttpServletResponse response){
			ArrayList<boardDTO> list2 = new ArrayList<boardDTO>();
			String bid = request.getParameter("bid");
			
			System.out.println(request.getParameter("bid"));
			
			try {
				String sql = "delete from boardtbl where bid=?";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, bid);
				psmt.executeUpdate();
				System.out.println(bid + " 삭제 성공");
			}catch(Exception ex){
				ex.printStackTrace();
				System.out.println(bid + " 삭제 실패");
			}finally{
				close();
			}
		}
	//기랑끝
	
	
}