package com.efeiyi.service;

import com.efeiyi.PalConst;
import com.efeiyi.ResultBean;
import com.efeiyi.dao.IPalDao;
import com.efeiyi.pal.check.model.LabelCheckRecord;
import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.product.model.Product;
import org.apache.commons.beanutils.BeanUtils;
import org.dom4j.*;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/8/7.
 */

@Service
@EnableTransactionManagement
public class LabelCheckManagerImpl  implements ILabelCheckManager {

//    @Autowired
//    @Qualifier("sessionFactory")
//    private SessionFactory sessionFactory;
//
//    public Session getSession() {
//        return sessionFactory.getCurrentSession();
//    }
//
//    @Resource
//    public void setSessionFactory0(SessionFactory sessionFactory) {
//        super.setSessionFactory(sessionFactory);
//    }

    @Autowired
    private IPalDao palDao;

    /**
     * 查询唯一标签
     * @param labelId
     * @return
     */
    public Label getUniqueLabel(String labelId) {

        LinkedHashMap<String, Object> queryParaMap = new LinkedHashMap<>();
        queryParaMap.put(PalConst.getInstance().checkLabelParam1, labelId);
//        return (Label) baseManager.getUniqueObjectByConditions(PalConst.getInstance().checkLabel, queryParaMap);
//        Query listQuery = this.getSession().createQuery(PalConst.getInstance().checkLabel);
        Query listQuery = palDao.createQuery(PalConst.getInstance().checkLabel);
        listQuery = setQueryParams(listQuery, queryParaMap);
        return (Label)listQuery.uniqueResult();
    }

    @Override
    public Product getUniqueProduct(String productId) {

        LinkedHashMap<String, Object> queryLabParaMap = new LinkedHashMap<>();
        queryLabParaMap.put(PalConst.getInstance().productId, productId);
//        Query listQuery = this.getSession().createQuery(PalConst.getInstance().viewProduct);
        Query listQuery = palDao.createQuery(PalConst.getInstance().viewProduct);
        listQuery = setQueryParams(listQuery, queryLabParaMap);
        return (Product)listQuery.uniqueResult();
    }

