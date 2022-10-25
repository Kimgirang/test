package member;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.boardDTO;
import db.JDBConnect;

public class memberDAO extends JDBConnect {
	
	
	
	
	//검색한 문자가 포함된 아이디를 리스트 리턴
	public ArrayList<memberDTO> getSearch(String searchText){
		ArrayList<memberDTO> searched = new ArrayList<memberDTO>();
		try {
			String sql = "select * from membertbl where mid like ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1,"%"+searchText+"%");
			rs = psmt.executeQuery();
			while(rs.next()) {
				memberDTO dto = new memberDTO();
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
				dto.setBirth(sd.format(rs.getDate("birth")));
				dto.setPw(rs.getString("pw"));
				dto.setFollower(rs.getString("follower"));
				dto.setPfp(rs.getString("pfp"));
				dto.setMid(rs.getString("mid"));
				dto.setIntro(rs.getString("intro"));
				if(rs.getString("isprivate").equals("yes")) {
					dto.setIsprivate("비공개");
				}else if(rs.getString("isprivate").equals("no")) {
					dto.setIsprivate("공개");
				}else {
					dto.setIsprivate("공개");
				}
				searched.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return searched;
	}
	
	
	// mid를 매개변수로 받아서 db에 조회한 다음 일치하는 아이디가 있다면 dto에 셋팅하고 dto리턴
	public memberDTO getMemberInfo(HttpServletRequest request,HttpServletResponse response, String mid) {
		memberDTO memberInfo = new memberDTO();
		
		
		System.out.println(mid);
		try {
			String sql = "select * from membertbl where mid=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, mid);
			rs = psmt.executeQuery();
			while(rs.next()) {
				memberInfo.setName(rs.getString("name"));
				memberInfo.setEmail(rs.getString("email"));
				memberInfo.setPhone(rs.getString("phone"));
				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
				memberInfo.setBirth(sd.format(rs.getDate("birth")));
				memberInfo.setPw(rs.getString("pw"));
				memberInfo.setFollower(rs.getString("follower"));
				memberInfo.setPfp(rs.getString("pfp"));
				memberInfo.setMid(mid);
				memberInfo.setIntro(rs.getString("intro"));
				if(rs.getString("isprivate").equals("yes")) {
					memberInfo.setIsprivate("비공개");
				}else if(rs.getString("isprivate").equals("no")) {
					memberInfo.setIsprivate("공개");
				}else {
					memberInfo.setIsprivate("공개");
				}
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return memberInfo;
	}
	
	
	// 데이터베이스에서 멤버 찾아서 삭제
	public String deleteAccount(HttpServletRequest request,HttpServletResponse response, String mid, String password,HttpSession session) {
		memberDTO dto = getMemberInfo(request,response,mid);
		//JDBC 에 reConnect 만듦
		reConnect();
		String delStatus = "";
		String sql = "delete from membertbl where mid=? and pw=?";
		if(dto.getPw().equals(password)) {
			try {
				psmt = con.prepareStatement(sql);
				psmt.setString(1, mid);
				psmt.setString(2, password);
				
				if(psmt.executeUpdate()>0) {
					session.removeAttribute("memberId");
					delStatus="<script> alert('탈퇴 되었습니다.');location.href='/sns/Login/LoginPage'; </script>;";
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				close();
			}
		}else {
			delStatus="<script> alert('비밀번호가 일치하지 않습니다.');location.href='/sns/controller/SettingPage'; </script>;";
		}
		return delStatus;
	}
	
	
	//공개범위 변경 공개 비공개
	public String changePrivateState(HttpServletRequest request,HttpServletResponse response,memberDTO dto) {
		String changeStatus="";
		String isPrivate = dto.getIsprivate();

		String sql = "update membertbl set isprivate=? where mid= ? ";
		
		if(isPrivate.equals("공개")) {
			try {
				reConnect();
				psmt = con.prepareStatement(sql);
				psmt.setString(1, "yes");
				psmt.setString(2, dto.getMid());
				
				if(psmt.executeUpdate()>0) {
					changeStatus="<script> alert('비공개로 전환 되었습니다.');location.href='/sns/controller/SettingPage'; </script>;";
				}else {
					changeStatus="<script> alert('설정이 실패했습니다.');location.href='/sns/controller/SettingPage'; </script>;";
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				close();
			}
		}else if(isPrivate.equals("비공개")) {
			try {
				reConnect();
				psmt = con.prepareStatement(sql);
				psmt.setString(1, "no");
				psmt.setString(2, dto.getMid());
				
				if(psmt.executeUpdate()>0) {
					changeStatus="<script> alert('공개로 전환 되었습니다.');location.href='/sns/controller/SettingPage'; </script>;";
				}else {
					changeStatus="<script> alert('설정이 실패했습니다.');location.href='/sns/controller/SettingPage'; </script>;";
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				close();
			}
		}else {
			changeStatus="<script> alert('설정이 실패했습니다.');location.href='/sns/controller/SettingPage'; </script>;";
		}
		return changeStatus;
	}

	

	//계정정보 수정
		public void Aedit(HttpServletRequest request, HttpServletResponse response, String mid){            
			String sql = "update membertbl set pw=?,email=?,phone=?,name=?,birth=? where mid=?";
	        
	        ResultSet rs = null;    	  
		    PreparedStatement pstmt=null;
	        try {
				pstmt= con.prepareStatement(sql);  				
				pstmt.setString(1,request.getParameter("pw"));
				pstmt.setString(2,request.getParameter("email"));
				pstmt.setString(3,request.getParameter("phone"));
				pstmt.setString(4,request.getParameter("name"));
				pstmt.setString(5,request.getParameter("birth"));
				pstmt.setString(6,mid);
				pstmt.executeUpdate();
				System.out.println("계정정보 수정");
	        }
	        catch (Exception e) {
	            System.out.println("계정정보 수정하는 중 예외 발생");
	            e.printStackTrace();
	        }      	        
			
	    }
		
	//프로필 수정(소개, 사진)
	    public void Pedit(HttpServletRequest request, HttpServletResponse response, String mid,String intro,String savedName) throws IOException {	    
	    	
	    	try{
	        	
	        	 
	        	String sql=null;
	        	
	    		if(intro!=null){
		    		sql = "update membertbl set pfp=?,intro=? where mid=?";	  
		    		psmt= con.prepareStatement(sql);	
		    		psmt.setString(1,savedName); 
		    		psmt.setString(2,intro);
		    		psmt.setString(3,mid);
		    		psmt.executeUpdate();
	    		}
	    		System.out.println(savedName);
	    		System.out.println("프로필 수정");

	    	} catch(SQLException ex){
	    		System.out.println("프로필 수정 실패<br>");
	    		System.out.println("SQLException : " + ex.getMessage());
	    	}     	
	    		
	    }
	   
	// Home/AcHome.jsp - 팔로우
	public String follow(HttpServletRequest request, HttpServletResponse response, String mid) {
		
		String pageMove = "/controller/selectAc?pageRoute=selectAc&m2id=" + mid;
        HttpSession session = request.getSession();
        String memberId = (String)session.getAttribute("memberId");
        
        
        try {
        	String query = "SELECT follower FROM membertbl WHERE mid = ?";
        	
            psmt = con.prepareStatement(query);
        	psmt.setString(1, mid);
        	rs = psmt.executeQuery();
			
        	// null만 아니면 if 들어감(사실상 무조건 들어감. 왜 이렇게 해놨지?)
        	if (rs.next()) {
				String db = rs.getString(1);
				
				// 팔로우 아무도 안했으면 첫 팔로우
				if (db.equals("")) {
					try {
						query = "UPDATE membertbl SET follower = ? WHERE mid = ?";
						psmt.close();
						rs.close();
			        	psmt = con.prepareStatement(query);
			        	psmt.setString(1, memberId);
			        	psmt.setString(2, mid);
			        	psmt.executeUpdate();
			        	
			        	query = "UPDATE membertbl SET followerCount = followerCount + 1 WHERE mid = ?";
			        	psmt.close();
						rs.close();
			        	psmt = con.prepareStatement(query);
			        	psmt.setString(1, mid);
			        	psmt.executeUpdate();
			        	
			        	//종욱 알림 추가
			        	psmt.close();
			        	rs.close();
			        	String notice = String.format("%s님이 나를 팔로우하기 시작했습니다",memberId);
			        	query = "insert into noti(getid,putid,notice,created_at) values(?,?,?,now())";	
			        	psmt = con.prepareStatement(query);
			        	psmt.setString(1, mid);
			        	psmt.setString(2, memberId);
			        	psmt.setString(3, notice);
			        	psmt.executeUpdate();
			        	//
			        	
						System.out.println(memberId + "가 " + mid + "님 첫 팔로우 성공");
					} 
					catch (Exception e) {
						System.out.println(memberId + "가 " + mid + "님 첫 팔로우 실패");
						e.printStackTrace();
					}
				}
				
				// 팔로우 1 이상일때
				else {

					String[] db2 = db.split(", ");
	            	ArrayList<memberDTO> follow = new ArrayList<memberDTO>();
	            	
	            	// 변수 db에 담긴 문자열들(아이디들)을 ,와 공백을 제거하여(숫자만 골라내기위해서) ArrayList에 담는다
	            	for (int i = 0; i < db2.length; i++) {
	            		memberDTO mdto = new memberDTO();
	            		mdto.setMid(db2[i]);
	            		follow.add(mdto);
	        		}
	            	
	            	// 현재 로그인한 아이디가 ArrayList에 있는지 검색
	            	for (int i = 0; i < follow.size(); i++) {
	            		
	            		// 현재 로그인한 아이디가 ArrayList에 있으면(이미 좋아요를 눌렀으면) likeWho 배열에서 아이디 삭제
						if (follow.get(i).getMid().equals(memberId)) {
							follow.remove(i);
							db = "";
						}
	            	}
	            	
	            	// 현재 로그인한 아이디가 ArrayList에 있으면 팔로우 취소	            	
	            	if (db.equals("")) {
						
	            		// 현재 로그인한 아이디가 삭제된 ArrayList에 있는 값들을 다시 Database에 넣기위해 변수 db에 담는다
		            	for (int k = 0; k < follow.size(); k++) {
		        			if (k == follow.size() - 1) {
		        				db += follow.get(k).getMid();
		        				break;
		        			}
		        			db += follow.get(k).getMid() + ", ";
		        		}
		            	
		            	try {
		            		query = "UPDATE membertbl SET follower = ? WHERE mid = ?";
							psmt.close();
							rs.close();
				        	psmt = con.prepareStatement(query);
				        	psmt.setString(1, db);
				        	psmt.setString(2, mid);
				        	psmt.executeUpdate();
				        	
				        	query = "UPDATE membertbl SET followerCount = followerCount - 1 WHERE mid = ?";
				        	psmt.close();
							rs.close();
				        	psmt = con.prepareStatement(query);
				        	psmt.setString(1, mid);
				        	psmt.executeUpdate();
				        	
				        	//종욱 알림 추가
				        	psmt.close();
				        	rs.close();
				        	String notice = String.format("%s님이 나를 팔로우하기 시작했습니다",memberId);
				        	query = "delete from noti where notice=?";
				        	psmt = con.prepareStatement(query);
				        	psmt.setString(1, notice);
				        	psmt.executeUpdate();
				        	//
				        	
				        	System.out.println(memberId + "가 " + mid + "님 팔로우 취소 성공");
						} catch (Exception e) {
							e.printStackTrace();
							System.out.println(memberId + "가 " + mid + "님 팔로우 취소 실패");
						}
					}
							
					// 현재 로그인한 아이디가 ArrayList에 없으면 팔로우
					else {
						try {
							query = "UPDATE membertbl SET follower = CONCAT(follower, ?) WHERE mid = ?";
							psmt.close();
							rs.close();
				        	psmt = con.prepareStatement(query);
				        	psmt.setString(1, ", " + memberId);
				        	psmt.setString(2, mid);
				        	psmt.executeUpdate();

				        	query = "UPDATE membertbl SET followerCount = followerCount + 1 WHERE mid = ?";
				        	psmt.close();
							rs.close();
				        	psmt = con.prepareStatement(query);
				        	psmt.setString(1, mid);
				        	psmt.executeUpdate();
				        	
				        	//종욱 알림 추가
				        	psmt.close();
				        	rs.close();
				        	String notice = String.format("%s님이 나를 팔로우하기 시작했습니다",memberId);
				        	query = "insert into noti(getid,putid,notice,created_at) values(?,?,?,now())";	
				        	psmt = con.prepareStatement(query);
				        	psmt.setString(1, mid);
				        	psmt.setString(2, memberId);
				        	psmt.setString(3, notice);
				        	psmt.executeUpdate();
				        	//
				        	
				        	System.out.println(memberId + "가 " + mid + "님 팔로우 성공");
						} catch (Exception e) {
							e.printStackTrace();
							System.out.println(memberId + "가 " + mid + "님 팔로우 실패");
							
						}
					}
					request.setAttribute("follow", follow);
				}
			}
//	 	        	session.setAttribute("boardCount", boardCount);
            System.out.println(memberId + "가 " + mid + "님 팔로우 조회 성공");
        }
        
        
        catch (Exception e) {
        	System.out.println(memberId + "가 " + mid + "님 팔로우 조회 실패");
            e.printStackTrace();
        }
        return pageMove;
    }
	
	//간략한 계정정보 불러오기
	public String ae(HttpServletRequest req, HttpServletResponse res){      
		String pageMove = "/Setting/AcEdit.jsp";
		String memberId = (String)req.getSession().getAttribute("memberId");
		memberDTO memberlist=new memberDTO();		
        String sql = "select * from membertbl where mid=?";
        PreparedStatement pstmt=null;
        try {
    	    pstmt= con.prepareStatement(sql);  
    	    pstmt.setString(1,memberId);	    
    	    rs = pstmt.executeQuery();

    	    while(rs.next()) {	    	    	
    	    	memberlist.setMid(rs.getString(1));
    	    	memberlist.setEmail(rs.getString(3));
    	    	memberlist.setPfp(rs.getString(4));
    	    	memberlist.setPhone(rs.getString(5));
    	    	memberlist.setName(rs.getString(6));
    	    	memberlist.setBirth(rs.getString(7));
    	    	memberlist.setIntro(rs.getString(8));
    	    }
    	    System.out.println("간략한 로그인 정보 불러옴");
    	}
        catch (Exception e) {
            System.out.println("간략한 로그인 정보 불러오는 중 예외 발생");
            e.printStackTrace();
        }   	        
        req.setAttribute("memberlist", memberlist);  
        System.out.println("간략한 로그인 정보 불러옴");
        
        return pageMove;
    }

	//기랑추가

	//관리자 : 회원정보조회	
	public void manager(HttpServletRequest request, HttpServletResponse response) {
		
		
		String sql = "select * from membertbl;";  // member테이블에 있는 mid,pw,phone을 가져옴
		ArrayList<memberDTO> list = new ArrayList<memberDTO>(); //memberDTO의 변수들을 끌어올려고 타입으로 씀
		
		try {  
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);	
			
			while(rs.next()) { // while을 넣으면 한줄끝나고 다음줄 그다음줄..)
				memberDTO dto = new memberDTO(); 
				String mid = rs.getString("mid");
				String pw = rs.getString("pw");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String name = rs.getString("name");
				String birth = rs.getString("birth");
				String isprivate = rs.getString("isprivate");
				
				dto.setMid(mid); //객체에 mid 담김
				dto.setPw(pw); 
				dto.setPhone(phone);
				dto.setEmail(email); 
				dto.setName(name);
				dto.setBirth(birth); 
				dto.setIsprivate(isprivate);
				list.add(dto); //리스트에(객체에 mid 담김)담김
			}
			request.setAttribute("list", list); //list로 부름, list를 부르면
			System.out.println("select 성공"); //이름 다르게 저장할것(경로어디가틀렸는지)
		}
		catch(Exception e) {
			e.printStackTrace();
			System.out.println("select 실패");
		}
    }
	
	//관리자 : 회원정보수정
	public void update(HttpServletRequest request, HttpServletResponse response)  {

		ArrayList<memberDTO> list = new ArrayList<memberDTO>(); //memberDTO의 변수들을 끌어올려고 타입으로 씀
		memberDTO dto = new memberDTO();
		
		String mid = request.getParameter("mid");  
	 	String pw = request.getParameter("pw");
	 	String email = request.getParameter("email");  
	 	String phone = request.getParameter("phone");
	 	String name = request.getParameter("name");  
	 	String birth = request.getParameter("birth");
	 	
		try{
			String sql = "update membertbl set pw=?, name=?, email=?, phone=?, birth=? where mid=?";  // sns에서 mid인 pw,phone, 
			psmt = con.prepareStatement(sql);

			psmt.setString(1,pw);
			psmt.setString(2,name);
			psmt.setString(3,email);
			psmt.setString(4,phone);
			psmt.setString(5,birth);
			psmt.setString(6,mid);
			
			psmt.executeUpdate(); 
			System.out.println(mid + " 회원 정보 수정 성공");
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println(mid + " 회원 정보 수정 실패");
		}finally{
			close();
		}	
	}
	

	//관리자 : 회원삭제 
	public void delete(HttpServletRequest request, HttpServletResponse response) {
		

		ArrayList<memberDTO> list = new ArrayList<memberDTO>(); //memberDTO의 변수들을 끌어올려고 타입으로 씀
		String id = request.getParameter("manageID");  
		
		try {
			String sql = "delete from membertbl where mid=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.executeUpdate();
			System.out.println(id + " 삭제 성공");
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println(id + " 삭제 실패");
		}finally{
			close();
		}
	}
	
	//관리자 : 공개 / 비공개
	public void isprivateChange(HttpServletRequest request, HttpServletResponse response) {		

		memberDTO dto = new memberDTO();

		String mid = request.getParameter("mid");
		String isprivate = request.getParameter("isprivate");

		//버튼을 누르면 전달받은 isprivate이 no이면 yes로 변경되게  
			if(isprivate.equals("no")) {
				isprivate ="yes";
			}else {
				isprivate ="no"; 
			}

		//System.out.println(request.getParameter("mid"));
		
		try{
			String sql = "update membertbl set isprivate=? where mid=?"; 
			psmt = con.prepareStatement(sql);

			psmt.setString(1,isprivate);
			psmt.setString(2,mid);
			
			psmt.executeUpdate(); 
			System.out.println(mid + "계정활성화성공");
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println(mid + " 회원 정보 수정 실패");
		}finally{
			close();
		}	
	}
		
		
	


	public memberDTO login(String uid,String upass) {
		
		memberDTO dto = new memberDTO(); 
		String query = "SELECT * FROM membertbl WHERE mid=? and pw=?";  // member테이블에 id passwd 있는지 확인
		
		try {  
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();
			
			if(rs.next()) { // 있으면 
				dto.setMid(rs.getString("mid"));
				dto.setPw(rs.getString("pw"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return dto; 
    }
	
	public void signup(HttpServletRequest request, HttpServletResponse response){
		String mid = request.getParameter("mid");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String birth = request.getParameter("birth");
		
		try{
			String sql = "insert into membertbl(mid,pw,name,email,phone,birth) values(?,?,?,?,?,?)"; 
			psmt = con.prepareStatement(sql);

			psmt.setString(1,mid);
			psmt.setString(2,pw);
			psmt.setString(3,name);
			psmt.setString(4,email);
			psmt.setString(5,phone);
			psmt.setString(6,birth);
				

			psmt.executeUpdate();  // 매개변수없음 ..setstring으로 이미 담은 상태라서d

		}catch(Exception ex){
			System.out.println("삽입실패");
			System.out.println("SQLException : " + ex.getMessage());
		}finally{
			close();
		}
	}
	//기랑끝

}