package message;

import db.JDBConnect;

//import member.memberDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import board.boardDTO;
import comment.commentDTO;


public class messageDAO extends JDBConnect {

	
	public String selectDm(HttpServletRequest req, HttpServletResponse res, String room, String LoginedID){      
		
		String pageMove = "/Dm/lobby.jsp";
		if(room!=null) {pageMove = "/Dm/room.jsp";}
		//내가 들어가있는 채팅방 목록
		List<messageDTO> listDm=new ArrayList<messageDTO>();	        
        ArrayList<messageDTO> listdm = new ArrayList<messageDTO>();
        
		String sql = "select * from messagetbl where sid=? group by id";
		if(room!=null) {sql = "select * from messagetbl where id=?";}
	    PreparedStatement pstmt=null;
	    
        try {        	
        	//내가 들어간 채팅방 목록 정보
    	    pstmt= con.prepareStatement(sql);
    	    if(room!=null) {pstmt.setString(1,room);}
    	    else {pstmt.setString(1,LoginedID);}
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	messageDTO mdto=new messageDTO();
    	    	mdto.setId(rs.getString(1));	    	    	
    	    	mdto.setSid(rs.getString(2));
    	    	mdto.setMessage(rs.getString(3));
    	    	mdto.setDate(rs.getString(4));
    	    	if(room!=null) {listdm.add(mdto);}
    	    	else {listDm.add(mdto);}  	   
    	    }      	   
    	}
        catch (Exception e) {
            System.out.println("dm리스트 생성 중 예외 발생");
            e.printStackTrace();
        }   
        
        
        if(room!=null) {
        	req.setAttribute("listdm", listdm);
        	req.setAttribute("len", listdm.size());
        }
        else{
        	req.setAttribute("listDm", listDm);
        	req.setAttribute("Len", listDm.size());
        }
        
        
        System.out.println("dm리스트 생성");
        return pageMove;
    }
	
	
	
}