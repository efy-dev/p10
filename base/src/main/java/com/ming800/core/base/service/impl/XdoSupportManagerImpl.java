package com.ming800.core.base.service.impl;

import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.base.service.XdoSupportManager;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-1-23
 * Time: 上午10:02
 * To change this template use File | Settings | File Templates.
 */
@Service
public class XdoSupportManagerImpl implements XdoSupportManager {


    @Override
    public void generateTempPageConditions(String url, Map map, String tempIndex, String tempSize) throws Exception {

//        String resultPage = "redirect:/basic/xm.do?qm=" + qm;
//
//        if (conditions != null) {
//            resultPage += "&conditions=" + java.net.URLEncoder.encode(conditions, "utf-8");
//        }
//        if (tempIndex != null && !tempIndex.equals("")) {
//            resultPage += "&pageEntity.index=" + tempIndex + "&pageEntity.size=" + tempSize;
//        }

        String tempParam = "";
        for (Object key : map.keySet()) {
            String[] values = (String[]) map.get(key);
            String tempKey = key.toString();
            if (tempKey.equals("page")) {
                tempParam += "&pageEntity.index=" + values[0];
            } else if (tempKey.equals("rows")) {
                tempParam += "&pageEntity.size=" + values[0];
            } else {
                tempParam += "&" + tempKey + "=" + java.net.URLEncoder.encode(values[0], "utf-8");
            }

        }

        String resultPage = "redirect:/basic/xm.do" + tempParam.replaceFirst("&", "?");
        //AuthorizationUtil.getMyUser().setTempPageUrl(resultPage);
    }


    @Override
    public ModelMap execute(Do tempDo, ModelMap modelMap, HttpServletRequest request) throws Exception {

        DoHandler doHandler = (DoHandler) Class.forName(tempDo.getExecute()).newInstance();

        return doHandler.handle(modelMap, request);
    }

    @Override
    public ModelMap executeMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
//         MultipartHandler multipartHandler = new AttchmentHandler();
        MultipartHandler multipartHandler  = (MultipartHandler) Class.forName(tempDo.getExecute()).newInstance();;

        return multipartHandler.handleMultipart(tempDo, modelMap, request, multipartRequest);
    }
}
