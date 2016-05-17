package com.efeiyi.ec.system.basic.controller;

import com.efeiyi.ec.wiki.model.Artistry;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.dom4j.*;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

/**
 * Created by Administrator on 2015/7/13.
 */
@Controller
public class ManageController {

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"main.do"})
    public String main() {
        return "/main";
    }

    @RequestMapping({"/fetchData.do"})
    @ResponseBody
    public String fetchData(final HttpServletRequest request) throws IOException, DocumentException {

        //拼写链接
        String urlstr = "http://baike.baidu.com/search/word?word=";
        String realPath = request.getServletContext().getRealPath("/");
        List<Artistry> artistryList = baseManager.listObject("from Artistry");
        //得到工艺的名称生成filePath 以及 urlstr
        for (Artistry artistry : artistryList) {
            try {
                String filepath = realPath + "files\\" + artistry.getName() + ".txt";
                String url = urlstr + URLEncoder.encode(artistry.getName(), "utf-8");
                getDataFunction(url, filepath);
            } catch (DocumentException e) {
                e.printStackTrace();
                System.out.println(artistry.getName());
                continue;
            }
        }
        return "";

    }

    @RequestMapping({"/test/fetchData.do"})
    @ResponseBody
    public String fetchData2(final HttpServletRequest request) throws IOException, DocumentException {

        //拼写链接
        String urlstr = "http://baike.baidu.com/search/word?word=%E8%8B%8F%E7%BB%A3";
        String realPath = request.getServletContext().getRealPath("/");
        String filepath = realPath + "files\\suxiu.txt";
        getDataFunction(urlstr, filepath);

        return "";

    }


    private void getDataFunction(String urlstr, String filePath) throws IOException, DocumentException {


        URL url = new URL(urlstr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestProperty("Accept-Charset", "utf-8");
        conn.setRequestProperty("contentType", "utf-8");
        conn.setConnectTimeout(5 * 1000);
        conn.setRequestMethod("GET");
        InputStream inStream = conn.getInputStream();

        BufferedReader in = new BufferedReader(new InputStreamReader(inStream, "utf-8"));
        StringBuffer buffer = new StringBuffer();
        String line;

        int i = 0;
        boolean scriptFlag = false;
        boolean zhushiFlag = false;
        while ((line = in.readLine()) != null) {
            if (line.contains("</div><script")) {
                System.out.println(line);
            }
            line = line.trim();


            //标签开始
            if (line.contains("<script")) {
                if (line.startsWith("<script")) {
                    if (line.endsWith("</script>")) {
                        scriptFlag = false;
                    } else {
                        scriptFlag = true;
                    }
                    continue;
                } else {
                    int index = line.indexOf("<script");
                    String newline = line.substring(0, index);
                    if (line.endsWith("</script>")) {
                        scriptFlag = false;
                    }
                    line = newline;
                }
            }
            //标签结束
            if (line.endsWith("</script>")) {
                scriptFlag = false;
                continue;
            }
            if (scriptFlag) {
                continue;
            }


            if (line.startsWith("<meta")) {
                continue;
            }

            if (line.startsWith("<!--") && line.endsWith("-->")) {
                zhushiFlag = false;
            }
            if (line.startsWith("<!--")) {
                zhushiFlag = true;
            }
            if (line.contains("<!--")) {
                int index = line.indexOf("<!--");
                String newline = line.substring(0, index);
                if (line.endsWith("-->")) {
                    zhushiFlag = false;
                }
                line = newline;
            }
            if (line.endsWith("-->")) {
                zhushiFlag = false;
                continue;
            }
            if (zhushiFlag) {
                continue;
            }

            if (i != 0) {
                buffer.append(line + "\n");
            }
            ++i;
        }
        String str = buffer.toString();
        String regex = "<img([\\s\\S]*?)>";

//        String testString = "-----<img src=\"jaljsfakldjsflk;ajdlf\" name=\"akljsdklf\">-----<img src=\"jaljsfakldjsflk;ajdlf\" name=\"akljsdklf\">---";
//        String testString2 = "-----<img src=\"jaljsfakldjsflk;ajdlf\" name=\"akljsdklf\"/>-----";
//        testString = testString.replaceAll(regex, "");
//        testString2 = testString2.replaceAll(regex, "");
//        System.out.println(testString);
//        System.out.println(testString2);
//        String regex1 = "^<img.*>$";
        str = str.replaceAll(regex, "");
        str = str.replaceAll("&", "");
        str = str.replaceAll("target=_blank ", "");
//        System.out.println(str);

        //1.首先需要判断是不是我想要的页面，是列表页面或者详情页面  我们要的是详情页面
        //2.去掉没用的元素，导航页尾，推荐按钮等元素 （搜集html标签的class属性来判别内容，需要根据网页实际代码整理一下）
        //3.去掉所有a标签（可以使用java的正则表达式，编辑的按钮）
        //先把数据存到文件里再用domj4读取，先做一下筛选

//        String realPath = request.getServletContext().getRealPath("/");
//        String filePath = realPath + "files\\suxiu.xml";
        File file = new File(filePath);
        if (!file.exists()) {
            file.createNewFile();
        }
        OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(file), "UTF-8");
        BufferedWriter writer = new BufferedWriter(write);
        writer.write(str);
        writer.close();
        write.close();
        Node bodyWrapperNode = null;
        Node contentWrapperNode = null;
        Node contentNode = null;
        Node mainContentNode = null;
        Document document = null;
        try {
            document = new SAXReader().read(new FileInputStream(file));
        } catch (DocumentException e) {
            file.delete();
            throw e;
        }
        List<Node> nodes = document.selectNodes("/html/body/div");
        for (Node node : nodes) {
            String clazz0 = node.selectSingleNode("@class").getText();
            if (clazz0.equals("body-wrapper")) {
                bodyWrapperNode = node;
                break;
            }
        }
        if (bodyWrapperNode != null) {
            List<Node> subBodyWrapperNodeList = bodyWrapperNode.selectNodes("div");
            for (Node nodeTemp : subBodyWrapperNodeList) {
                String clazz1 = nodeTemp.selectSingleNode("@class").getText();
                if (clazz1.equals("content-wrapper")) {
                    contentWrapperNode = nodeTemp;
                    break;
                }
            }
            if (contentWrapperNode != null) {
                List<Node> subContentWrapperNodeList = contentWrapperNode.selectNodes("div");
                for (Node nodeTemp2 : subContentWrapperNodeList) {
                    String clazz2 = nodeTemp2.selectSingleNode("@class").getText();
                    if (clazz2.equals("content")) {
                        contentNode = nodeTemp2;
                    }
                }
                if (contentNode != null) {
                    List<Node> subContentNodeList = contentNode.selectNodes("div");
                    for (Node node : subContentNodeList) {
                        String clazz = node.selectSingleNode("@class").getText();
                        if (clazz.equals("main-content")) {
                            mainContentNode = node;
                        }
                    }
                }
            }
        }
//        ((Element) (mainContentNode.selectNodes("div").get(0))).elementIterator().remove();
        removeContentHead((Element) mainContentNode);
        removeEditElement((Element) mainContentNode);
        removeImgeElement((Element) mainContentNode);
        String test = mainContentNode.getStringValue();
//        System.out.println(test);
//        test = test.replaceAll("/n", "");

        if (!file.exists()) {
            file.createNewFile();
        }
        OutputStreamWriter write2 = new OutputStreamWriter(new FileOutputStream(file), "UTF-8");
        BufferedWriter writer2 = new BufferedWriter(write2);
        writer2.write(test);
        writer2.close();
        write2.close();
    }

    //去掉所有img标签
    public void removeImgeElement(Element rootNode) {
        Iterator iterator = rootNode.elementIterator();
        while (iterator.hasNext()) {
            Element elementTemp = (Element) iterator.next();
            Iterator iteratorTemp = elementTemp.elementIterator();
            if (iteratorTemp.hasNext()) {
                removeImgeElement(elementTemp);
            } else if (elementTemp.getName().equals("img")) {
                iterator.remove();
            }
        }
    }

    public void removeContentHead(Element rootNode) {
        Iterator iterator = rootNode.elementIterator();
        while (iterator.hasNext()) {
            Object o = iterator.next();
            iterator.remove();
            break;
        }
    }

    public void removeEditElement(Element rootNode) {
        Iterator iterator = rootNode.elementIterator();
        int i = 0;
        while (iterator.hasNext()) {
            Element node = (Element) iterator.next();
            String divClazz = (node.selectSingleNode("@class") != null ? node.selectSingleNode("@class").getText() : "");
            if (divClazz.equals("para-title level-2")) {
                Iterator subIterator = node.elementIterator();
                while (subIterator.hasNext()) {
                    Element nodeTemp = (Element) subIterator.next();
                    if (nodeTemp.getName().equals("a")) {
                        node.remove(nodeTemp);
                        ++i;
                    }
                }
            }
        }
    }


}
