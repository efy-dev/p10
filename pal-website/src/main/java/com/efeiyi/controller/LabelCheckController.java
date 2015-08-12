package com.efeiyi.controller;

import com.efeiyi.PalConst;
import com.efeiyi.ResultBean;
import com.efeiyi.pal.check.model.LabelCheckRecord;
import com.efeiyi.service.ILabelCheckManager;
import com.ming800.core.base.service.BaseManager;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.efeiyi.pal.label.model.Label;


import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/7/27.
 * 验证防伪码的真伪֤controller
 */
@Controller
public class LabelCheckController  {

//    @Autowired
//    private ILabelCheckManager iLabelCheckService;

    @Autowired
    BaseManager baseManager;

    @RequestMapping(value = "/checkLabel.do")
    public ModelAndView checkLabel(HttpServletRequest request)throws Exception {

        ModelMap model = new ModelMap();

        //查label是否存在
        String serial = request.getParameter(PalConst.getInstance().pageParam1);
//        Label label =  (Label)iLabelCheckService.getUniqueLabel(serial);
        LinkedHashMap<String, Object> qryLabParaMap = new LinkedHashMap<>();
        qryLabParaMap.put(PalConst.getInstance().queryLabelColumn, serial);
        Label label = (Label)baseManager.getUniqueObjectByConditions(PalConst.getInstance().checkLabel, qryLabParaMap);

        //label不存在
        if(label == null){
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }
        //label存在
        else {
            model.addAttribute(PalConst.getInstance().ip,request.getRemoteHost());
//            model = iLabelCheckService.updateRecord(model, label);
            model = updateRecord(model, label);
        }
        return new ModelAndView(PalConst.getInstance().resultView, model);
    }

    public ModelMap updateRecord(ModelMap model, Label label) throws Exception {

        Date date = new Date();
        label.setCheckCount(label.getCheckCount() + 1);
        //如果首次查
        if (label.getStatus().equals(PalConst.getInstance().unusedStatus)) {

            //更新码状态
            label.setStatus(PalConst.getInstance().usedStatus);
            label.setFirstCheckDateTime(date);
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().trueBean);
        }
        //如果非首次查
        else if(label.getStatus().equals(PalConst.getInstance().usedStatus)){

            Long timeDiffer = date.getTime() - label.getFirstCheckDateTime().getTime();

            //只有24小时内查询次数为2才显示真
            if(timeDiffer < PalConst.getInstance().timeIncrement && label.getCheckCount() == 2){
                ResultBean recheckTrueBean = new ResultBean();
                BeanUtils.copyProperties(recheckTrueBean, PalConst.getInstance().recheckTrueBean);
                String msg = PalConst.getInstance().recheckTrueBean.getMsg();
                msg = msg.replaceAll("#N#", Integer.toString(label.getCheckCount())).replaceAll("#TIME#", label.getLastCheckDateTime().toString());
                recheckTrueBean.setMsg(msg);
                model.addAttribute(PalConst.getInstance().resultLabel, recheckTrueBean);
            }
            //否则一律不显示真伪
            else{
                ResultBean recheckFakeBean = new ResultBean();
                BeanUtils.copyProperties(recheckFakeBean, PalConst.getInstance().recheckFakeBean);
                String msg = PalConst.getInstance().recheckFakeBean.getMsg();
                msg = msg.replaceAll("#N#",Integer.toString(label.getCheckCount())).replaceAll("#TIME#",label.getLastCheckDateTime().toString());
                recheckFakeBean.setMsg(msg);
                recheckFakeBean.setAuthenticity(PalConst.getInstance()._null);
                model.addAttribute(PalConst.getInstance().resultLabel, recheckFakeBean);
            }

            label.setLastCheckDateTime(date);

//            iLabelCheckService.saveOrUpdate(label.getClass().getName(), label);
        }
        //如果其他状态码无效
        else{
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }

        baseManager.saveOrUpdate(label.getClass().getName(), label);

        //插入一条查询记录
        LabelCheckRecord checkRecord = new LabelCheckRecord();
        checkRecord.setCreateDatetime(date);
        checkRecord.setIP((String) model.get(PalConst.getInstance().ip));
        checkRecord.setLabel(label);
        checkRecord.setProduct(label.getProduct());
//        iLabelCheckService.saveOrUpdate(checkRecord.getClass().getName(),checkRecord);
        baseManager.saveOrUpdate(checkRecord.getClass().getName(),checkRecord);
        model.addAttribute(PalConst.getInstance().resultProduct, label.getProduct());
        return model;
    }
}
