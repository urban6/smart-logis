package kr.co.shovvel.dm.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.common.listener.StartupListenerDomain;
import kr.co.shovvel.dm.service.common.listener.StartupListenerService;
import kr.co.shovvel.hcf.utils.ConfigurationUtil;

@Component
public class StartupHousekeeper implements ApplicationListener<ContextRefreshedEvent> {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private StartupListenerService startupListenerService;
	
	@Value("#{configuration['developerId']}")
	private String developerId;
	
	public void onApplicationEvent(final ContextRefreshedEvent event) {
		// do whatever you need here
	}
	
	@EventListener
    public void handleContextRefresh(ContextRefreshedEvent event) {
		logger.warn("handleContextRefresh called");
		/*
		logger.warn("StartupHousekeeper start========================================");
		
		String developerId = (new ConfigurationUtil()).getDeveloperId();
		StartupListenerDomain startupListenerDomain = new StartupListenerDomain();
		startupListenerDomain.setDeveloperId(developerId);
		
		startupListenerService.deleteUserSession(startupListenerDomain);
		
		logger.warn("StartupHousekeeper end========================================");
		 */
    }
}
