package com.ming800.core.base.controller;


import com.ming800.core.p.controller.BannerController;
import com.ming800.core.p.controller.DocumentController;
import com.ming800.core.p.controller.TagController;
import com.ming800.core.p.model.Banner;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.util.DESEncryptUtil;
import org.apache.log4j.Logger;
import org.junit.AfterClass;
import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import javax.annotation.Resource;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;

import java.util.List;


/**
 * Created by kayson on 2015/7/14.
 *
 *
 */

@SuppressWarnings("unchecked")
//@Transactional
//@TransactionConfiguration(transactionManager ="transactionManager", defaultRollback = true)
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations={"file:src/main/webapp//WEB-INF/applicationContext-*.xml","file:src/main/webapp//WEB-INF/spring-servlet.xml"})
@Controller
public class BannerControllerTest {
    private static Logger logger = Logger.getLogger(BannerControllerTest.class);

    // 加载顺序 @BeforeClass –> @Before –> @Test –> @After –> @AfterClass

   //HttpServletRequest request;
     MockHttpServletRequest request;
     MockHttpServletResponse response;
    // ModelAndView mv ;
     @Resource
     BannerController bannerController;
     @Resource
     DocumentController documentController;

    @Resource
    TagController wordValueController;

     ModelMap  map ;
     @Autowired
     private BaseManager baseManager;

     @BeforeClass
     public static void setUpBeforeClass() throws Exception {

     }
    @SuppressWarnings("SuppressWarnings")
    @Before
    public void init() {
         /* logger.info("加载spring配置开始 ............");
	      *//* ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml"); *//*
        */
       /* ApplicationContext applicationContext = new FileSystemXmlApplicationContext(new String[]{
                "src/main/webapp//WEB-INF/applicationContext-*.xml",
                "src/main/webapp//WEB-INF/spring-servlet.xml"});*/
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext(new String[]{
                "classpath*:config/applicationContext-*.xml",
                "WEB-INF/applicationContext-*.xml",
                "WEB-INF/spring-servlet.xml"});
         logger.info("加载spring配置结束.............");
        map = new ModelMap();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
        request.setCharacterEncoding("UTF-8");
        //bannerController = new BannerController();
       // baseManager=(BaseManagerImpl)applicationContext.getBean("baseManagerImpl");
        bannerController = (BannerController)applicationContext.getBean("bannerController");
        documentController = (DocumentController)applicationContext.getBean("documentController");


        //wordValueController = (WordValueController)applicationContext.getBean("wordValueController");*/
    }
    @Test
    public void demo1() {

        List<Banner> banners;
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
    public void demo2()throws  Exception{

        bannerController.getBannerByGroupId(request);
       /* Assert.assertNotNull(mv);
        Assert.assertEquals(response.getStatus(), 200);*/
    }
    @Test
    public void demo3()throws  Exception{

        documentController.getDocByGroupId(request);

    }
    @After
    public  void setUpAfter() throws Exception {

    }

    @AfterClass
    public static void setUpAfterClass() throws Exception {

    }
    @Test
    public  void test() throws Exception {
        String key = "i am key,let me encrypt you! 1234haha";
        String src = "efyadmin123";

        System.out.println("密钥:" + key);
        System.out.println("明文:" + src);

        String strEnc = DESEncryptUtil.encrypt(src, key);
        System.out.println("加密�?,密文:" + strEnc);

        String strDes = DESEncryptUtil.decrypt(strEnc, key);
        System.out.println("解密�?,明文:" + strDes);

    }

    @Test
    public void demoZZC(){
//        wordValueController.test();
    }

}
