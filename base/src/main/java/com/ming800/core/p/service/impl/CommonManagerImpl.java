package com.ming800.core.p.service.impl;


import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.*;
import com.ming800.core.p.service.CommonManager;
import com.ming800.core.p.service.JmenuManager;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 * 公共文件  推荐  字典  轮播图
 */
@Service
public class CommonManagerImpl implements CommonManager {

    private static final String MENU_STANDARD = "/setting/common.xml";
    private static HashMap<String, CommonBanner> commonBannerMap;
    private static HashMap<String, CommonDocument> commonDocumentMap;
    private static HashMap<String, CommonRecommended> commonRecommendedMap;
    private static HashMap<String, CommonWordValue> commonWordValueMap;
   // private static int jmenuId = 1;

    private static void initCommon() throws Exception {
        commonRecommendedMap = new HashMap<>();
        commonBannerMap = new HashMap<>();
        commonDocumentMap = new HashMap<>();
        commonWordValueMap = new HashMap<>();
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        Logger logger = Logger.getLogger(CommonManagerImpl.class);
        Resource  xmlFiles = resolver.getResource(MENU_STANDARD);
        if (xmlFiles != null) {

                logger.info("开始解析文件：" + xmlFiles.getURL());
                getCommonByGroup(new SAXReader().read(xmlFiles.getInputStream()), commonRecommendedMap, "recommended");
                getCommonByGroup(new SAXReader().read(xmlFiles.getInputStream()),commonDocumentMap,"document");
                getCommonByGroup(new SAXReader().read(xmlFiles.getInputStream()),commonWordValueMap,"wordValue");
                getCommonByGroup(new SAXReader().read(xmlFiles.getInputStream()),commonBannerMap,"banner");

        }
    }




    /**
     * 解析推荐
     * @return
     */
    private  static  HashMap getCommonByGroup(Document infoDocument, HashMap map,String key){
       if(infoDocument!=null){
           //推荐
           if(key.equals("recommended")){
               List<Node> recommendNodeList = infoDocument.selectNodes("common/recommends/recommend");
               if(recommendNodeList!=null){
                   for(Node node : recommendNodeList){
                       String group = node.selectSingleNode("@group").getText();
                       String note = node.selectSingleNode("@note").getText();
                       String recommendedModel = node.selectSingleNode("@recommendedModel").getText();
                       String amount = node.selectSingleNode("@amount").getText();
                       CommonRecommended recommended = new CommonRecommended();
                       recommended.setGroup(group);
                       recommended.setNote(note);
                       recommended.setAmount(amount);
                       recommended.setRecommendedModel(recommendedModel);
                       map.put(group,recommended);
                   }
               }
           }
           if(key.equals("document")){
               List<Node> documentNodeList = infoDocument.selectNodes("common/recommends/document");
               //文档
               if(documentNodeList!=null){
                   for(Node node : documentNodeList){
                       String group = node.selectSingleNode("@group").getText();
                       String note = node.selectSingleNode("@note").getText();
                       String template = node.selectSingleNode("@template").getText();

                       CommonDocument document = new CommonDocument();
                       document.setGroup(group);
                       document.setNote(note);
                       document.setTemplate(template);
                       map.put(group, document);
                   }
               }
           }
           if(key.equals("wordValue")){
               List<Node> wordValueNodeList = infoDocument.selectNodes("common/recommends/wordValue");
               //字典
               if(wordValueNodeList!=null){
                   for(Node node : wordValueNodeList){
                       String group = node.selectSingleNode("@group").getText();
                       String note = node.selectSingleNode("@note").getText();


                       CommonWordValue wordValue = new CommonWordValue();
                       wordValue.setGroup(group);
                       wordValue.setNote(note);

                       map.put(group,wordValue);
                   }
               }
           }
           if(key.equals("banner")){
               List<Node> bannerNodeList = infoDocument.selectNodes("common/recommends/banner");   //轮播图
               if(bannerNodeList!=null){
                   for(Node node : bannerNodeList){
                       String group = node.selectSingleNode("@group").getText();
                       String note = node.selectSingleNode("@note").getText();
                       CommonBanner banner = new CommonBanner();
                       banner.setGroup(group);
                       banner.setNote(note);
                       map.put(group,banner);
                   }
               }
           }
       }
        return  map;

    }

    @Override
     public   CommonRecommended getRecommended(String group) throws Exception {
         CommonRecommended commonRecommended = null;
         commonRecommended = commonRecommendedMap.get(group);
         if (commonRecommended == null) {

             throw new Exception("commonRecommended is null");
         }
         return commonRecommended;
     }


}
