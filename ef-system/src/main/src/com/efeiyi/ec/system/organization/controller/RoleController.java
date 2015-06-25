package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.organization.model.Permission;
import com.efeiyi.ec.organization.model.Role;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.does.model.Module;
import com.ming800.core.does.service.ModuleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

    @Autowired
    private ModuleManager moduleManager;

    @RequestMapping(value = "/listRole.do")
    public ModelAndView listRole() throws Exception {
        ModelMap modelMap = new ModelMap();
        return new ModelAndView("manage/character/roleList", modelMap);
    }

    @RequestMapping(value = "/formRole.do")
    public ModelAndView formRole(Role role, ModelMap modelMap) throws Exception {
        if (role != null && role.getId() != null) {
            role = (Role) baseManager.getObject(role.getClass().getName(), role.getId());
            if (role.getPermissionsList() != null && role.getPermissionsList().size() > 0) {
                StringBuilder stringBuilder = new StringBuilder();
                for (Permission permission : role.getPermissionsList()) {
                    if (permission.getAll()) {
                        stringBuilder.append(permission.getEntityName()).append("_all").append(",");
                    } else {
                        if (permission.getBasic() != null) {
                            for (String basic : permission.getBasic().split(",")) {
                                stringBuilder.append(permission.getEntityName()).append("_").append(basic).append(",");
                            }
                        }
                        if (permission.getOthers() != null) {
                            for (String others : permission.getOthers().split(",")) {
                                stringBuilder.append(permission.getEntityName()).append("_").append(others).append(",");
                            }
                        }
                    }
                }
                stringBuilder.deleteCharAt(stringBuilder.length() - 1);
                modelMap.put("choosedIds", stringBuilder);
            }
            modelMap.put("role", role);
        }

        /*List<Map.Entry<String, Module>> list_Data = new ArrayList<Map.Entry<String, Module>>(moduleManager.fetchModuleMap().entrySet());
        Collections.sort(list_Data, new Comparator<Map.Entry<String, Module>>() {      //按照module的label进行排序
            public int compare(Map.Entry<String, Module> o1, Map.Entry<String, Module> o2) {
                String label1 = o1.getValue().getLabel();
                String label2 = o2.getValue().getLabel();
                if (label1 != null && label2 != null && label2.compareTo(label1) < 0) {
                    return 1;
                } else {
                    return -1;
                }
            }
        });
        modelMap.put("moduleMap", list_Data);*/

        Map<String, Module> moduleMap = moduleManager.fetchModuleMap();
        //LinkedList<Module> moduleLinkedList = new LinkedList<>();
        //Version version = versionManager.fetchVersion();
/*        for (String moduleName : version.getModuleList()) {

            moduleLinkedList.add(moduleMap.get(moduleName));
        }*/
        //modelMap.put("moduleList", moduleLinkedList);
        //modelMap.put("entityList", version.getEntityList());

        HashMap<String, String> labelMap = new HashMap<>();

        labelMap.put("view", "查看");
        labelMap.put("new", "新建");
        labelMap.put("edit", "修改");
        labelMap.put("delete", "删除");

        modelMap.put("labelMap", labelMap);

        return new ModelAndView("manage/character/roleForm");
    }

}
