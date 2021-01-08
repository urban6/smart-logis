package kr.co.shovvel.dm.service.common.message;

import java.util.List;

import kr.co.shovvel.dm.domain.common.message.Message;
import kr.co.shovvel.dm.domain.common.message.MessageRecipient;
import kr.co.shovvel.dm.domain.common.message.MessageTransmission;

public abstract class MessageSenderService implements MessageService {
	
	MessageSender sender;
	
	private String type;
	
	private String category;
		
	private List<MessageRecipient> recipients;
	
	private String[] attributes;
	
	@Override
	public void sendMessage(String type, String category, List<MessageRecipient> recipients, String... attributes) {
		this.type = type;
		this.category = category;
		this.attributes = attributes;
		this.recipients = recipients;
		
		MessageTransmission mt = new MessageTransmission();
		mt.setMessage(getMessage());
		mt.setListRecipients(recipients);
				
		sender = MessageSenderProvider.get(mt);
		sender.send();
	}
		
	public String[] getAttribute() {
		return this.attributes;
	}
	
	protected String getType() {
		return this.type;
	}
	
	protected String getCategory() {
		return this.category;
	}
		
	protected abstract Message getMessage();
	
	public List<MessageRecipient> getRecipients() {
		return this.recipients;
	}
	
}
