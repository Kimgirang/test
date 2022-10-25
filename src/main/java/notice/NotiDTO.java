package notice;

public class NotiDTO {
	private int notiid;
	private String getid;
	private String putid;
	private String notice;
	private String created_at;
	private String read_at;
	
	public int getNotiid() {
		return notiid;
	}
	public void setNotiid(int notiid) {
		this.notiid = notiid;
	}
	public String getGetid() {
		return getid;
	}
	public void setGetid(String getid) {
		this.getid = getid;
	}
	public String getPutid() {
		return putid;
	}
	public void setPutid(String putid) {
		this.putid = putid;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getRead_at() {
		return read_at;
	}
	public void setRead_at(String read_at) {
		this.read_at = read_at;
	}

}
