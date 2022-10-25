package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.mysql.cj.Session;
import com.oreilly.servlet.MultipartRequest;

import board.boardDAO;
import board.boardDTO;
import message.messageDAO;
import message.messageDTO;

import comment.commentDAO;
import notice.NotiDAO;

import java.util.ArrayList;
import java.util.List;

import member.memberDAO;
import member.memberDTO;



@WebServlet("/controller/*")
@MultipartConfig(
	    fileSizeThreshold = 1024*1024,
	    maxFileSize = 1024*1024*50, //50메가
	    maxRequestSize = 1024*1024*50*5 // 50메가 5개까지
	)
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("==========service srt==========");
		
		
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		String LoginedID = (String)session.getAttribute("memberId");
		
		//=========================추가 시작
		// 기능
		String pageRoute = request.getParameter("pageRoute") == null ? null : request.getParameter("pageRoute");
		// 보드아이디
		String bid = request.getParameter("bid") == null ? null : request.getParameter("bid");
		// 댓글관련 변수
		String comment = request.getParameter("comment") == null ? null : request.getParameter("comment");
		// 댓글관련 변수
		String commentDetail = request.getParameter("commentDetail") == null ? null : request.getParameter("commentDetail");
		//acHome 관련 변수
		String m2id=request.getParameter("m2id")==null? null : request.getParameter("m2id");
		//acContent 관련 변수
		String index=request.getParameter("index")==null? null : request.getParameter("index");
		// 버튼 눌렀을때 몇번째 게시물인지
		String boardCount = request.getParameter("boardCount") == null ? null : request.getParameter("boardCount");
		//팔로우 
		String mid=request.getParameter("mid")==null? null : request.getParameter("mid");
		
		String cid = request.getParameter("cid") == null ? null : request.getParameter("cid");
		
		String room = request.getParameter("room") == null ? null : request.getParameter("room");
		
		String pageMove = null;
		
		String manageID = request.getParameter("manageID") == null ? null : request.getParameter("manageID");
		//=========================추가 끝
		
		
		
		
		
		
		
		String requestURI = request.getRequestURI();
		int lastSlash = requestURI.lastIndexOf("/");
		requestURI = requestURI.substring(lastSlash);
		System.out.println(requestURI);
		
		switch(requestURI) {
		// ===========================페이지로 보내는 컨트롤러===========================
		case "/HomePage":
			session.removeAttribute("scroll");
			request.getRequestDispatcher("/Home/Home.jsp").forward(request, response);
			break;
		case "/LoginPage":
			request.getRequestDispatcher("/Login/Login.jsp").forward(request, response);
			break;
		case "/SignUpPage":
			request.getRequestDispatcher("/Login/SignUp.jsp").forward(request, response);
			break;
		case "/SettingPage":
			showMemberInfo(request,response,session);
			break;
		case "/WritePage":
			request.getRequestDispatcher("/Home/Write.jsp").forward(request, response);
			break;
		case "/MyPage":
			request.getRequestDispatcher("/Home/SelfHome.jsp").forward(request, response);
			break;
		case "/DmPage":
			System.out.println("dmpage 까진 옴");
			request.getRequestDispatcher("/Dm/lobby.jsp").forward(request, response);
			break;			
		case "/ProfileEditPage":
			request.getRequestDispatcher("/Setting/ProfileEdit.jsp").forward(request, response);
			break;	
		case "/AcEditPage":
			request.getRequestDispatcher("/Setting/AcEdit.jsp").forward(request, response);
			break;	
		case "/AcHomePage":
			if(LoginedID.equals(m2id)) {
				request.getRequestDispatcher("/Home/SelfHome.jsp").forward(request, response);
			} else {request.getRequestDispatcher("/Home/AcHome.jsp").forward(request, response);}
			break;		
		case "/AcContentPage":
			request.getRequestDispatcher("/board/AcContent.jsp").forward(request, response);
			break;
		case "/SelfHomePage":
			request.getRequestDispatcher("/Home/SelfHome.jsp").forward(request, response);
			break;
			
		case "/NotiPage":
			NotiDAO dao = new NotiDAO();
			ArrayList<String> notiList = dao.allNotiList(LoginedID);
			request.setAttribute("notiList", notiList);
			request.getRequestDispatcher("/Home/Notice.jsp").forward(request, response);
			break;
			
		// ===========================기능 실행하는 컨트롤러===========================
		//Nav
		case "/getSearch":
			useSearch(request,response);
			break;
		//Nav
		case "/goMyPage":
			goMyPage(request,response,session);
			break;
			
		case "/goDmPage":
			goDmPage(request,response,session);
			break;
		case "/Logout":
			setLogout(request,response,session);
			break;
		//알림확인 기능
		case "/checkNoti":
			CheckNoti(request,response,LoginedID);
			break;
		//Write
		case "/uploadBoard":
			uploadBoard(request,response);
			break;
		//Setting
		case "/deleteAccount" :
			deleteAccount(request,response,session);
			break;
		case "/changePrivateStatus":
			setPrivateAc(request,response,session);
			break;	
		case "/Aedit":
			Aedit(request,response,session);
			break;	
		case "/Pedit":
			Pedit(request,response);
			break;	
			
			
		
		//로그인 회원가입
		case "/login":
			System.out.println(requestURI); // requestURI : 기능이름
			login(request, response);
			break;
		case "/signup":
			System.out.println(requestURI);
			signup(request, response);
			break;
		//관리자
		case "/manager":
			manager(request, response);
			break;
		case "/update":			
			update(request,response);
			break;
		case "/mdelete":		
			System.out.println(requestURI);
			delete(request,response);
			break;
		case "/isprivateChange":
			isprivateChange(request,response);
			break;
		case "/postList":
			postList(request, response, manageID);
			break;
		case "/postDel":
			postDel(request,response);
			break;	
		//
		
		//=========================추가 시작
			
			
		case "/selectBoard":
			pageMove = selectBoard(request, response, bid, comment, commentDetail, pageRoute,m2id,index);
			request.getRequestDispatcher(pageMove).forward(request, response);			
			break;
		case "/likeWho":
			pageMove = likeWho(request, response, bid, boardCount, index, m2id);
			request.getRequestDispatcher(pageMove).forward(request, response);
			break;
		case "/insertComment":
			session = request.getSession();
			pageMove = insertComment(request,response,bid,comment, boardCount);
			request.getRequestDispatcher(pageMove).forward(request, response);
			break;
		case "/delete":
			pageMove = delete(request, response, bid, boardCount, index, m2id);
			request.getRequestDispatcher(pageMove).forward(request, response);
			break;			
		case "/selectAc":
			String memberId=request.getParameter("memberId")==null? null : request.getParameter("memberId");
			String ae=request.getParameter("ae")==null? null : request.getParameter("ae");
			pageMove = selectAc(request, response, m2id, index, memberId,ae);
			request.getRequestDispatcher(pageMove).forward(request, response);
			break;
		case "/follow":
			System.out.println(0);
			pageMove = follow(request, response, mid);
			request.getRequestDispatcher(pageMove).forward(request, response);	
			break;
	    case "/deleteComment":
	        pageMove = deleteComment(request, response, cid, bid);
	        request.getRequestDispatcher(pageMove).forward(request, response);   
	        break;
	    case "/selectDm":
			pageMove = selectDm(request, response, room, LoginedID);
			request.getRequestDispatcher(pageMove).forward(request, response);			
			break;	         
	          
		//=========================추가 끝
		}
		
		
		session.setAttribute("notiCount", notiCount(request,response,LoginedID));
		System.out.println("==========service end==========");
		
	}
	
	//=======================Nav=======================//

	
	// 내 페이지 가기
	private void goMyPage(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		
		if((String)session.getAttribute("memberId") != null) {
			String mid = (String)session.getAttribute("memberId");
			if(!mid.equals("")) {
				response.sendRedirect("/sns/controller/MyPage");
			}else {
				out.println("<script> alert('로그인 해 주십시오');location.href='/sns/controller/LoginPage'; </script>;");
				out.close();
			}
		}else {
			out.println("<script> alert('로그인 해 주십시오');location.href='/sns/controller/LoginPage'; </script>;");
			out.close();
		}
		
		
	}
	
	private void goDmPage(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		
		if((String)session.getAttribute("memberId") != null) {
			String mid = (String)session.getAttribute("memberId");
			if(!mid.equals("")) {
				response.sendRedirect("/sns/controller/DmPage");
			}else {
				out.println("<script> alert('로그인 해 주십시오');location.href='/sns/controller/LoginPage'; </script>;");
				out.close();
			}
		}else {
			out.println("<script> alert('로그인 해 주십시오');location.href='/sns/controller/LoginPage'; </script>;");
			out.close();
		}
		
		
	}
	
	
	// 검색한 문자가 포함된 아이디들 리턴
	private void useSearch(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		String searchText = request.getParameter("searchText");
		memberDAO dao = new memberDAO();
		
		ArrayList<memberDTO> searchedList = dao.getSearch(searchText);
		request.setAttribute("searchedList", searchedList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Home/SearchedMember.jsp");
		rd.forward(request,response);
	}
	

	//====================================================//
	
	
	
	//=======================Write=======================//
	// 이미지 저장하고 ImageFile 아래 경로 구함
	private void uploadBoard(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
	      boardDAO dao = new boardDAO();
	      request.setCharacterEncoding("UTF-8");
	      String ImageFolderPath = request.getServletContext().getRealPath("/ImageFile");
	      String ImageFilePath = "";
	      
	      UploadUtil uploadUtil = UploadUtil.create(request.getServletContext());

	      List<Part> parts = (List<Part>) request.getParts();
	      
	      for(Part part : parts) {
	         if(!part.getName().equals("ImageFile")) continue; //ImageFile로 들어온 Part가 아니면 스킵
	         if(part.getSubmittedFileName().equals("")) continue; //업로드 된 파일 이름이 없으면 스킵
	         System.out.println(part.getName());
	         
	         
	         ImageFilePath = ImageFilePath +","+uploadUtil.saveFiles(part, uploadUtil.createFilePath());

	         System.out.println("=========saveImage=========");
	         System.out.println("ImageFolderPath : " + ImageFolderPath);
	         System.out.println("ImageFilePath : " + ImageFilePath);
	         System.out.println("=========saveImage=========");
	      }
	      ImageFilePath = ImageFilePath.substring(1);
	      dao.uploadBoard(request, response, ImageFilePath);
	      response.sendRedirect("/sns/controller/HomePage");
	   }
	

	
	
	//====================================================//
	
	
	//=======================Setting=======================//
	//setting 페이지에 로그인된 회원 정보 뿌리고 이동
	private void showMemberInfo (HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		String mid = (String)session.getAttribute("memberId");

		memberDAO dao = new memberDAO();
		memberDTO dto = dao.getMemberInfo(request, response, mid);
		request.setAttribute("memberInfo", dto);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Setting/Setting.jsp");
		rd.forward(request,response);
	}
	
	// 로그인된 회원 계정 삭제관련
	private void deleteAccount(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String mid = (String)session.getAttribute("memberId"); //세션에 로그인되있는 아이디
		String enterPassword = request.getParameter("password"); // 삭제를 위해서 입력한 비밀번호

		memberDAO dao = new memberDAO();
		String delStatus = dao.deleteAccount(request, response, mid, enterPassword,session);
		
		out.println(delStatus);
		out.close();
	}
	
	// 계정상태 비공개로 전환(공개="no" 비공개="yes")
	private void setPrivateAc(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		
		// 한글로 출력 위해서
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		
		String mid = (String)session.getAttribute("memberId");
		
		memberDAO dao = new memberDAO();
		memberDTO dto = dao.getMemberInfo(request, response, mid);
		
		String changeStatus = dao.changePrivateState(request, response, dto);
		out.println(changeStatus);
		out.close();
	}
	
	private void Aedit (HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		String mid = (String)session.getAttribute("memberId");

		System.out.println(mid);
		memberDAO dao = new memberDAO();
		dao.Aedit(request, response, mid);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Home/SelfHome.jsp");
		rd.forward(request,response);
	}
	
	//프로필 수정
	private void Pedit (HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();
	    String memberId = (String)session.getAttribute("memberId"); //로그인된 아이디
		request.setCharacterEncoding("UTF-8");
		String ImageFolderPath = request.getServletContext().getRealPath("/profilephoto"); //프로필 이미지가 올라갈 폴더 패스
		String savedName = "";
		String intro = "";
		UploadUtil2 uploadUtil = UploadUtil2.create(request.getServletContext());

		List<Part> parts = (List<Part>) request.getParts();
		
		for(Part part : parts) {
			if(!part.getName().equals("profilephoto")) continue; //profilephoto로 들어온 Part가 아니면 스킵
			if(part.getSubmittedFileName().equals("")) continue; //업로드 된 파일 이름이 없으면 스킵
			System.out.println(part.getName());
			
			savedName = uploadUtil.saveFiles(part,ImageFolderPath, memberId);
			
			System.out.println("=========saveImage=========");
			System.out.println("Saved Name : " + ImageFolderPath);
			System.out.println("ImageFilePath : " + savedName);
			System.out.println("=========saveImage=========");
		}
		for(Part part :parts) {
			if(!part.getName().equals("intro")) continue; 
//			if(part.getSubmittedFileName().equals("")) continue; 
			intro = request.getParameter("intro");
			
			
		}
		memberDAO dao = new memberDAO();
		dao.Pedit(request, response, memberId,intro,savedName);
		response.sendRedirect("/sns/controller/MyPage");
	}
	
	
	
	//====================================================//
	
	//=======================Log=======================//
	public void setLogin(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws ServletException, IOException { 
		PrintWriter out = response.getWriter();  
		request.setCharacterEncoding("utf-8");

	      String mid = request.getParameter("mid"); 
	      String pw = request.getParameter("pw");
	      
	      memberDAO dao = new memberDAO();   // memberDAO에 가서 db 조회해서 리턴
	      memberDTO dto = dao.login(mid, pw); 
	      
	      // id, pw 둘다 맞으면 
	      if (dto.getMid() != null) { 
	         session.setAttribute("memberId", mid); // 로그인된 아이디 설정
	         response.sendRedirect("/sns/controller/HomePage");
	      }
	      // id, pw 둘중 하나라도 틀리면
	      else {
	    	 out.println("<script> alert('없는 계정이거나, 입력 정보가 틀렸습니다.');location.href='/sns/controller/LoginPage'; </script>;");
	      }      
	      dao.close();
	   }

	
	private void setLogout(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		session.removeAttribute("memberId");
		response.sendRedirect("/sns/controller/LoginPage");
	}
	


	
	
	
	
	//====================================================//
	
	//=======================Notice=======================//
	//알림 갯수 리턴
	public int notiCount(HttpServletRequest request, HttpServletResponse response,String mid)throws ServletException, IOException {
		NotiDAO dao =new NotiDAO();
		ArrayList<String> notiList = dao.isNoti(mid);
		int notiCount = 0;
		for(int i=0;i<notiList.size();i++) {
			System.out.println("알림 : " + notiList.get(i));
			notiCount++;
		}
		return notiCount;
	}
	
	// 알림 확인
	public void CheckNoti(HttpServletRequest request, HttpServletResponse response,String mid)throws ServletException, IOException {

		NotiDAO dao =new NotiDAO();
		dao.CheckNoti(mid);

		response.sendRedirect("/sns/controller/NotiPage");
	}
	//====================================================//
	
	
	//=======================add from saemin START=======================//
	
	// Home/Home.jsp - 게시물 조회
		public String selectBoard(HttpServletRequest request, HttpServletResponse response, String bid, 
				String comment, String commentDetail, String pageRoute, String m2id, String index) throws ServletException, IOException {
			String pageMove ="";
			boardDAO dao = new boardDAO(); 
			pageMove =dao.selectBoard(request, response, bid, comment, commentDetail, pageRoute,m2id,index);
			dao.close();
			return pageMove;
		}
		

		// Home/Home.jsp - 게시물 좋아요 누가누가 조회
		public String likeWho(HttpServletRequest request, HttpServletResponse response, 
				String bid, String boardCount,String index, String m2id) throws ServletException, IOException {
			String pageMove ="";
			boardDAO dao = new boardDAO();
			pageMove =dao.likeWho(request, response, bid, boardCount,index, m2id);
			dao.close();
			return pageMove;
		}

		// Home/Home.jsp - 댓글 등록
		public String insertComment(HttpServletRequest request, HttpServletResponse response, String bid, String comment, String boardCount) throws ServletException, IOException {
			String pageMove ="";
			commentDAO dao = new commentDAO();
			String commentDetail = request.getParameter("commentDetail");
			pageMove = dao.insertComment(request, response, bid, comment, commentDetail, boardCount);
			dao.close();
			return pageMove;
		}
		
		// Home/AcHome.jsp - 팔로우
		public String follow(HttpServletRequest request, HttpServletResponse response, String mid) throws ServletException, IOException {
			String pageMove ="";
			memberDAO dao = new memberDAO();
			pageMove = dao.follow(request, response, mid);
			dao.close();
			return pageMove;
		}
	      // Home/AcHome.jsp - 댓글 삭제
	      public String deleteComment(HttpServletRequest request, HttpServletResponse response, String cid, String bid) throws ServletException, IOException {
	         String pageMove ="";
	         commentDAO dao = new commentDAO();
	         pageMove = dao.deleteComment(request, response, cid, bid);
	         dao.close();
	         return pageMove;
	      }
	//=======================add from saemin END=======================//
		
		
	//=======================add from hyunjun START=======================//
	    //achome, selfhome 보드 리스트 불러오기
		public String selectAc(HttpServletRequest request, HttpServletResponse response, String m2id, String index, String memberId, String ae) throws ServletException, IOException {
			String pageMove ="";
			
			if(ae!=null) {
				memberDAO dao = new memberDAO(); 
				pageMove =dao.ae(request, response);
				dao.close();
				
			} else {
				boardDAO dao = new boardDAO(); 
				pageMove =dao.selectAc(request, response, m2id, index, memberId);
				dao.close();
			}
			
			return pageMove;
		}
		
		//게시글 삭제
		public String delete(HttpServletRequest request, HttpServletResponse response, String bid, String boardCount,String index, String m2id) throws ServletException, IOException {
			String pageMove ="";
			boardDAO dao = new boardDAO();
			pageMove =dao.delete(request, response, bid, boardCount, index, m2id);
			dao.close();
			return pageMove;
		}		
		
		//dm리스트 불러오기
		public String selectDm(HttpServletRequest request, HttpServletResponse response, 
				String room, String LoginedID ) throws ServletException, IOException {
			String pageMove ="";
			messageDAO dao = new messageDAO(); 
			pageMove =dao.selectDm(request, response, room, LoginedID);
			dao.close();
			return pageMove;
		}

		
	//=======================add from hyunjun END=======================//
		//기랑 추가//

		public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session = request.getSession();
			request.setCharacterEncoding("utf-8");

		 	String mid = request.getParameter("mid");  
		 	String pw = request.getParameter("pw");
			
			memberDAO dao = new memberDAO();   // memberDAO에 가서 db 조회해서 리턴
			memberDTO dto = dao.login(mid, pw); 
			
			// id, pw 둘다 맞으면 
			if (dto.getMid() != null) { 
				if(dto.getMid().equals("admin")) {
					session.setAttribute("memberId", mid); // 로그인된 아이디 설정
					response.sendRedirect("/sns/manager/manager.jsp");
				}else {
					session.setAttribute("memberId", mid); // 로그인된 아이디 설정
					response.sendRedirect("/sns/Home/Home.jsp");
				}
			}
			// id, pw 둘중 하나라도 틀리면
			else {
				//request.getRequestDispatcher("Login.jsp").forward(request, response);
				response.sendRedirect("/sns/Login/Login.jsp");
			}		
			dao.close();
		}
		
		//관리자 : 게시글 조회
		public void postList(HttpServletRequest request, HttpServletResponse response, String manageID) throws ServletException, IOException {
			HttpSession session = request.getSession();
		 	boardDAO dao = new boardDAO(); 
		 	dao.postList(request, response, manageID);
//			response.sendRedirect("/sns/manager/postList.jsp");
			request.getRequestDispatcher("/manager/postList.jsp").forward(request, response);
		}
		
		
		//관리자 : 회원조회
		public void manager(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
//			HttpSession session = request.getSession();
//			PrintWriter out = response.getWriter();
			memberDAO dao = new memberDAO();
			dao.manager(request, response);
			request.getRequestDispatcher("/manager/manager.jsp").forward(request, response);

		}
		
		//관리자 : 회원수정	
		public void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
			memberDAO dao = new memberDAO();	 	
			dao.update(request,response); 		
			response.sendRedirect("/sns/manager/manager.jsp");
		}
		
		//관리자 : 회원삭제
		public void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");		
			memberDAO dao = new memberDAO();
			dao.delete(request, response);	
			response.sendRedirect("/sns/manager/manager.jsp");
		}
		
		public void postDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
			String id = request.getParameter("id");
		 	boardDAO dao = new boardDAO(); 
		 	dao.postDel(request, response);
			response.sendRedirect("/sns/manager/postList.jsp?manageID=" + id);
		}	
		
		
		public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session = request.getSession();
	   		session.removeAttribute("memberId");
	   		response.sendRedirect("/sns/Login/Login.jsp");
		}
		
		public void signup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			memberDAO dao = new memberDAO();
			dao.signup(request, response);
			response.sendRedirect("/sns/Login/Login.jsp");
		}
		
		public void isprivateChange(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");		
			memberDAO dao = new memberDAO();
			dao.isprivateChange(request, response);	
			response.sendRedirect("/sns/manager/manager.jsp");
			
		}	
		//기랑 끝//
}
//class end