    protected Query setQueryParams(Query query, LinkedHashMap<String, Object> queryParamMap) {
        if (queryParamMap != null && queryParamMap.size() > 0) {
            for (String paramName : queryParamMap.keySet()) {
                if (queryParamMap.get(paramName) instanceof Object[]) {
                    query.setParameterList(paramName, (Object[]) queryParamMap.get(paramName));
                } else if (queryParamMap.get(paramName) instanceof Collection) {
                    query.setParameterList(paramName, (Collection) queryParamMap.get(paramName));
                } else {
                    query.setParameter(paramName, queryParamMap.get(paramName));
                }
            }
        }

        return query;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public String treatWeiXinMsg(HttpServletRequest request,String inXml) throws ServletException,IOException {
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
//        String serial = "1234567890";
        System.out.println("serial=\'" + serial + "\'");

        Label label = getUniqueLabel(serial);
        ModelMap model = new ModelMap();
        updateRecord(model, label, true);

        System.out.println("标签已查次数："+label.getCheckCount());
        String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/checkLabel.do?serial=" + serial;
        String toUserName = root.element("ToUserName").getText();
        String fromUserName = root.element("FromUserName").getText();


        if (label != null) {
            String content = constructWeiXinPushContent(label);
            outXml = constructWeiXinMsg(label,fromUserName, toUserName, content, url);
        } else {
            outXml = constructWeiXinMsg(label,fromUserName, toUserName, PalConst.getInstance().weiXinFakeMsg, url);
        }

        System.out.println(new Date(System.currentTimeMillis()) + "--outXml:\n" + outXml + "\n");
        return outXml;
//        return "";
    }

    /**
     * 更新标签状态和查询记录
     * @param model
     * @param label
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateRecord(ModelMap model, Label label, boolean isAddCount) throws ServletException {

        Date date = new Date();

        System.out.println("是否新增记录：" + isAddCount);
        //插入一条查询记录
        if(isAddCount){
            addLabelCheckRecord(model,label,date);
            label.setCheckCount(label.getCheckCount() + 1);
        }
        System.out.println("标签已查次数：" + label.getCheckCount());
        //如果首次查
        if (label.getStatus().equals(PalConst.getInstance().unusedStatus)) {

            label.setStatus(PalConst.getInstance().usedStatus);
            label.setFirstCheckDateTime(date);
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().trueBean);

        }
        //如果非首次查
        else if (label.getStatus().equals(PalConst.getInstance().usedStatus)) {

            Long timeDiffer = date.getTime() - label.getFirstCheckDateTime().getTime();

            ResultBean recheckBean = new ResultBean();
            try {
                //只有24小时内查询次数为2才显示真
                if (timeDiffer < PalConst.getInstance().timeIncrement && label.getCheckCount() == 2) {
                    BeanUtils.copyProperties(recheckBean, PalConst.getInstance().recheckTrueBean);
                }
                //否则一律不显示真伪
                else {
                    BeanUtils.copyProperties(recheckBean, PalConst.getInstance().recheckFakeBean);
                    recheckBean.setAuthenticity(PalConst.getInstance()._null);
                }

            }catch(Exception e){
                throw new ServletException(e.getMessage());
            }
            String msg = getRecheckRecordMsg(label);
            recheckBean.setMsg(msg);
            model.addAttribute(PalConst.getInstance().resultLabel, recheckBean);
        }
        //如果其他状态码无效
        else {
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }

        model.addAttribute(PalConst.getInstance().resultProduct, label.getPurchaseOrderLabel().getProduct());

        //更新标签状态
        label.setLastCheckDateTime(date);
//         getSession().saveOrUpdate(label.getClass().getName(), label);
        palDao.saveOrUpdate(label.getClass().getName(), label);

    }

    public void addLabelCheckRecord(ModelMap model,Label label,Date date) {

        LabelCheckRecord checkRecord = new LabelCheckRecord();
        checkRecord.setCreateDatetime(date);
        checkRecord.setIP((String) model.get(PalConst.getInstance().ip));
        checkRecord.setLabel(label);
        checkRecord.setProduct(label.getPurchaseOrderLabel().getProduct());
//        checkRecord.setIPAddress(getIpAddress(checkRecord.getIP()));
//        getSession().saveOrUpdate(checkRecord.getClass().getName(), checkRecord);
        palDao.saveOrUpdate(checkRecord.getClass().getName(), checkRecord);
    }


    /**
     * 组装真伪消息的时间、地点和验证次数
     * @param label
     * @return
     * @throws Exception
     */
    private String getRecheckRecordMsg(Label label) {

//        String ip =  label.getLabelCheckRecordList().get(0).getIPAddress();

        String msg = PalConst.getInstance().recheckFakeBean.getMsg().
                replaceAll("#N#", Integer.toString(label.getCheckCount())).
                replaceAll("#TIME#", PalConst.getInstance().dateFormat.format(label.getLastCheckDateTime()));
        return msg;
    }


    /**
     * 生成返回微信服务器的报文
     * @param toUserName
     * @param fromUserName
     * @param content 推送的文本内容
     * @param url 图文消息的链接
     * @return 推送微信公众号的报文
     */
    public String constructWeiXinMsg(Label label, String toUserName, String fromUserName, String content, String url) {

        Document document = DocumentHelper.createDocument();
        document.setXMLEncoding("utf-8");
        Element root = document.addElement("xml");

        root.addElement("ToUserName").setText(toUserName);
        root.addElement("FromUserName").setText(fromUserName);

        //发送文本消息
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

        //发送图文消息
        root.addElement("CreateTime").setText(Long.toString(System.currentTimeMillis()));
        root.addElement("MsgType").add(DocumentHelper.createCDATA(PalConst.getInstance().weiXinMsgType));
        root.addElement("ArticleCount").setText("1");
        Element item = root.addElement("Articles").addElement("item");
        item.addElement("Title").add(DocumentHelper.createCDATA("诚品宝"));
        item.addElement("Description").add(DocumentHelper.createCDATA(content));
        item.addElement("PicUrl").add(DocumentHelper.createCDATA(PalConst.getInstance().uploadImgBaseUrl + label.getPurchaseOrderLabel().getProduct().getImgUrl()));
        item.addElement("Url").add(DocumentHelper.createCDATA(url));
        root.addElement("FuncFlag").setText("1");
        return document.asXML();
    }

    /**
     * 组装通过微信公众号推送用户的消息
     * @param label
     * @return
     */
    private String constructWeiXinPushContent(Label label){

        return PalConst.getInstance().trueMsg + "\n\n商品：" + label.getPurchaseOrderLabel().getProduct().getName() + "\n\n作者：" + label.getPurchaseOrderLabel().getProduct().getTenant().getName();
    }

    /**
     * 使用百度api查询Ip归属地
     * @param ip
     * @return
     * @throws Exception
     */
//    public String getIpAddress(String ip) throws Exception{
//
//        HttpClient httpclient = new HttpClient();
//        HttpMethod method = new GetMethod(PalConst.getInstance().baiduApiUrl);
//        httpclient.executeMethod(method);
//        String json = method.getResponseBodyAsString();
//        System.out.println(method.getResponseBodyAsString());
//        method.releaseConnection();
//        Map<?, ?> ipAddressMap = JsonUtil.parseJsonStringToMap(json);
//        String [] addresses = ((String)ipAddressMap.get("address")).split("\\|");
//        return (String)ipAddressMap.get("address");
//    }

//    public static void main(String [] args){
//
//        try {
//            new LabelCheckManagerImpl().getIpAddress("");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }
}
