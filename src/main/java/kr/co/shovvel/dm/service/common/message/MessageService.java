package kr.co.shovvel.dm.service.common.message;

import java.util.List;

import kr.co.shovvel.dm.domain.common.message.MessageRecipient;

public interface MessageService {

	public void sendMessage(String type, String category, List<MessageRecipient> recipients, String... attributes);
	
}
