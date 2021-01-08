package kr.co.shovvel.dm.service.common.message;

import static kr.co.shovvel.dm.common.Consts.messageType.push;
import static kr.co.shovvel.dm.common.Consts.messageType.sms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.dao.common.message.SmsMessageMapper;
import kr.co.shovvel.dm.domain.common.message.MessageTransmission;
import kr.co.shovvel.dm.service.common.message.sms.SmsSender;

@Component
public class MessageSenderProvider {
	
	private static SmsMessageMapper smsMessageMapper;
	
	@Autowired
	public void setSmsMessageMapper(SmsMessageMapper smsMessageMapper) {
		MessageSenderProvider.smsMessageMapper = smsMessageMapper;
	}
	
	public static MessageSender get(MessageTransmission messageTrasmission) {
		
		MessageSender sender = null;
		
		switch(messageTrasmission.getMessage().getType()) {		
		case sms:
			sender = new SmsSender(messageTrasmission).setMessageMapper(smsMessageMapper);
			
			break;
		
		case push:
		//	sender = new PushSender(message);
			break;
			
		default:
		//	throw InvalidException();
			break;			
		}
		
		return sender;		
	}
		
}
