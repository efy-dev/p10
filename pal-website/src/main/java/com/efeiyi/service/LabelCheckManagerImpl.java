package com.efeiyi.service;

import com.efeiyi.PalConst;
import com.efeiyi.ResultBean;
import com.efeiyi.pal.check.model.LabelCheckRecord;
import com.efeiyi.pal.label.model.Label;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import org.apache.commons.beanutils.BeanUtils;
import org.dom4j.CDATA;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.ui.ModelMap;

import java.util.Date;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/8/7.
 */
@Service
public class LabelCheckManagerImpl implements ILabelCheckManager {

    @Autowired
    BaseManager baseManager;
//
//    @Autowired
//    XdoDao xdoDao;
//
    public Label getUniqueLabel(String labelId){

        LinkedHashMap<String, Object> qryLabParaMap = new LinkedHashMap<>();
        qryLabParaMap.put(PalConst.getInstance().queryLabelColumn, labelId);
        return (Label)baseManager.getUniqueObjectByConditions(PalConst.getInstance().checkLabel, qryLabParaMap);
    }



    public String constructWeiXinMsg(String toUserName, String fromUserName, String content,String url) {

        Document document = DocumentHelper.createDocument();
        document.setXMLEncoding("utf-8");
        Element root = document.addElement("xml");

        root.addElement("ToUserName").setText(toUserName);
        root.addElement("FromUserName").setText(fromUserName);

        StringBuffer stringBuffer = new StringBuffer("<a href=\"")
                                             .append(url)
                                             .append("\">")
                                             .append(content)
                                             .append("</a>");
        root.addElement("CreateTime").setText(Long.toString(System.currentTimeMillis()));
        CDATA msgTypeData = DocumentHelper.createCDATA(PalConst.getInstance().weiXinMsgType);
        CDATA contentData = DocumentHelper.createCDATA(stringBuffer.toString());
        root.addElement("MsgType").add(msgTypeData);
        root.addElement("Content").add(contentData);

        return  document.asXML();
    }

    public ModelMap updateRecord(ModelMap model, Label label) throws Exception {
//
//        Date date = new Date();
//        label.setCheckCount(label.getCheckCount() + 1);
//        //如果首次查
//        if (label.getStatus().equals(PalConst.getInstance().unusedStatus)) {
//
//            //更新码状态
//            label.setStatus(PalConst.getInstance().usedStatus);
//            label.setFirstCheckDateTime(date);
//            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().trueBean);
//        }
//        //如果非首次查
//        else if(label.getStatus().equals(PalConst.getInstance().usedStatus)){
//
//            Long timeDiffer = date.getTime() - label.getFirstCheckDateTime().getTime();
//
//            //只有24小时内查询次数为2才显示真
//            if(timeDiffer < PalConst.getInstance().timeIncrement && label.getCheckCount() == 2){
//                ResultBean recheckTrueBean = new ResultBean();
//                BeanUtils.copyProperties(recheckTrueBean, PalConst.getInstance().recheckTrueBean);
//                String msg = PalConst.getInstance().recheckTrueBean.getMsg();
//                msg = msg.replaceAll("#N#", Integer.toString(label.getCheckCount())).replaceAll("#TIME#", label.getLastCheckDateTime().toString());
//                recheckTrueBean.setMsg(msg);
//                model.addAttribute(PalConst.getInstance().resultLabel, recheckTrueBean);
//            }
//            //否则一律不显示真伪
//            else{
//                ResultBean recheckFakeBean = new ResultBean();
//                BeanUtils.copyProperties(recheckFakeBean, PalConst.getInstance().recheckFakeBean);
//                String msg = PalConst.getInstance().recheckFakeBean.getMsg();
//                msg = msg.replaceAll("#N#",Integer.toString(label.getCheckCount())).replaceAll("#TIME#",label.getLastCheckDateTime().toString());
//                recheckFakeBean.setMsg(msg);
//                recheckFakeBean.setAuthenticity(PalConst.getInstance()._null);
//                model.addAttribute(PalConst.getInstance().resultLabel, recheckFakeBean);
//            }
//
//            label.setLastCheckDateTime(date);
//
//            baseManager.saveOrUpdate(label.getClass().getName(), label);
//        }
//        //如果其他状态码无效
//        else{
//            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
//        }
//
//
//        //插入一条查询记录
//        LabelCheckRecord checkRecord = new LabelCheckRecord();
//        checkRecord.setCreateDatetime(date);
//        checkRecord.setIP((String) model.get(PalConst.getInstance().ip));
//        checkRecord.setLabel(label);
//        checkRecord.setProduct(label.getProduct());
//        xdoDao.saveOrUpdateObject(checkRecord.getClass().getName(),checkRecord);
//        model.addAttribute(PalConst.getInstance().resultProduct, label.getProduct());
        return model;
    }
    public void saveOrUpdate(String name,Object obj){
//        baseManager.saveOrUpdate(name,obj);
    }
}
