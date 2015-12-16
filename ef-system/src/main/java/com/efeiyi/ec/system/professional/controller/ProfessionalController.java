package com.efeiyi.ec.system.professional.controller;

import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectPropertyValue;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.efeiyi.ec.system.product.service.ProductModelManager;
import com.efeiyi.ec.system.professional.service.ProfessionalManager;
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
@RequestMapping("/professional")
public class ProfessionalController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private ProfessionalManager professionalManager;



    @RequestMapping("/saveProfessional.do")
    public String saveProfessional(Professional professional,String resultPage){

       try{

           professionalManager.saveProfessional(professional);
       } catch (Exception e){
               e.printStackTrace();
       }

        return  resultPage;
    }

    @RequestMapping("/checkUsername.do")
    @ResponseBody
    public boolean checkUsername(String username){

        boolean flag = true;
        try{
            flag = professionalManager.checkUsername(username);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  flag;
    }

    @RequestMapping("/removeProfessional.do")
    @ResponseBody
    public String removeProfessional(String id){


        try{
            Professional professional = (Professional)baseManager.getObject(Professional.class.getName(), id);
            professional.setStatus("0");
            baseManager.saveOrUpdate(Professional.class.getName(),professional);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  id;
    }
}
