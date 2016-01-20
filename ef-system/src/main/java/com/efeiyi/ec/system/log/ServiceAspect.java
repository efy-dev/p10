package com.efeiyi.ec.system.log;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.system.log.service.LogManager;
import com.ming800.core.does.model.Do;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.logicalcobwebs.logging.Log;
import org.logicalcobwebs.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.ParseException;

/**
 * Created by Administrator on 2015/10/30.
 */
@Component
@Aspect
public class ServiceAspect {


    @Autowired
    private LogManager logManager;

    @Pointcut("execution(* com.ming800.core.base..*.delete*(..))||execution(* com.ming800.core.base..*.remove*(..))||execution(* com.ming800.core.base..*.saveOrUpdate*(..))")
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
//    @After("aspect()")
//    public void after(JoinPoint joinPoint){
//        if(log.isInfoEnabled()){
//            log.info("after " + joinPoint);
//        }
//    }

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
        String operation  =joinPoint.getSignature().getName();
            String targetName = joinPoint.getArgs()[joinPoint.getArgs().length-1].toString();
            String detail = "0";
//            for(int i =0;i<joinPoint.getArgs().length;i++){
//                Object o = joinPoint.getArgs()[i];
//                System.out.println(o.toString());
//            }
//            String targetName = t;
            if (targetName != null) {
//                if (t.indexOf("Do@") != -1) {
//                    Do tempDo = (Do) joinPoint.getArgs()[0];
//                    t = tempDo.getXentity().getModel();
//                }
//                    if(t.indexOf("@")==-1){
//                        targetName = t.substring(t.lastIndexOf(".")+1);
//                    }else {
//                        targetName = t.substring(t.lastIndexOf(".") + 1, t.indexOf("@"));
//                }
                try {
                    logManager.saveLog(targetName,operation);
                }catch (ParseException pe){
                      pe.printStackTrace();
                }

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
