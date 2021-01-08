package kr.co.shovvel.dm.interceptor;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.logis.user.SessionLogisUser;
import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

public class LogisCustomInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = Logger.getLogger(this.getClass());
    private String redirectPage;
    private String noSessionPage;
    private List<String> noSession;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.debug("Request URI : " + request.getRequestURI());

        // root-context.xml의 noSession 리스트에 있는 경로로 호출하면 바로 리턴
        // 아닐 걍우 세션에 데이터 있는지 확인하고 없으면 /로 리다이렉트
        for (String s : noSession) {
            String temp = s.trim();
            if (temp.equals(request.getRequestURI())) {
                return super.preHandle(request, response, handler);
            }
        }

        HttpSession session = request.getSession(true);

        SessionLogisUser sessionLogisUser = (SessionLogisUser) session.getAttribute(Consts.LOGIS_USER.SESSION_LOGIS_USER);
        boolean bAjaxRequest = this.isAJAXRequest(request); // 현재는 사용하지 않음

        // 만료 시간 설정
        Date nowDate = new Date();
        Date expireDate = getExpireDate(nowDate, 3600);
        session.setAttribute("expireDate", expireDate);

        // 세션이 없으면 로그인 화면으로 이동
        if (sessionLogisUser == null) {
            response.sendRedirect(redirectPage);
            return false;
        }

        return super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

        logger.debug("Request URI : " + request.getRequestURI());

        // root-context.xml의 noSession 리스트에 있는 경로로 호출하면 바로 리턴
        for (String s : noSession) {
            String temp = s.trim();

            if (temp.equals(request.getRequestURI())) {
                return;
            }
        }

        super.postHandle(request, response, handler, modelAndView);

        if (modelAndView != null && !this.isAJAXRequest(request)) {
            HttpSession session = request.getSession(true);

            SessionLogisUser sessionLogisUser = (SessionLogisUser) session.getAttribute(Consts.LOGIS_USER.SESSION_LOGIS_USER);
            if (sessionLogisUser != null) {
                logger.debug("SessionDriver -> " + sessionLogisUser.toString());
            }
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
    }

    public boolean isAJAXRequest(HttpServletRequest request) {
        boolean check = false;
        String ajaxRequest = request.getHeader("AJAX");
        if (ajaxRequest != null && ajaxRequest.equals("true")) {
            check = true;
        }
        return check;
    }

    /**
     * 세션의 만료 시간을 추가
     */
    private Date getExpireDate(Date nowDate, int timeoutMinute) {
        return DateUtils.addMinutes(nowDate, timeoutMinute);
    }


    public String getRedirectPage() {
        return redirectPage;
    }

    public void setRedirectPage(String redirectPage) {
        this.redirectPage = redirectPage;
    }

    public String getNoSessionPage() {
        return noSessionPage;
    }

    public void setNoSessionPage(String noSessionPage) {
        this.noSessionPage = noSessionPage;
    }

    public List<String> getNoSession() {
        return noSession;
    }

    public void setNoSession(List<String> noSession) {
        this.noSession = noSession;
    }
}
