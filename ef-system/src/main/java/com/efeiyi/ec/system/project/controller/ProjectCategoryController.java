package com.efeiyi.ec.system.project.controller;

import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.project.model.ProjectProperty;
import com.efeiyi.ec.project.model.ProjectPropertyValue;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.efeiyi.ec.system.product.service.ProductModelManager;
import com.efeiyi.ec.system.project.dao.TenantProjectDao;
import com.efeiyi.ec.system.project.service.ProjectManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/projectCategory")
public class ProjectCategoryController extends BaseController {
    @Autowired
    private BaseManager baseManager;



    @RequestMapping("/updateStatus.do")
    @ResponseBody
    public String updateStatus(String id,String status){
        ProjectCategory projectCategory = (ProjectCategory)baseManager.getObject(ProjectCategory.class.getName(),id);
        try {
            projectCategory.setStatus(status);
            baseManager.saveOrUpdate(ProjectCategory.class.getName(),projectCategory);

        }catch (Exception e){
            e.printStackTrace();
        }
        return  status;
    }


}
