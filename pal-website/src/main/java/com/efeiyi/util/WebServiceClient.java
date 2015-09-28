package com.efeiyi.util;

import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;

public class WebServiceClient {

	private static final String ipPort = "www.nfc315.com:8080";
	
	public static JaxWsProxyFactoryBean getFactory(){
		JaxWsProxyFactoryBean factory = null;
		try{
			factory = new JaxWsProxyFactoryBean();  
	        factory.setServiceClass(MsgService.class);  
	        factory.setAddress("http://"+ipPort+"/nfcWebservice/services/msgService");  
		}catch(Exception e){
			e.printStackTrace();
		}
		return factory;
	}
}
