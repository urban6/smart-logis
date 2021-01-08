package kr.co.shovvel.dm.service.common.message;

import kr.co.shovvel.dm.domain.common.message.MessageTransmission;

public abstract class MessageSenderSupport implements MessageSender {

	protected MessageTransmission messageTransmission;
	
	public MessageSenderSupport(MessageTransmission messageTransmission) {
		this.messageTransmission = messageTransmission;
	}
	
	public MessageTransmission getMessageTransmission() {
		return this.messageTransmission;
	}
	
	@Override
	public void send() {
		insertSendMessageHistory(sendMessage());
	}
	
	/**
	 * 메세지를 보내고 결과 코드를 반환
	 * @return Return result code
	 */
	protected abstract String sendMessage();
	
	private void insertSendMessageHistory(String result) {
		// history
	}
	
}
