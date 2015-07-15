package com.ming800.core.base.controller;


import com.ming800.core.base.service.impl.BaseManagerImpl;
import com.ming800.core.p.controller.BannerController;
import com.ming800.core.p.controller.DocumentController;
import com.ming800.core.p.model.Banner;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.DocumentAttachment;
import com.ming800.core.p.model.DocumentContent;
import junit.framework.Assert;
import org.apache.log4j.Logger;
import org.junit.AfterClass;
import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import javax.annotation.Resource;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


/**
 * Created by Administrator on 2015/7/14.
 */
/*
 *
 * @BeforeClass –> @Before –> @Test –> @After –> @AfterClass
 */
@SuppressWarnings("unchecked")
//@Transactional
//@TransactionConfiguration(transactionManager ="transactionManager", defaultRollback = true)
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations={"file:src/main/webapp//WEB-INF/applicationContext-*.xml","file:src/main/webapp//WEB-INF/spring-servlet.xml"})
@Controller
public class BannerControllerTest {
    private static Logger logger = Logger.getLogger(BannerController.class);



   //HttpServletRequest request;
     MockHttpServletRequest request;
     MockHttpServletResponse response;
     ModelAndView mv ;
     @Resource
     BannerController bannerController;
    @Resource
    DocumentController documentController;
     ModelMap  map ;
    @Autowired
    private BaseManager baseManager;

    @BeforeClass
    public static void setUpBeforeClass() throws Exception {

    }
    @Before
    public void init() {
          //logger.info("加载spring配置开始 ............");
	      /* ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml"); */
        ApplicationContext applicationContext = new FileSystemXmlApplicationContext(new String[]{"src/main/webapp//WEB-INF/applicationContext-*.xml",
                "src/main/webapp//WEB-INF/spring-servlet.xml"});
         //logger.info("加载spring配置结束.............");
        map = new ModelMap();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
        request.setCharacterEncoding("UTF-8");
        //bannerController = new BannerController();
        baseManager=(BaseManagerImpl)applicationContext.getBean("baseManagerImpl");
        bannerController = (BannerController)applicationContext.getBean("bannerController");
        documentController = (DocumentController)applicationContext.getBean("documentController");
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

    @Test
    public void testdemo2()throws  Exception{

        mv =bannerController.getBannerByModlueId(map, request);
       /* Assert.assertNotNull(mv);
        Assert.assertEquals(response.getStatus(), 200);*/
    }
    @Test
    public void testdemo3()throws  Exception{

        documentController.getDocById(map,request);

    }
    @After
    public  void setUpAfter() throws Exception {

    }

    @AfterClass
    public static void setUpAfterClass() throws Exception {

    }


}
