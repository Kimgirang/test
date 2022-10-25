package comment;

public class commentDTO {
	
	private String cid;
	private String content;
	private String birth;
	private String id;
	private String likeCount;
	private String commentId;
	private String pfp;
	
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(String likeCount) {
		this.likeCount = likeCount;
	}
	public String getPfp() {
		return pfp;
	}
	public void setPfp(String pfp) {
		this.pfp = pfp;
	}

	  public String getCommentId() {
	      return commentId;
	   }
	   public void setCommentId(String commentId) {
	      this.commentId = commentId;
	   }
	
	
}