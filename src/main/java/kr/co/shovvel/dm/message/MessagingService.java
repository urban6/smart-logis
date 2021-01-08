package kr.co.shovvel.dm.message;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;

import java.util.HashMap;
import java.util.Random;

/**
 * SMS 문자 메시지를 보내는 클래스
 * - 90바이트 (한글 45자) 이내의 내용을 문자 메시지로 보낼 수 있다.
 * 그 이상 길어질 경우 LMS를 발송할 수 있도록 클래스를 수정해야 한다.
 * <p>
 * https://www.coolsms.co.kr/
 */
public class MessagingService {

    private Logger logger = Logger.getLogger(this.getClass());

    // @Value를 사용했을 때, null이 들어가서 나중에 문제를 파악해야 한다.
    // @Value("#{configuration['messageApiKey']}")
    private final String API_KEY = "NCSTDP9Y7QTNJZAQ";

    // @Value("#{configuration['messageApiSecret']}")
    private final String API_SECRET = "RXJYXFL0GSMAQPUN7Y1OPJL8SLJE6T6W";

    private static MessagingService instance;

    private Message message = null;

    public MessagingService() {
        message = new Message(API_KEY, API_SECRET);
    }

    public static MessagingService getInstance() {
        if (instance == null) {
            instance = new MessagingService();
        }
        return instance;
    }

    /**
     * SMS 메시지 전송
     * FIXME - 회사 계정으로 API를 사용할 경우, 발신자 번호를 수정해야 한다.
     * 추가로 일일 발송량 한도가 설정되어 있기 때문에 설정을 변경해야 한다.
     *
     * @param phoneNumber - 수신 전화번호
     * @param text        - 메시지 내용
     * @return -
     */
    public JSONObject sendSMS(String phoneNumber, String text) {
        // 4 개의 파라미터(to, from, type, message)는 필수로 채워야 한다.
        HashMap<String, String> params = new HashMap<>();
        params.put("to", phoneNumber); // 수신 전화 번호
        params.put("from", "01043556892"); // 인증된 발신 전화 번호만 사용할 수 있다.
        params.put("type", "SMS");
        params.put("text", text);
        params.put("app_version", "Smart Taxi 1.0"); // 버전이 실제로 어떻게 동작하는지 체크를 해야한다.

        JSONObject result = null;
        try {
            // 메시지 전송한다.
            result = message.send(params);
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
        return result;
    }

    /**
     * 휴대폰번호로 인증번호[4 자리]를 전송한다.
     *
     * @param phoneNumber - 휴대폰번호
     * @param certNumber  - 인증번호 4자리
     */
    public JSONObject sendCertificationSMS(String phoneNumber, String certNumber) {
        // 메시지 전송
        String message = "[모두 고고해] 인증 번호 [" + certNumber + "]를 입력해주세요.";
        return sendSMS(phoneNumber, message);
    }
}
