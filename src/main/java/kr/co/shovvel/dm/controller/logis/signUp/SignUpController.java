package kr.co.shovvel.dm.controller.logis.signUp;

import kr.co.shovvel.dm.domain.logis.signUp.SignUpInfo;
import kr.co.shovvel.dm.domain.logis.user.LogisUser;
import kr.co.shovvel.dm.domain.logis.user.UserCompany;
import kr.co.shovvel.dm.message.MessagingService;
import kr.co.shovvel.dm.service.logis.signUp.SignUpService;
import kr.co.shovvel.dm.util.EncryptUtil;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping(value = "/user/signUp")
public class SignUpController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private SignUpService signUpService;

    @RequestMapping(value = "/signUp")
    public ModelAndView signUp(HttpServletResponse response, HttpServletRequest request) {
        response.setHeader("Cache-Control", "no-cache");

        ModelAndView mav = new ModelAndView();
        mav.setViewName("logis/signUp/signUp");

        return mav;
    }

    /**
     * 휴대폰 인증을 요청했을 때, 해당 휴대폰번호로 문자 메시지를 보낸다.
     *
     * @param phoneNumber - 휴대폰번호 (-)는 제외
     */
    @RequestMapping(value = "/certRequestAction", method = RequestMethod.POST)
    public void certRequestAction(@RequestParam(required = false) String phoneNumber, Model model) {
        logger.debug("휴대폰인증 요청 번호 : " + phoneNumber);

        // 인증번호 메시지를 보내고 DB에 저장한다.
        // String result = authService.insertAuthInfo(phoneNumber);
        // model.addAttribute("result", result);

        // 메시지를 보내지 않을 경우
        model.addAttribute("result", "1");
    }

    /**
     * 회원가입을 진행한다.
     */
    @RequestMapping(value = "/signUpAction", method = RequestMethod.POST)
    public void signUpAction(LogisUser logisUser, UserCompany userCompany, Model model) {
        logger.debug("LOGIS USER = " + logisUser + ", " + "USER COMPANY = " + userCompany);

        String result = signUpService.signUpAction(logisUser, userCompany);
        model.addAttribute("result", result);
    }
}
