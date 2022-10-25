package board;

public class boardDTO {   
	
    private String bid;
    private String title; //안씀
    private String content;
    private String birth;
    private String likeCount;
    private String photo;
    private String id;
    private String photo2;
    private String likeCondition;
    
    
	public String getPhoto2() {
		return photo2;
	}
	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}
	private String pfp;
	private String commentCount;
	
	// 좋아요 관련
	private String likeId;
	private String likeWho;
    
    
	
	
public String getLikeCondition() {
		return likeCondition;
	}
	public void setLikeCondition(String likeCondition) {
		this.likeCondition = likeCondition;
	}
public String getBid() {
      return bid;
   }
   public void setBid(String bid) {
      this.bid = bid;
   }
   public String getTitle() {
      return title;
   }
   public void setTitle(String title) {
      this.title = title;
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
   public String getLikeCount() {
      return likeCount;
   }
   public void setLikeCount(String likeCount) {
      this.likeCount = likeCount;
   }
   public String getPhoto() {
      return photo;
   }
   public void setPhoto(String photo) {
      this.photo = photo;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   
   

   public String getPfp() {
		return pfp;
	}
	public void setPfp(String pfp) {
		this.pfp = pfp;
	}
	public String getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	public String getLikeId() {
		return likeId;
	}
	public void setLikeId(String likeId) {
		this.likeId = likeId;
	}
	public String getLikeWho() {
		return likeWho;
	}
	public void setLikeWho(String likeWho) {
		this.likeWho = likeWho;
	}
}