package com.efeiyi.pal.system.label.controller;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.label.model.LabelBatch;
import com.ming800.core.base.service.BaseManager;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015/7/28.
 */

@Controller
@RequestMapping("/Label")
public class LabelController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/saveLabelList.do")
    public ModelAndView saveLabelList(HttpServletRequest request) throws Exception {

        String labelBatchId = request.getParameter("labelBatchId");
        if (labelBatchId == null || labelBatchId.equals("")) {
            throw new Exception("labelBatchId不能为空");
        }

        LabelBatch labelBatch = (LabelBatch) baseManager.getObject(LabelBatch.class.getName(), labelBatchId);
        String resultPage = labelListSave(labelBatch, labelBatchId);

        return new ModelAndView(resultPage);
    }

    private String labelListSave(LabelBatch labelBatch, String labelBatchId) throws Exception{

        if (labelBatch == null) {
            throw new Exception("Id为" + labelBatchId + "的标签批次不存在!");
        }

        Integer flag = labelBatch.getAmount();

        for (int i=0; i<flag; i++){
            String code = RandomStringUtils.randomNumeric(10);
            String serial = String.valueOf(i + 1);

            Label label = new Label();
            label.setSerial(serial);
            label.setCode(code);
            label.setLabelBatch(labelBatch);
            label.setPurchaseOrderLabel(null);
            label.setSeller(null);
            label.setStatus("1");

            baseManager.saveOrUpdate(label.getClass().getName(), label);
        }
        labelBatch.setStatus("2");
        baseManager.saveOrUpdate(labelBatch.getClass().getName(), labelBatch);

        return "redirect:/basic/xm.do?qm=plistLabel_default&conditions=labelBatch.id:"+labelBatch.getId();
    }

}
