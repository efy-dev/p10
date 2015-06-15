package com.efeiyi.ec.organization.controller;

import com.ming800.core.base.controller.BaseController;
import com.ming800.core.does.model.ConfigProperty;
import com.ming800.core.does.model.Module;
import com.ming800.core.does.service.ModuleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping("/configProperty")
public class ConfigPropertyController extends BaseController {

    /*    @Autowired
        private ConfigManager configManager;*/
    @Autowired
    private ModuleManager moduleManager;

    @RequestMapping(value = "/formConfigProperty.do")
    public ModelAndView formConfigProperty(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String em = request.getParameter("em");
        if (em != null && !em.equals("")) {
            modelMap.put("em", em);
            modelMap.put("module", moduleManager.fetchModule(em));
        }

//        modelMap.put("moduleMap", moduleManager.fetchModuleMap());
//        modelMap.put("configPropertyMap", configManager.fetchConfigPropertyMap());
        modelMap.put("branchConfigPropertyList", xdoManager.list("plistBranchConfigProperty_default", null));

        return new ModelAndView("/organization/user/configPropertyForm");
    }

    @RequestMapping(value = "/formBranchConfigProperty.do")
    public ModelAndView formBranchConfigProperty(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String em = request.getParameter("em");
        String cm = request.getParameter("cm");
        if (em != null && !em.equals("")) {
            modelMap.put("em", em);
            modelMap.put("cm", cm);
            Module module = moduleManager.fetchModule(em);

            for (ConfigProperty configProperty : module.getConfigPropertyList()) {
                if (configProperty.getName().equals(cm)) {
                    modelMap.put("configProperty", configProperty);
                    break;
                }
            }
        }

        List<BranchConfigProperty> branchConfigPropertyList = (List<BranchConfigProperty>) xdoManager.list("plistBranchConfigProperty_default", null);
        for (BranchConfigProperty branchConfigProperty : branchConfigPropertyList) {
            if (branchConfigProperty.getName().equals(cm)) {
                modelMap.put("branchConfigProperty", branchConfigProperty);
                break;
            }
        }
        return new ModelAndView("/organization/user/branchConfigPropertyForm");
    }


    @RequestMapping(value = "/saveOrUpdateBranchConfigProperty.do")
    public ModelAndView saveOrUpdateBranchConfigProperty(HttpServletRequest request) throws Exception {

        String em = request.getParameter("em");
        String cm = request.getParameter("cm");

        String[] ids = request.getParameterValues("ids");
        String[] names = request.getParameterValues("names");
        String[] values = request.getParameterValues("values");
        String[] labels = request.getParameterValues("labels");
        String[] modules = request.getParameterValues("modules");

        for (int i = 0; i < names.length; i++) {
            /*String nameCheckbox = request.getParameter(names[i] + "_allCheckbox");
            if (nameCheckbox != null) {*/
            BranchConfigProperty branchConfigProperty = new BranchConfigProperty();
            if (!ids[i].equals("")) {
                branchConfigProperty.setId(ids[i]);
            }
            branchConfigProperty.setName(names[i]);
            branchConfigProperty.setLabel(labels[i]);
            branchConfigProperty.setValue(values[i]);
            branchConfigProperty.setModule(modules[i]);


            baseManager.saveOrUpdate(BranchConfigProperty.class.getName(), branchConfigProperty);
//            }
        }

        return new ModelAndView("redirect:/configProperty/formBranchConfigProperty.do?em=" + em + "&cm=" + cm);
    }

}
