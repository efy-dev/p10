package com.efeiyi.ec.wiki.interceptor;

import org.apache.log4j.Logger;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

/**
 * Created by Administrator on 2015/11/24.
 *
 */
@Aspect
public class CacheServiceInterceptor {

    private static Logger logger = Logger.getLogger(CacheServiceInterceptor.class);
    /**
     * 定义pointcunt
     *
     */
    @Pointcut("execution(* com.ming800.core.base.service.impl.*.*(..))")
    public void aPointcut() {

    }
    /**
     * 环绕装备 用于拦截查询 如果缓存中有数据，直接从缓存中读取；否则从数据库读取并将结果放入缓存
     *
     * @param call
     * @param Id
     * @return
     */
   /* @Around("aPointcut()&&args(Id)")
    public MyUser doFindUserByNameAround(ProceedingJoinPoint call, String Id) {
        MyUser users = null;
        if (memcachedCache.getCache().containsKey("findUserByName_" + Id)) {
            users = (MyUser) memcachedCache.get("findUserByName_" + Id);
            logger.debug("从缓存中读取！findUserByName_" + Id);
        } else {
            try {
                users = (MyUser) call.proceed();
                if (users != null) {
                    memcachedCache.put("findUserByName_" + Id, users);
                    logger.debug("缓存装备被执行：findUserByName_" + Id);
                }
            } catch (Throwable e) {
                e.printStackTrace();
            }
        }
        return users;
    }
*/
}
