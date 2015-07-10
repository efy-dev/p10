package com.ming800.core.util;

import java.util.Properties;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.util.PropertyPlaceholderHelper;
import org.springframework.util.StringValueResolver;

public class BssPropertiesConfigure extends PropertyPlaceholderConfigurer {
	private static Logger logger = Logger
			.getLogger(BssPropertiesConfigure.class);
	private static final String DEFAULT_ENCRYPT_PLACEHOLDER_PREFIX = "BSS_ENCRYPT:";
	private static final String EMPTY_STRING = "";
	private String key;

	public String getKey() {
		return this.key;
	}

	public void setKey(String key) {
		this.key = key;
	}

/*protected String resolvePlaceholder(String strVal,Properties props) {
		if ((!StringUtil.isEmpty(strVal))&&(strVal.startsWith("BSS_ENCRYPT:"))) {
			strVal = strVal.replaceFirst("BSS_ENCRYPT:", "");
            System.out.println("come in ...");
			String value = super.resolvePlaceholder(strVal, props);
            System.out.println(value);
			logger.debug("敏感的加密属性数�?, 属�?�名�?:{},属�?��??:{}"
					+ new Object[] { strVal, value });

			try {
				return DESEncryptUtil.decrypt(value, getKey());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return super.resolvePlaceholder(strVal, props);
	}

protected String resolvePlaceholder(String strVal,Properties props,int systemPropertiesMode) {
	if ((!StringUtil.isEmpty(strVal))&&(strVal.startsWith("BSS_ENCRYPT:"))) {
		strVal = strVal.replaceFirst("BSS_ENCRYPT:", "");
        System.out.println("come in ...");
		String value = super.resolvePlaceholder(strVal, props, systemPropertiesMode);
        System.out.println(value);
		logger.debug("敏感的加密属性数�?, 属�?�名�?:{},属�?��??:{}"
				+ new Object[] { strVal, value });

		try {
			return DESEncryptUtil.decrypt(value, getKey());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	return super.resolvePlaceholder(strVal, props, systemPropertiesMode);
}*/
	
	

	protected String resolvePlaceholder(String placeholder, Properties props) {
		
		if ((!StringUtil2.isEmpty(placeholder))&&(placeholder.startsWith("BSS_ENCRYPT."))) {
			logger.info(placeholder);
        String value=props.getProperty(placeholder);
			logger.debug("敏感的加密属性数据, 属性名称:{},属性值:{}"
					+ new Object[] { placeholder ,value});
			logger.info(value);
		
		try {
			value= DESEncryptUtil.decrypt(value, getKey());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return value;
	  }

		return props.getProperty(placeholder);

	}
	
	

}
