package com.ming800.core.base.controller;

import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.base.model.Relation;
import com.ming800.core.base.model.RelationObject;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.service.impl.DoManagerImpl;
import com.ming800.core.does.model.Xentity;
import com.ming800.core.does.service.ModuleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-8
 * Time: 下午2:23
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/relation")
public class RelationController {

    @Autowired
    private XdoManager xdoManager;
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private ModuleManager moduleManager;

    @RequestMapping("/formRelation.do")
    public ModelAndView formRelation(HttpServletRequest request, ModelMap modelMap) throws Exception {
        String type = request.getParameter("type");
        if (type != null) {
            modelMap.put("type", type);
        }

        modelMap.put("tempDoMap", DoManagerImpl.getQueryModelMap());
        return new ModelAndView("/core/base/relationForm");
    }

    @RequestMapping("/plistRelation.do")
    public ModelAndView plistRelation(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String conditions = request.getParameter("conditions");

        List<Relation> relationList = (List<Relation>) xdoManager.list("plistRelationByObjectId_default", conditions);

        Map<String, Xentity> xentityMap = moduleManager.fetchXentityMap();


        if (relationList != null && relationList.size() > 0) {
            List<RelationObject> relationObjectList = new ArrayList<>();
            for (Relation relation : relationList) {

                RelationObject relationObject = new RelationObject();

                String objectId = "";
                Xentity xentity = null;
                Object object = null;
                if (conditions.contains("objectId:")) {
                    objectId = relation.getObjectId1();
                    xentity = xentityMap.get(relation.getEntity1());
                    object = baseManager.getObject(xentity.getModel(), relation.getObjectId1());
                } else {
                    objectId = relation.getObjectId();
                    xentity = xentityMap.get(relation.getEntity());
                    object = baseManager.getObject(xentity.getModel(), relation.getObjectId());
                }

                relationObject.setXentity(xentity);
                relationObject.setObjectId(objectId);
                relationObject.setObjectName(ReflectUtil.invokeGetterMethod(object, "name").toString());

                relationObjectList.add(relationObject);

                modelMap.put("xentity", xentity);
            }

            modelMap.put("relationObjectList", relationObjectList);
        }

        return new ModelAndView("/core/base/relationObjectView");
    }

}
