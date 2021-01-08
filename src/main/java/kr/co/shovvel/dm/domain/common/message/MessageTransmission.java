package kr.co.shovvel.dm.domain.common.message;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class MessageTransmission {

	private List<MessageRecipient> listRecipients;
	
	private Message message;
	
	private String schduledDeleveryDateTime;

	private String isConsentReceiveMarketingInformation;
	
	public List<MessageRecipient> getListRecipients() {
		return listRecipients;
	}

	public void setListRecipients(List<MessageRecipient> listRecipients) {
		this.listRecipients = listRecipients;
	}

	public Message getMessage() {
		return message;
	}

	public void setMessage(Message message) {
		this.message = message;
	}
	
	public String getSchduledDeleveryDateTime() {
		return schduledDeleveryDateTime;
	}

	public void setSchduledDeleveryDateTime(String schduledDeleveryDateTime) {
		this.schduledDeleveryDateTime = schduledDeleveryDateTime;
	}

	public String getIsConsentReceiveMarketingInformation() {
		return isConsentReceiveMarketingInformation;
	}

	public void setIsConsentReceiveMarketingInformation(String isConsentReceiveMarketingInformation) {
		this.isConsentReceiveMarketingInformation = isConsentReceiveMarketingInformation;
	}

	public List<HashMap<String, String>> listSendMessageMap() {
		
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		
		if (listRecipients == null || listRecipients.isEmpty() || message == null) {
			return list;
		}
		
		if (this.schduledDeleveryDateTime == null) {
			this.schduledDeleveryDateTime = new SimpleDateFormat("yyyyMMddhhmmss").format(new Date());
		}
		
		listRecipients.forEach( recipient -> {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userId", recipient.getUserId());
			map.put("phoneNumber", recipient.getPhoneNumber());
			map.put("recipientCategory", recipient.getCategory());
			map.put("messageCategory", message.getCategory());
			map.put("contents", message.getContents());
			map.put("schduledDeleveryDateTime", schduledDeleveryDateTime);
			
			list.add(map);
		});
		
		return list;		
	}
}
