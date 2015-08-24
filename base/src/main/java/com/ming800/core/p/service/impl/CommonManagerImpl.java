package com.ming800.core.p.service.impl;


import com.ming800.core.p.model.*;
import com.ming800.core.p.service.CommonManager;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.stereotype.Service;
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
    private static HashMap<String, CommonBanner>  commonBannerMap = new HashMap<>();
    private static HashMap<String, CommonDocument> commonDocumentMap = new HashMap<>();
    private static HashMap<String, CommonRecommended>  commonRecommendedMap = new HashMap<>();
    private static HashMap<String, CommonTag>    commonTagMap = new HashMap<>();
    private static HashMap<String, CommonSerial> autoSerialMap = new HashMap<>();
   // private static int jmenuId = 1;

    private static void initCommon() throws Exception {
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        Logger logger = Logger.getLogger(CommonManagerImpl.class);
        Resource  xmlFiles = resolver.getResource(MENU_STANDARD);
        try {
            logger.info("开始解析文件：" + xmlFiles.getURL());
            if (xmlFiles != null) {
                getCommonBannerByGroup(new SAXReader().read(xmlFiles.getInputStream()));
                getCommonDocumentByGroup(new SAXReader().read(xmlFiles.getInputStream()));
                getCommonRecommendedByGroup(new SAXReader().read(xmlFiles.getInputStream()));
                getCommonTagByGroup(new SAXReader().read(xmlFiles.getInputStream()));
                getAutoSerialByGroup(new SAXReader().read(xmlFiles.getInputStream()));
            }
        }catch (Exception e){
             // e.printStackTrace();
            System.out.println("if you do not use the file '/setting/common.xml',please ignore this message!");
        }


    }

    /**
     * 解析轮播图
     * @param infoDocument
     * @return
     */
    private  static  HashMap getCommonBannerByGroup(Document infoDocument) {
        List<Node> bannerNodeList = infoDocument.selectNodes("common/banners/banner");   //轮播图
        if(bannerNodeList!=null){
            for(Node node : bannerNodeList){
                String group = node.selectSingleNode("@group").getText();
                String note = node.selectSingleNode("@note").getText();
                CommonBanner banner = new CommonBanner();
                banner.setGroup(group);
                banner.setNote(note);
                commonBannerMap.put(group,banner);
            }
        }
        return  commonBannerMap;
    }

    /**
     * 解析文档
     * @param infoDocument
     * @return
     */
    private  static  HashMap getCommonDocumentByGroup(Document infoDocument) {
        List<Node> documentNodeList = infoDocument.selectNodes("common/documents/document");
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
                commonDocumentMap.put(group, document);
            }
        }
        return  commonDocumentMap;
    }

    /**
     * 解析字典
     * @param infoDocument
     * @return
     */
    private  static  HashMap getCommonTagByGroup(Document infoDocument) {
        List<Node> wordValueNodeList = infoDocument.selectNodes("common/tags/tag");
        //字典
        if(wordValueNodeList!=null){
            for(Node node : wordValueNodeList){
                String group = node.selectSingleNode("@group").getText();
                String note = node.selectSingleNode("@note").getText();
                CommonTag wordValue = new CommonTag();
                wordValue.setGroup(group);
                wordValue.setNote(note);

                commonTagMap.put(group,wordValue);
            }
        }
        return  commonTagMap;
    }


    /**
     * 解析推荐
     * @return
     */
    private  static  HashMap getCommonRecommendedByGroup(Document infoDocument){
       if(infoDocument!=null){
           //推荐
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
                       commonRecommendedMap.put(group,recommended);
                   }
               }
           }
        return  commonRecommendedMap;

    }

    /**
     * 解析自动获取序列号
     * @param  infoDocument is a Document
     * @return autoSerialMap
     */
    private  static  HashMap getAutoSerialByGroup(Document infoDocument){
        if(infoDocument!=null){
            //begin
            List<Node> autoSerialNodeList = infoDocument.selectNodes("common/autoserials/autoserial");
            if(autoSerialNodeList!=null){
                for(Node node : autoSerialNodeList){
                    String group = node.selectSingleNode("@group").getText();
                    String note = node.selectSingleNode("@note").getText();
                    String autoserialModel = node.selectSingleNode("@autoserialModel").getText();
                    String prefix = node.selectSingleNode("@prefix").getText();
                    String length = node.selectSingleNode("@length").getText();
                    String cacheSize = node.selectSingleNode("@cacheSize").getText();
                    String step = node.selectSingleNode("@step").getText();
                    CommonSerial commonSerial = new CommonSerial();
                    commonSerial.setGroup(group);
                    commonSerial.setNote(note);
                    commonSerial.setAutoserialModel(autoserialModel);
                    commonSerial.setCacheSize(cacheSize);
                    commonSerial.setLength(length);
                    commonSerial.setStep(step);
                    autoSerialMap.put(group,commonSerial);
                }
            }
        }
        return  autoSerialMap;

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

    @Override
    public CommonTag getTag(String group) throws  Exception{
        CommonTag commonTag = null;
        commonTag = commonTagMap.get(group);
        if(commonTag == null){
             throw  new Exception("commonTag is null");
        }
        return  commonTag;
    }

    public CommonDocument getDocument(String group) throws  Exception{
        CommonDocument commonDocument = null;
        commonDocument = commonDocumentMap.get(group);
        if(commonDocument == null){
            throw  new Exception("commonDocument is null");
        }
        return  commonDocument;
    }

    public CommonBanner getBanner(String group) throws  Exception{
        CommonBanner commonBanner = null;
        commonBanner = commonBannerMap.get(group);
        if(commonBanner == null){
            throw  new Exception("commonBanner is null");
        }
        return  commonBanner;
    }

    @Override
    public CommonSerial getAutoSerial(String group) throws  Exception{
        CommonSerial conmmonSerial = autoSerialMap.get(group);
        if(conmmonSerial == null){
            throw  new Exception("conmmonSerial is null");
        }
        return  conmmonSerial;
    }

}
