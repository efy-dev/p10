package com.efeiyi.ec.system.basic.controller;

import com.efeiyi.ec.system.basic.model.UEditor;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.util.ReflectUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

/**
 * Created by Administrator on 2016/5/10 0010.
 */
@Controller
public class EditorController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/ueditor/config.do"})
    @ResponseBody
    public ResponseEntity<byte[]> ueditorConfig(HttpServletRequest request) throws IOException {
        String realPath = request.getServletContext().getRealPath("/");
        String filePath = realPath + "/scripts/utf8-jsp/jsp/config.json";
        System.out.println(realPath);
        File file = new File(filePath);
        HttpHeaders headers = new HttpHeaders();
        String fileName = "config.json";
        headers.setContentDispositionFormData("attachment", fileName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.OK);
    }

    @RequestMapping({"/ueditor/use.do"})
    public String useUeditor(UEditor uEditor, HttpServletRequest request, Model model) throws Exception {
        if (uEditor.getObjectId() != null && !uEditor.getObjectId().equals("")) {
            Object object = baseManager.getObject(uEditor.getObjectClassType(), uEditor.getObjectId());
            String textContent = (String) ReflectUtil.invokeGetterMethod(object, uEditor.getName());
            model.addAttribute("textContent", textContent);
        }
        model.addAttribute("uEditor", uEditor);
        return "/ueditor";
    }


}

