package com.efeiyi.service;

import com.efeiyi.util.PalConst;
import com.efeiyi.bean.CheckResultBean;
import com.efeiyi.dao.IPalDao;
import com.efeiyi.pal.check.model.LabelCheckRecord;
import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.product.model.Product;
import org.apache.commons.beanutils.BeanUtils;
import org.dom4j.*;
import org.hibernate.Query;
import org.hibernate.annotations.Check;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

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
public class LabelCheckManagerImpl implements ILabelCheckManager {

    @Autowired
    private IPalDao palDao;

    /**
     * 查询唯一标签
     *
     * @param labelId
     * @return
     */
    public Label getUniqueLabel(String labelId) {

        LinkedHashMap<String, Object> queryParaMap = new LinkedHashMap<>();
        queryParaMap.put(PalConst.getInstance().checkLabelParam1, labelId);
        Query listQuery = palDao.createQuery(PalConst.getInstance().checkLabel);
        listQuery = setQueryParams(listQuery, queryParaMap);
        return (Label) listQuery.uniqueResult();
    }

    /**
     * 查询唯一商品
     *
     * @param productId
     * @return
     */
    @Override
    public Product getUniqueProduct(String productId) {

        LinkedHashMap<String, Object> queryLabParaMap = new LinkedHashMap<>();
        queryLabParaMap.put(PalConst.getInstance().productId, productId);
        Query listQuery = palDao.createQuery(PalConst.getInstance().viewProduct);
        listQuery = setQueryParams(listQuery, queryLabParaMap);
        return (Product) listQuery.uniqueResult();
    }

