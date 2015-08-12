package com.efeiyi.service;

import com.efeiyi.PalConst;
import com.efeiyi.ResultBean;
import com.efeiyi.pal.check.model.LabelCheckRecord;
import com.efeiyi.pal.label.model.Label;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import org.apache.commons.beanutils.BeanUtils;
import org.dom4j.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/8/7.
 */
@Transactional
@Component
public class LabelCheckManagerImpl extends HibernateDaoSupport implements ILabelCheckManager {

    @Autowired
    BaseManager baseManager;

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Resource
    public void setSessionFactory0(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    public Label getUniqueLabel(String labelId) {

        LinkedHashMap<String, Object> qryLabParaMap = new LinkedHashMap<>();
        qryLabParaMap.put(PalConst.getInstance().checkLabelParam1, labelId);
        return (Label) baseManager.getUniqueObjectByConditions(PalConst.getInstance().checkLabel, qryLabParaMap);
    }


    /**
     * 更新标签状态和查询记录
     * @param model
     * @param label
     * @return
     * @throws Exception
     */
    public ModelMap updateRecord(ModelMap model, Label label) throws Exception {

        Date date = new Date();
        label.setCheckCount(label.getCheckCount() + 1);
        //如果首次查
        if (label.getStatus().equals(PalConst.getInstance().unusedStatus)) {

            //更新码状态
            label.setStatus(PalConst.getInstance().usedStatus);
            label.setFirstCheckDateTime(date);
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().trueBean);
            getSession().saveOrUpdate(label.getClass().getName(), label);
        }
        //如果非首次查
        else if (label.getStatus().equals(PalConst.getInstance().usedStatus)) {

            Long timeDiffer = date.getTime() - label.getFirstCheckDateTime().getTime();

            //只有24小时内查询次数为2才显示真
            if (timeDiffer < PalConst.getInstance().timeIncrement && label.getCheckCount() == 2) {
                ResultBean recheckTrueBean = new ResultBean();
                BeanUtils.copyProperties(recheckTrueBean, PalConst.getInstance().recheckTrueBean);
                String msg = PalConst.getInstance().recheckTrueBean.getMsg();
                msg = msg.replaceAll("#N#", Integer.toString(label.getCheckCount())).replaceAll("#TIME#", label.getLastCheckDateTime().toString());
                recheckTrueBean.setMsg(msg);
                model.addAttribute(PalConst.getInstance().resultLabel, recheckTrueBean);
            }
            //否则一律不显示真伪
            else {
                ResultBean recheckFakeBean = new ResultBean();
                BeanUtils.copyProperties(recheckFakeBean, PalConst.getInstance().recheckFakeBean);
                String msg = PalConst.getInstance().recheckFakeBean.getMsg();
                msg = msg.replaceAll("#N#", Integer.toString(label.getCheckCount())).replaceAll("#TIME#", label.getLastCheckDateTime().toString());
                recheckFakeBean.setMsg(msg);
                recheckFakeBean.setAuthenticity(PalConst.getInstance()._null);
                model.addAttribute(PalConst.getInstance().resultLabel, recheckFakeBean);
            }

            label.setLastCheckDateTime(date);

        }
        //如果其他状态码无效
        else {
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }


        //插入一条查询记录
        LabelCheckRecord checkRecord = new LabelCheckRecord();
        checkRecord.setCreateDatetime(date);
        checkRecord.setIP((String) model.get(PalConst.getInstance().ip));
        checkRecord.setLabel(label);
        checkRecord.setProduct(label.getProduct());
        getSession().saveOrUpdate(checkRecord.getClass().getName(), checkRecord);
        model.addAttribute(PalConst.getInstance().resultProduct, label.getProduct());
        getSession().flush();
        return model;
    }

    /**
     *处理微信服务器发来的报文
     * @param request
     * @param inXml
     * @return
     * @throws IOException
     */
    @Override
    public String treatWeiXinMsg(HttpServletRequest request,String inXml) throws IOException {
        Document document = null;
        try {
            document = DocumentHelper.parseText(inXml);
        } catch (DocumentException e) {
            e.printStackTrace();
            throw new IOException(e.getMessage());
        }
        Element root = document.getRootElement();
        String serial = root.element("EventKey").getText();
        String event = root.element("Event").getText();
        System.out.println("Event=\'" + event + "\'");
        String outXml = "";

        if (PalConst.getInstance().weiXinSubscribeEvent.equals(event)) {
            serial = serial.substring(8).trim();
        } else if (!PalConst.getInstance().weiXinScanEvent.equals(event)) {
            return "";
        }

        System.out.println("serial=\'" + serial + "\'");

        Label label = getUniqueLabel(serial);
        String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/checkLabel.do?serial=" + serial;
        String toUserName = root.element("ToUserName").getText();
        String fromUserName = root.element("FromUserName").getText();


        if (label != null) {
            String content = constructWeiXinPushContent(label);
            outXml = constructWeiXinMsg(fromUserName, toUserName, content, url);
        } else {
            outXml = constructWeiXinMsg(fromUserName, toUserName, "查询的序列号不存在", url);
        }

        System.out.println(new Date(System.currentTimeMillis()) + "--outXml:\n" + outXml + "\n");
        return outXml;
    }

    /**
     * 生成返回微信服务器的报文
     * @param toUserName
     * @param fromUserName
     * @param content
     * @param url
     * @return
     */
    public String constructWeiXinMsg(String toUserName, String fromUserName, String content, String url) {

        Document document = DocumentHelper.createDocument();
        document.setXMLEncoding("utf-8");
        Element root = document.addElement("xml");

        root.addElement("ToUserName").setText(toUserName);
        root.addElement("FromUserName").setText(fromUserName);

//        root.addElement("CreateTime").setText(Long.toString(System.currentTimeMillis()));
//        StringBuilder stringBuilder = new StringBuilder("<a href=\"")
//                .append(url)
//                .append("\">")
//                .append(content)
//                .append("</a>");
//        CDATA msgTypeData = DocumentHelper.createCDATA(PalConst.getInstance().weiXinMsgType);
//        CDATA contentData = DocumentHelper.createCDATA(stringBuilder.toString());
//        root.addElement("MsgType").add(msgTypeData);
//        root.addElement("Content").add(contentData);

        root.addElement("CreateTime").setText(Long.toString(System.currentTimeMillis()));
        root.addElement("MsgType").add(DocumentHelper.createCDATA(PalConst.getInstance().weiXinMsgType));
        root.addElement("ArticleCount").setText("1");
        Element item = root.addElement("Articles").addElement("item");
        item.addElement("Title").add(DocumentHelper.createCDATA("诚品宝"));
        item.addElement("Description").add(DocumentHelper.createCDATA(content));
        item.addElement("PicUrl")/*.add(DocumentHelper.createCDATA("http://101.200.182.7/pal-website/resources/images/logo.png"))*/;
        item.addElement("Url").add(DocumentHelper.createCDATA(url));
        root.addElement("FuncFlag").setText("1");
        return document.asXML();
    }

    private String constructWeiXinPushContent(Label label){

        return PalConst.getInstance().trueMsg + "\n\n商品：" + label.getProduct().getName() + "\n\n作者：" + label.getProduct().getTenant().getName();
    }
}
