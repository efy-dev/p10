package com.efeiyi.ec.system.project.controller;


import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.project.model.ProjectProperty;
import com.efeiyi.ec.project.model.ProjectPropertyValue;
import com.efeiyi.ec.system.product.model.ProductModelBean;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.efeiyi.ec.system.product.service.ProductModelManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/product")
public class ProjectController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private ProductModelManager productModelManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private ProductManager productManager;

    @RequestMapping("/delProjectPropertyValue.do")
    @ResponseBody
  public String deleteProjectPropertyValue(String id){
        try {
            baseManager.delete(ProjectPropertyValue.class.getName(),id);
        }catch (Exception e){
               e.printStackTrace();
        }

        return  id;
  }

    @RequestMapping("/saveOrUpdateProjectPropertyValue.do")
    public String saveOrUpdateProjectPropertyValue(ProjectPropertyValue projectPropertyValue,String resultPage){
          ProjectPropertyValue projectPropertyValueTemp = null;
       try{
          if(projectPropertyValue.getId()==null||projectPropertyValue.getId()==""){
              projectPropertyValueTemp.setId(null);
              projectPropertyValueTemp.setProjectProperty(projectPropertyValue.getProjectProperty());
              projectPropertyValueTemp.setValue(projectPropertyValue.getValue());
          }else {
              projectPropertyValueTemp = (ProjectPropertyValue)baseManager.getObject(ProjectPropertyValue.class.getName(),projectPropertyValue.getId());
              projectPropertyValueTemp.setValue(projectPropertyValue.getValue());
          }
           baseManager.saveOrUpdate(ProjectPropertyValue.class.getName(),projectPropertyValueTemp);
       }catch (Exception e){
               e.printStackTrace();
       }

        return  resultPage;
    }

}
