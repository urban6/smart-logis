package kr.co.shovvel.dm.domain.common.message;

public class Message {
	
	private String type;					/* sms : SMS, push : Mobile push */
		
	private String title;
	
	private String contents;
	
	private String category;
		
	private String schduledDeleveryTime;
	
	/**
	 * 생성자
	 * @param type "sms" when sending sms, "push" when sending mobile push.
	 * @param contents The contents of the message to send.
	 * @param category Internal message code. See Consts.messageCategory.
	 * 	00707010 회원가입인증
	 * 	00707020 비밀번호변경인증
	 * 	00707030 저혈당으로인한보호자
	 * 	00707040 Notice
	 * 	00707080 패스워드 재설정 (임시비밀번호 발송)
	 * 	00707120 관리자 아이디 찾기
	 */
	public Message (String type, String contents, String category) {
		this.type = type;
		this.contents = contents;
		this.category = category;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
	
	@Override
	public String toString() {
		
		StringBuilder sb = new StringBuilder();
		sb.append("Message[");
		sb.append("Type=").append(type).append(", ");
		sb.append("Category=").append(category).append(", ");
		sb.append("Title=").append(title).append(", ");
		sb.append("Contents=").append(contents).append(", ");
		sb.append("SchduledDeleveryTime=").append(schduledDeleveryTime).append("]");
		
		return sb.toString();
	}
}
