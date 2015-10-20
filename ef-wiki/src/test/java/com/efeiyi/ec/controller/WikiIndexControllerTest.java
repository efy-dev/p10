package com.efeiyi.ec.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.impl.BaseManagerImpl;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.impl.AutoSerialManagerImpl;
import org.apache.log4j.Logger;
import org.junit.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Administrator on 2015/7/31.
 *
 */

@Controller
public class WikiIndexControllerTest {
    private static Logger logger = Logger.getLogger(WikiIndexControllerTest.class);
    MockHttpServletRequest request;
    MockHttpServletResponse response;
    //ModelAndView mv ;
    @Autowired
    BaseManager baseManager;
    @Autowired
    AutoSerialManager autoSerialManager;
    @BeforeClass
    public static void setUpBeforeClass() throws Exception {

    }
    @Before
    public void init() {
         logger.info("init spring context begin............");
	/*   ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
         ApplicationContext applicationContext = new FileSystemXmlApplicationContext(new String[]{
                "src/main/webapp//WEB-INF/applicationContext-*.xml",
                "src/main/webapp//WEB-INF/spring-servlet.xml"});*/

        ApplicationContext applicationContext = new ClassPathXmlApplicationContext(new String[]{
                "classpath*:applicationContext-dao.xml",
                "classpath*:config/applicationContext-*.xml",
                "classpath*:spring-servlet.xml"
                });
         logger.info("init spring context end.............");
        //ModelMap map = new ModelMap();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
        request.setCharacterEncoding("UTF-8");
        baseManager=(BaseManagerImpl)applicationContext.getBean("baseManagerImpl");
        autoSerialManager=(AutoSerialManagerImpl)applicationContext.getBean("autoSerialManagerImpl");
    }

    @After
    public  void setUpAfter() throws Exception {

    }

    @AfterClass
    public static void setUpAfterClass() throws Exception {

    }

    @Test
    public void demo2()throws  Exception{
        for (int i=0 ;1<=1000;i++){
           System.out.println(autoSerialManager.nextSerial("product"));
        }


    }
}
