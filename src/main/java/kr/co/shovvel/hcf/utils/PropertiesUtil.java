package kr.co.shovvel.hcf.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Properties;


public class PropertiesUtil {
	private static HashMap<String, Properties> propses;
	
	
	public static String get(String prop, String key){
		
		if(load(prop) == true){
			return propses.get(prop).getProperty(key);
		}else{
			return "";
		}
	}
	
	private static boolean load(String prop){
		
		if(propses == null){
			init();
		}
		
		if(propses.containsKey(prop)){
			return true;
		}else{
			try{
				StringBuilder path = new StringBuilder();
				path.append(System.getProperty("catalina.base"))
					.append(File.separator + "webapps")
					.append(File.separator + "config")
					.append(File.separator + prop)
					.append(".properties");

			    InputStream is = new FileInputStream(path.toString());
			    Properties props = new Properties();
			    props.load(is);
	
			    propses.put(prop, props);
			    
			    is.close();

			    return true;			    
			}catch(Exception e){
				e.printStackTrace();
				return false;
			}
		}
	}

	private static void init(){
		propses = new HashMap<String, Properties>();
	}
}
