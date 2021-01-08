package kr.co.shovvel.dm.controller.logis.login;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.service.logis.login.LoginService;
import kr.co.shovvel.hcf.utils.LocaleUtil;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;
import java.util.Map;

@Controller
@RequestMapping(value = "/user/login")
public class LoginController {

    private Logger logger = Logger.getLogger(this.getClass());


    @Value("#{configuration['database.zoneoffset']}")
    private String databaseZoneOffset;

    @Autowired
    private CookieLocaleResolver localeResolver;

    @Autowired
    private LoginService loginService;

    @RequestMapping(value = "/login")
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response, Model model) {
        logger.debug("/login/login ip :" + request.getRemoteAddr());
        response.setHeader("Cache-Control", "no-cache");

        Locale locale = localeResolver.resolveLocale(request);

        logger.debug("locale : " + locale);
        logger.debug("locale language : " + locale.getLanguage());
        logger.debug("database.zoneoffset: " + databaseZoneOffset);

        logger.debug("ZoneOffset : " + LocaleUtil.getZoneOffset(request.getLocale(), databaseZoneOffset));

        ModelAndView mav = new ModelAndView();
        mav.setViewName("logis/login/login");
        return mav;
    }

    @RequestMapping(value = "/loginAction")
    public void loginAction(@RequestParam(required = false) String loginId, @RequestParam(required = false) String passwd, HttpServletRequest request, Model model) {
        logger.debug("LoginId = " + loginId + ", Passwd = "  + passwd);

        // 아이디를 이용해서 고유번호를 조회한다.
        String userUid = loginService.searchUserUid(loginId);

        int result = 0;
        if (userUid == null || userUid.isEmpty()) {
            result = Consts.LOGIN_RESULT.FAIL_ACCOUNT;
        } else {
            result = loginService.loginAction(userUid, loginId, passwd, request);
        }

        model.addAttribute("result", result);
    }
}
