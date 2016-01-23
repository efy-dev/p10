package com.efeiyi.ec.art.filter;

/**
 * Created by Administrator on 2015/11/2.
 *
 */



        import java.io.IOException;

        import javax.servlet.FilterChain;
        import javax.servlet.ServletException;
        import javax.servlet.http.HttpServletRequest;
        import javax.servlet.http.HttpServletResponse;
        import org.springframework.web.filter.OncePerRequestFilter;


/**
 * 登录过滤器
 * <功能详细描述>
 *
 * @author  chenlujun
 * @version  [版本号, 2014年10月11日]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
public class SessionFilter extends OncePerRequestFilter
{

    /** 登录验证过滤器 */

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException
    {

        boolean doFilter = isAjaxRequest(request);

        if (doFilter)
        {       response.setHeader("Access-Control-Allow-Origin", "*");
                boolean isAjaxRequest = isAjaxRequest(request);
                if (isAjaxRequest)
                {
                    response.setCharacterEncoding("UTF-8");
                    response.setHeader("Access-Control-Allow-Origin", "*");
                }

        }

            // 如果不执行过滤，则继续
            filterChain.doFilter(request, response);


    }

    /** 判断是否为Ajax请求
     * <功能详细描述>
     * @param request
     * @return 是true, 否false
     * @see [类、类#方法、类#成员]
     */
    public static boolean isAjaxRequest(HttpServletRequest request)
    {
        String header = request.getHeader("X-Requested-With");
        if (header != null && "XMLHttpRequest".equals(header))
            return true;
        else
            return false;
    }

}
