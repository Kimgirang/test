package member;

public class memberDTO {

	private String mid;
	private String pw;
	private String email;
	private String pfp;
	private String phone;
	private String name;
	private String birth;
	private String follower;
	private String followerCount;
	private String intro;
	private String isprivate; // 추가



	public String getFollowerCount() {
		return followerCount;
	}
	public void setFollowerCount(String followerCount) {
		this.followerCount = followerCount;
	}
	public String getIsprivate() {
		return isprivate;
	}
	public void setIsprivate(String isprivate) {
		this.isprivate = isprivate;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPfp() {
		return pfp;
	}
	public void setPfp(String pfp) {
		this.pfp = pfp;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getFollower() {
		return follower;
	}
	public void setFollower(String follower) {
		this.follower = follower;
	}

}