package com.ming800.core.base.controller;


import com.ming800.core.base.model.Banner;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.junit.AfterClass;
import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import javax.annotation.Resource;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;


/**
 * Created by Administrator on 2015/7/14.
 */
/*
 *
 * @BeforeClass –> @Before –> @Test –> @After –> @AfterClass
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp//WEB-INF/applicationContext-*.xml"
,"file:src/main/webapp//WEB-INF/spring-servlet.xml"})
@Controller
public class BannerControllerTest {
    private static Logger logger = Logger.getLogger(BannerController.class);



   //HttpServletRequest request;
   MockHttpServletRequest request =null;

    @Autowired
    private BaseManager baseManager;

    @BeforeClass
    public static void setUpBeforeClass() throws Exception {

    }
    @Before
    public void init() {
          //logger.info("加载spring配置开始 ............");
	      /* ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml"); */
         //service = (CatalogGqRepository) ctx.getBean("cataGqRepository");
         //logger.info("加载spring配置结束.............");
        request = new MockHttpServletRequest();
    }
    @Test
    public void testdemo1() {

        List<Banner> banners = null;
        XQuery xQuery = null;
        try {
            xQuery = new XQuery("listPCBanner_default",request);
        } catch (Exception e) {
            logger.error("create xQuery error in BannerController.getBannerByModlueId()...");
            e.printStackTrace();
        }
        banners = baseManager.listObject(xQuery);
        if (banners==null || banners.size()<=0){
            logger.info("no banners be found,plase confirm again!");

        }else{
           /* banners.parallelStream()
                    .sorted((a, b) -> a.getBannerOrder() > b.getBannerOrder())
                    .forEach(e -> System.out::println);*/
            for(Banner banner:banners){
                System.out.println(banner.getImageUrl());
            }
        }
    }



    @After
    public  void setUpAfter() throws Exception {

    }

    @AfterClass
    public static void setUpAfterClass() throws Exception {

    }


}
