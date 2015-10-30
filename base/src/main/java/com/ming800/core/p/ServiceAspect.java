package com.ming800.core.p;

import com.ming800.core.does.model.Do;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.logicalcobwebs.logging.Log;
import org.logicalcobwebs.logging.LogFactory;
import org.springframework.stereotype.Component;

/**
 * Created by Administrator on 2015/10/30.
 */
@Component
@Aspect
public class ServiceAspect {
    private final static Log log = LogFactory.getLog(ServiceAspect.class);

    @Pointcut("execution(* com.ming800.core.base..*.delete*(..))||execution(* com.ming800.core.base..*.remove*(..))||execution(* com.ming800.core.base..*.save*(..))")
    public  void  aspect(){}
    /*
	 * 配置前置通知,使用在方法aspect()上注册的切入点
	 * 同时接受JoinPoint切入点对象,可以没有该参数
	 */
//    @Before("aspect()")
//    public void before(JoinPoint joinPoint){
//        if(log.isInfoEnabled()){
//            log.info("before " + joinPoint);
//        }
//    }

    //配置后置通知,使用在方法aspect()上注册的切入点
    @After("aspect()")
    public void after(JoinPoint joinPoint){

        for (int i = 0;i<joinPoint.getArgs().length;i++) {
            String t = joinPoint.getArgs()[i].toString();
            if (t != null) {
                if (t.indexOf("Do@") != -1) {
                    Do tempDo = (Do) joinPoint.getArgs()[i];
                    System.out.println(tempDo.getName());
                    System.out.println(tempDo.getXentity().getModel());
                }
                System.out.println(joinPoint.getArgs()[i]);
            }
        }
        if(log.isInfoEnabled()){
            log.info("after " + joinPoint);
        }
    }

//    //配置环绕通知,使用在方法aspect()上注册的切入点
//    @Around("aspect()")
//    public void around(JoinPoint joinPoint){
//        long start = System.currentTimeMillis();
//        try {
//            ((ProceedingJoinPoint) joinPoint).proceed();
//            long end = System.currentTimeMillis();
//            if(log.isInfoEnabled()){
//                log.info("around " + joinPoint + "\tUse time : " + (end - start) + " ms!");
//            }
//        } catch (Throwable e) {
//            long end = System.currentTimeMillis();
//            if(log.isInfoEnabled()){
//                log.info("around " + joinPoint + "\tUse time : " + (end - start) + " ms with exception : " + e.getMessage());
//            }
//        }
//    }

    //配置后置返回通知,使用在方法aspect()上注册的切入点
    @AfterReturning("aspect()")
    public void afterReturn(JoinPoint joinPoint){
        if(log.isInfoEnabled()){
            log.info("afterReturn " + joinPoint);
        }
    }

//    //配置抛出异常后通知,使用在方法aspect()上注册的切入点
//    @AfterThrowing(pointcut="aspect()", throwing="ex")
//    public void afterThrow(JoinPoint joinPoint, Exception ex){
//        if(log.isInfoEnabled()){
//            log.info("afterThrow " + joinPoint + "\t" + ex.getMessage());
//        }
//    }
}
