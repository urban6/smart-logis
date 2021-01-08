package kr.co.shovvel.dm.service.common.message;

import static kr.co.shovvel.dm.common.Consts.messageCategory.findAdministratorId;
import static kr.co.shovvel.dm.common.Consts.messageCategory.resetPassword;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

import kr.co.shovvel.dm.domain.common.message.Message;

@Service
public class MessageSenderServiceImpl extends MessageSenderService {

	@Override
	protected Message getMessage() {
		
		String contents = "";
		
		// DB화 필요
		switch(getCategory()) {
		case findAdministratorId :
			contents = makeMessageContents("[코치코치당뇨] 회원님의 아이디는 [{{attribute}}] 입니다.", getAttribute());
			break;
			
		case resetPassword :
			contents = makeMessageContents("[코치코치당뇨] 임시 비밀번호는 {{attribute}} 입니다.", getAttribute());
			break;
		}
		
		return new Message(getType(), contents, getCategory());
	}

	private String makeMessageContents(String contents, String[] attributes) {
		
		if (attributes == null || attributes.length == 0) {
			return contents;
		}
		
		Matcher matcher = Pattern.compile("\\{\\{attribute\\}\\}").matcher(contents);
		
		int i = 0;
		StringBuffer messageContents = new StringBuffer();
		
		while(matcher.find()) {
			matcher.appendReplacement(messageContents, attributes[i]);			
			if (++i == attributes.length) {
				i = attributes.length - 1;
			}
		}
		return matcher.appendTail(messageContents).toString();
	}
	
}
