package notice;

import java.util.ArrayList;

import db.JDBConnect;

public class NotiDAO extends JDBConnect{
	
	// 로그인된 사람아이디에 읽지않은 메시지 로드
	public ArrayList<String> isNoti(String getid) {
		ArrayList<String> notiList = new ArrayList<String>();
		try {
			String sql = "select notice from noti where getid=? and read_at is null order by created_at";
			psmt = con.prepareStatement(sql);
			psmt.setString(1,getid);
			rs = psmt.executeQuery();
			while(rs.next()) {
				notiList.add(rs.getString("notice"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return notiList;
	}
	
	// 모든 알림 로드
	public ArrayList<String> allNotiList(String getid){
		ArrayList<String> allNotiList = new ArrayList<String>();
		try {
			String sql = "select notice from noti where getid=? order by created_at limit 50 offset 0";
			psmt = con.prepareStatement(sql);
			psmt.setString(1,getid);
			rs = psmt.executeQuery();
			while(rs.next()) {
				allNotiList.add(rs.getString("notice"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return allNotiList;
	}
	
	
	// 로그인된 사람아이디를 받아서 버튼을 눌렀을 때 이 메소드 실행하게 해서 읽은날짜에 now로 업데이트
	public void CheckNoti(String getid) {
		try {
			String sql = "update noti set read_at=now() where getid=? and read_at is null";
			psmt = con.prepareStatement(sql);
			psmt.setString(1,getid);
			psmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
	}

	
	
	//get 받는사람 put 보내는사람 notice 댓글이 달렸습니다
	public void addComNotice(String getid, String putid,int boardid) {
		String notice = String.format("%s님이 %d게시글에 댓글을 달았습니다",putid,boardid);
		try {
			String sql = "insert into noti(getid,putid,notice,created_at) values(?,?,?,now())";				
			psmt = con.prepareStatement(sql);
			psmt.setString(1, getid);
			psmt.setString(2, putid);
			psmt.setString(3, notice);
			psmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//get 받는사람 put 보내는사람 notice 좋아요가 달렸습니다
		public void addLikeNotice(String getid, String putid,int boardid) {
			String notice = String.format("%s님이 %d게시글에 좋아요를 눌렀습니다",putid,boardid);
			try {
				String sql = "insert into noti(getid,putid,notice,created_at) values(?,?,?,now())";				
				psmt = con.prepareStatement(sql);
				psmt.setString(1, getid);
				psmt.setString(2, putid);
				psmt.setString(3, notice);
				psmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}

	//get 받는사람 put 보내는사람 notice putid가 나를 팔로우 했습니다
			public void addFollowNotice(String getid, String putid) {
				String notice = String.format("%s님이 나를 팔로우하기 시작했습니다",putid);
				try {
					String sql = "insert into noti(getid,putid,notice,created_at) values(?,?,?,now())";				
					psmt = con.prepareStatement(sql);
					psmt.setString(1, getid);
					psmt.setString(2, putid);
					psmt.setString(3, notice);
					psmt.executeUpdate();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}

}
