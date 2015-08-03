package com.efeiyi.controller;

import com.efeiyi.PalConst;
import com.efeiyi.pal.record.model.CheckRecord;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.efeiyi.pal.label.model.Label;

import java.util.Date;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/27.
 * 验证防伪码的真伪֤controller
 */
@Controller
@RequestMapping
public class LabelCheckController  {

    @Autowired
    private BaseManager baseManager;


    @RequestMapping(value = "/checkLabel.do")
    public ModelAndView checkLabel(HttpServletRequest request, ModelMap model)throws Exception {

        LinkedHashMap<String, Object> qryLabParaMap = new LinkedHashMap<>();

        String val1 = request.getParameter(PalConst.getInstance().pageParam1);
        qryLabParaMap.put(PalConst.getInstance().qryLabelCol,val1);
        Label label =  (Label)baseManager.getUniqueObjectByConditions(PalConst.getInstance().checkLabel, qryLabParaMap);

        if(label == null){
            model.addAttribute(PalConst.getInstance().resultLab, PalConst.getInstance().fakeNonExistBean);
        }else {
            model.addAttribute(PalConst.getInstance().ip,request.getRemoteHost());
            model = updateRecord(model,label);
        }
        return new ModelAndView(PalConst.getInstance().resultView, model);
    }

    @Transactional
    public ModelMap updateRecord(ModelMap model, Label label) throws Exception {

        CheckRecord checkRecord = new CheckRecord();
        checkRecord.setCreateDatetime(new Date());
        checkRecord.setIp((String)model.get(PalConst.getInstance().ip));
        checkRecord.setLabelId(label.getId());
        checkRecord.setProductId(label.getProduct().getId());

        baseManager.saveOrUpdate(checkRecord.getClass().getName(),checkRecord);

        if (label.getStatus().equals(PalConst.getInstance().usedStatus)) {
            model.addAttribute(PalConst.getInstance().resultLab, PalConst.getInstance().fakeExistBean);

        } else if (label.getStatus().equals(PalConst.getInstance().unusedStatus)) {
            label.setStatus(PalConst.getInstance().usedStatus);
            label.setUsedDate(checkRecord.getCreateDatetime());

            baseManager.saveOrUpdate(label.getClass().getName(),label);
            model.addAttribute(PalConst.getInstance().resultLab, PalConst.getInstance().trueBean);
        }

        model.addAttribute(PalConst.getInstance().resultPdu,label.getProduct());
        return model;
    }

}
