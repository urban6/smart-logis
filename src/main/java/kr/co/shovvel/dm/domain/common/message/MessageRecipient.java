package kr.co.shovvel.dm.domain.common.message;

public class MessageRecipient {

	private String userId;				/* user */

	private String category;			/* 전체, 제휴사, 건강코칭, 사용자, 순응도 */
	
	private String phoneNumber;
	
	public MessageRecipient(String userId, String phoneNumber) {
		this.userId = userId;
		this.phoneNumber = phoneNumber;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

}
 