    /**
     * @param request
     * @return
     */
    @Override
    public ModelMap getProductModel(HttpServletRequest request) throws ServletException {

        String code = request.getParameter(PalConst.getInstance().code);
        Label label = getUniqueLabel(code);
        Product product = label.getPurchaseOrderLabel().getProduct();

        ModelMap model = new ModelMap();
        model.addAttribute(PalConst.getInstance().resultProduct, product);

        Date date = new Date();
        //如果首次查
        if (label.getCheckCount() == 1 && label.getStatus().equals(PalConst.getInstance().usedStatus)) {
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().trueBean);
        }
        //如果非首次查
        else if (label.getStatus().equals(PalConst.getInstance().usedStatus)) {

            Long timeDiffer = date.getTime() - label.getFirstCheckDateTime().getTime();
            CheckResultBean recheckBean = new CheckResultBean();

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
            } catch (Exception e) {
                throw new ServletException(e.getMessage());
            }
            model.addAttribute(PalConst.getInstance().resultLabel, recheckBean);
        }
        //如果其他状态码无效
        else {
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }

        return model;
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

    /**
     * 处理微信公众号发来的请求
     *
     * @param request 请求
     * @param inXml   post的xml
     * @return
     * @throws ServletException
     * @throws IOException
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public String treatWeiXinMsg(HttpServletRequest request, String inXml) throws ServletException, IOException {
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

        if (PalConst.getInstance().weiXinSubscribeEvent.equals(event)) {
            serial = serial.substring(8).trim();
        } else if (!PalConst.getInstance().weiXinScanEvent.equals(event)) {
            return "";
        }
//        String serial = "1234567890";
        System.out.println("serial=\'" + serial + "\'");

//        String toUserName = "aaa";
//        String fromUserName = "bbb";

        ModelMap model = new ModelMap();
        Label label = getUniqueLabel(serial);
        String outXml = "";
        String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/checkLabel.do?serial=" + serial;
        String toUserName = root.element("ToUserName").getText();
        String fromUserName = root.element("FromUserName").getText();

        System.out.println("标签存在？" + (label != null));
        if (label != null) {

            PalConst.getInstance().labelCache.put(label.getCode(), label.getCode());//扫二维码计入全局
            model.addAttribute(PalConst.getInstance().ip, request.getRemoteHost());//记录ip

            updateRecord(model, label, true);
            System.out.println("标签已查次数：" + label.getCheckCount());
            String content = constructWeiXinPushContent(model);
            System.out.println("content:" + content);
            outXml = constructWeiXinMsg(label, fromUserName, toUserName, content, url);

        } else {
            outXml = constructWeiXinMsg(label, fromUserName, toUserName, PalConst.getInstance().fakeBean.getMsg(), url);
        }

        System.out.println("\n\n" + new Date(System.currentTimeMillis()) + "--outXml:\n" + outXml + "\n\n");
        return outXml;
//        return "";
    }

    /**
     * 无视是否查询，直接更新标签状态和查询记录
     *
     * @param model
     * @param label
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateRecord(ModelMap model, Label label) throws ServletException {

        Date date = new Date();
        addLabelCheckRecord(model, label, date);
        label.setCheckCount(label.getCheckCount() + 1);
        System.out.println("标签已查次数：" + label.getCheckCount());

        //状态码是已激活或已查询
        if (label.getStatus().equals(PalConst.getInstance().unusedStatus) || label.getStatus().equals(PalConst.getInstance().usedStatus)) {

            label.setStatus(PalConst.getInstance().usedStatus);
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().trueBean);
        }
        //如果其他状态码无效
        else {
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }

        //数据不完整时，记录中更新为null
        try {
            model.addAttribute(PalConst.getInstance().resultProduct, label.getPurchaseOrderLabel().getProduct());
        } catch (NullPointerException e) {
            model.addAttribute(PalConst.getInstance().resultProduct, null);
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().wrongBean);
        }
        //更新标签状态
        label.setLastCheckDateTime(date);
        //更新首次查询时间
        if (label.getCheckCount() == 1) {
            label.setFirstCheckDateTime(date);
        }
        palDao.saveOrUpdate(label.getClass().getName(), label);

    }

    /**
     * 更新标签状态和查询记录
     *
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
        if (isAddCount) {
            addLabelCheckRecord(model, label, date);
            label.setCheckCount(label.getCheckCount() + 1);
        }
        System.out.println("标签已查次数：" + label.getCheckCount());
        Long timeDiffer = 0l;

        //如果首次查
        if (label.getStatus().equals(PalConst.getInstance().unusedStatus)) {

            if (label.getCheckCount() == 1) {
                label.setStatus(PalConst.getInstance().usedStatus);
                model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().trueBean);
            } else {
                CheckResultBean recheckBean = getCheckResultBean(label, timeDiffer);
                model.addAttribute(PalConst.getInstance().resultLabel, recheckBean);
            }
        }
        //如果非首次查
        else if (label.getStatus().equals(PalConst.getInstance().usedStatus)) {

            try {
                timeDiffer = date.getTime() - label.getFirstCheckDateTime().getTime();
            } catch (NullPointerException e) {
                model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().wrongBean);
            }

            CheckResultBean recheckBean = getCheckResultBean(label, timeDiffer);

            model.addAttribute(PalConst.getInstance().resultLabel, recheckBean);
        }
        //如果其他状态码无效
        else {
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }

        //数据不完整时，记录中更新为null
        try {
            model.addAttribute(PalConst.getInstance().resultProduct, label.getPurchaseOrderLabel().getProduct());
        } catch (NullPointerException e) {
            model.addAttribute(PalConst.getInstance().resultProduct, null);
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().wrongBean);
        }
        //更新标签状态
        label.setLastCheckDateTime(date);
        //更新首次查询时间
        if (label.getCheckCount() == 1) {
            label.setFirstCheckDateTime(date);
        }
        palDao.saveOrUpdate(label.getClass().getName(), label);

    }

    /**
     * 判断查询次数和间隔时间显示正确的提示信息
     *
     * @param label
     * @param timeDiffer
     * @return
     * @throws ServletException
     */
    private CheckResultBean getCheckResultBean(Label label, Long timeDiffer) throws ServletException {
        CheckResultBean recheckBean = new CheckResultBean();

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
        } catch (Exception e) {
            throw new ServletException(e.getMessage());
        }

        String msg = "";
        if (PalConst.getInstance().labelCache.get(label.getCode()) != null) {
            msg = getWeixinRecheckRecordMsg(label);
        } else {
            msg = getRecheckRecordMsg(label);
        }
        recheckBean.setMsg(msg);
        return recheckBean;
    }

    /**
     * 写入查询记录
     *
     * @param model
     * @param label
     * @param date
     */
    public void addLabelCheckRecord(ModelMap model, Label label, Date date) {

        LabelCheckRecord checkRecord = new LabelCheckRecord();
        checkRecord.setCreateDatetime(date);
        checkRecord.setIP((String) model.get(PalConst.getInstance().ip));
        checkRecord.setLabel(label);
        try {
            checkRecord.setProduct(label.getPurchaseOrderLabel().getProduct());
        } catch (NullPointerException e) {
            checkRecord.setProduct(null);
        }
        palDao.saveOrUpdate(checkRecord.getClass().getName(), checkRecord);
    }


    /**
     * 组装真伪消息的时间、地点和验证次数
     *
     * @param label
     * @return
     * @throws Exception
     */
    private String getRecheckRecordMsg(Label label) {
        if (label != null) {
            String msg = PalConst.getInstance().recheckFakeBean.getMsg().
                    replaceAll("#N#", Integer.toString(label.getCheckCount())).
                    replaceAll("#TIME#", PalConst.getInstance().dateFormat.format(label.getLastCheckDateTime()));
            System.out.println("getRecheckRecordMsg：" + msg);
            return msg;
        }
        return null;
    }

    /**
     * 组装微信公众平台真伪消息的时间、地点和验证次数
     *
     * @param label
     * @return
     * @throws Exception
     */
    private String getWeixinRecheckRecordMsg(Label label) {
        if (label != null) {
            String msg = PalConst.getInstance().weixinRecheckMsg.
                    replaceAll("#N#", Integer.toString(label.getCheckCount())).
                    replaceAll("#TIME#", PalConst.getInstance().dateFormat.format(label.getLastCheckDateTime()));
            System.out.println("getWeixinRecheckRecordMsg：" + msg);
            return msg;
        }
        return null;
    }


    /**
     * 生成返回微信服务器的报文
     *
     * @param toUserName
     * @param fromUserName
     * @param content      推送的文本内容
     * @param url          图文消息的链接
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
        if (label != null) {
            item.addElement("PicUrl").add(DocumentHelper.createCDATA(PalConst.getInstance().uploadImgBaseUrl + label.getPurchaseOrderLabel().getProduct().getLogo()));
        }
        item.addElement("Url").add(DocumentHelper.createCDATA(url));
        root.addElement("FuncFlag").setText("1");
        return document.asXML();
    }

    /**
     * 组装通过微信公众号推送用户的消息
     *
     * @return
     */
    private String constructWeiXinPushContent(ModelMap model) {

        CheckResultBean checkResultBean = (CheckResultBean) model.get(PalConst.getInstance().resultLabel);
//        return PalConst.getInstance().trueMsg + "\n\n商品：" + label.getPurchaseOrderLabel().getProduct().getName() + "\n\n作者：" + label.getPurchaseOrderLabel().getProduct().getTenant().getName();
        return checkResultBean.getMsg();
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
