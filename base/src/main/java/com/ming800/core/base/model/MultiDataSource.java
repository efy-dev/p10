package com.ming800.core.base.model;

import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import javax.sql.DataSource;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.util.logging.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-12-11
 * Time: 下午3:10
 * To change this template use File | Settings | File Templates.
 */
public class MultiDataSource implements DataSource, ApplicationContextAware {

    private DataSource dataSource = null;
    private ApplicationContext applicationContext = null;


    public Connection getConnection() throws SQLException {
        // TODO Auto-generated method stub
        return getDateSource().getConnection();
    }

    public Connection getConnection(String arg0, String arg1) throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }

    public PrintWriter getLogWriter() throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }

    public int getLoginTimeout() throws SQLException {
        // TODO Auto-generated method stub
        return 0;
    }

    public void setLogWriter(PrintWriter arg0) throws SQLException {
        // TODO Auto-generated method stub
    }

    public void setLoginTimeout(int arg0) throws SQLException {
        // TODO Auto-generated method stub
    }

    public ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    public void setApplicationContext(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }

    public DataSource getDateSource(String dataSourceName) {
//        System.out.println("线程进来2");
        /*可以在这里获取   根据branch   获取多数据源*/

        try {
            if (dataSourceName == null || dataSourceName.equals("")) {
//                System.out.println("线程进来3");
                return this.dataSource;
            }
//            System.out.println("线程进来4");
            return (DataSource) this.applicationContext.getBean(dataSourceName);
            //根据 dataSourceName加载配置文件中的数据源对象
        } catch (NoSuchBeanDefinitionException ex) {
//            System.out.println("线程进来5");
            return this.dataSource;
        }
    }

    public void setDateSource(DataSource dateSource) {
//        System.out.println("dataSource方法");
        this.dataSource = dateSource;
    }

    /**
     * 项目启动时，默认使用defaultDataSource
     * 用户选择时，根据选择数据源
     * ThreadLocal在单例下生成多个线程变量副本，解决多用户并发访问
     */
    public DataSource getDateSource() {
//        System.out.println("线程进来1");
        String sp = SpObserver.getSp();
        return this.getDateSource(sp);
    }


    @Override
    public Logger getParentLogger() throws SQLFeatureNotSupportedException {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public <T> T unwrap(Class<T> iface) throws SQLException {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public boolean isWrapperFor(Class<?> iface) throws SQLException {
        return false;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
