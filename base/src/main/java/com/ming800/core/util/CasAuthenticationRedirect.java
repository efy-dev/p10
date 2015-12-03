package com.ming800.core.util;

import com.ming800.core.util.HttpUtil;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

/**
 * Created by Administrator on 2015/11/4.
 */
public class CasAuthenticationRedirect extends org.springframework.security.cas.web.CasAuthenticationEntryPoint {
    private String serviceUrlBak = null;


    @Override

    protected String createServiceUrl(final HttpServletRequest request, final HttpServletResponse response) {


        if (serviceUrlBak == null)


            serviceUrlBak = getServiceProperties().getService();


        if (serviceUrlBak != null) {
            String ctx = request.getContextPath();
            String queryString = request.getQueryString();
            String requestURI = request.getRequestURI();
            requestURI = requestURI.substring(requestURI.indexOf(ctx) + ctx.length(), requestURI.length());
            String serviceUrl = "";
            if (!requestURI.equals("/") && requestURI.length() > 0) {
                //serviceUrl="?"+ new SimpleUrlAuthenticationSuccessHandler().getTargetUrlParameter();
                serviceUrl = "?callUrl";
                serviceUrl += "=" +request.getServerName()+":"+request.getServerPort()+ requestURI;
                if (StringUtils.isNotBlank(queryString)) {
                    serviceUrl += "?" + queryString;
                }
            }
            getServiceProperties().setService(serviceUrlBak + serviceUrl);
        }


        return super.createServiceUrl(request, response);
    }

}
