package kr.co.shovvel.dm.service.common.message.sms;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.shovvel.dm.dao.common.message.MessageMapper;
import kr.co.shovvel.dm.domain.common.message.MessageTransmission;
import kr.co.shovvel.dm.service.common.message.MessageSenderSupport;

/**
 * SMS를 전송
 * @author hyseo
 *
 */
@Service
public class SmsSender extends MessageSenderSupport {

	private MessageMapper messageMapper;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public SmsSender() {
		super(null);
	}
			
	public SmsSender(MessageTransmission messageTransmission) {
		super(messageTransmission);
	}

	public SmsSender setMessageMapper(MessageMapper messageMapper) {
		this.messageMapper = messageMapper;
		return this;
	}
	
	protected String sendMessage() {		
		String result = null;
		
		getMessageTransmission().listSendMessageMap().forEach(message -> {
			logger.debug("Message[{}] send.", message);
			messageMapper.insertSendMessage(message);
		});
		
		return result;
	}
	
}
