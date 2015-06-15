package com.ming800.core.p.controller;

import com.ming800.core.does.model.StatusTypeField;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.p.model.Dictionary;
import com.ming800.core.p.model.DictionaryData;
import com.ming800.core.p.service.DictionaryDataManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-1-14
 * Time: 21:37:28
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/dictionary")
public class DictionaryController {
    private Dictionary dictionary;

    @Autowired
    private ModuleManager moduleManager;

    @Autowired
    private DictionaryDataManager dictionaryDataManager;

    //获取xml中所有的字典信息
    @RequestMapping(value = "/listDictionary.do")
    public ModelAndView listDictionary(HttpServletRequest request, ModelMap modelMap) {

        String em = request.getParameter("em");
        if (em != null && !em.equals("")) {
            modelMap.put("em", em);
            modelMap.put("module", moduleManager.fetchModule(em));
        }

//        modelMap.put("moduleMap", moduleManager.fetchModuleMap());

        return new ModelAndView("core/p/dictionaryList");
    }

    //获取具体的数据字典
    @RequestMapping(value = "/listDictionaryData.do")
    public ModelAndView listDictionaryData(HttpServletRequest request, ModelMap modelMap) {

        String entityName = request.getParameter("em");
        String fieldName = request.getParameter("nm");
        dictionary = (Dictionary) moduleManager.fetchXentity(entityName).getFieldMap().get(fieldName);
        modelMap.put("em", entityName);
        modelMap.put("nm", fieldName);
        modelMap.put("dictionary", dictionary);

        String dictionaryId = request.getParameter("dictionaryId");

        List<DictionaryData> dictionaryDataList = dictionaryDataManager.getDictionaryDataList(dictionaryId);

        modelMap.put("dictionaryDataList", dictionaryDataList);

        return new ModelAndView("core/p/dictionaryDataList");
    }

    //获取具体的Field
    @RequestMapping(value = "/viewStatusTypeField.do")
    public ModelAndView viewStatusTypeField(HttpServletRequest request, ModelMap modelMap) {

        String entityName = request.getParameter("em");
        String fieldName = request.getParameter("nm");

        StatusTypeField statusTypeField = (StatusTypeField) moduleManager.fetchXentity(entityName).getFieldMap().get(fieldName);
        modelMap.put("em", entityName);
        modelMap.put("nm", fieldName);
        modelMap.put("statusTypeField", statusTypeField);

        return new ModelAndView("core/p/statusTypeFieldView");
    }

    //新建数据
    @RequestMapping(value = "/formDictionaryData.do")
    public ModelAndView formDictionaryData(HttpServletRequest request, ModelMap modelMap) {

        String dictionaryDataId = request.getParameter("dictionaryDataId");
        if (dictionaryDataId != null && !dictionaryDataId.equals("")) {
            DictionaryData dictionaryData = dictionaryDataManager.getDictionaryDataById(dictionaryDataId);
            modelMap.put("dictionaryData", dictionaryData);
        }

        String entityName = request.getParameter("em");
        modelMap.put("em", entityName);
        String fieldName = request.getParameter("nm");
        modelMap.put("nm", fieldName);
        dictionary = (Dictionary) moduleManager.fetchXentity(entityName).getFieldMap().get(fieldName);
        modelMap.put("dictionary", dictionary);

        return new ModelAndView("core/p/dictionaryDataForm");
    }

    //添加数据字典
    @RequestMapping(value = "/saveOrUpdateDictionaryData.do")
    public ModelAndView saveOrUpdateDictionaryData(HttpServletRequest request, DictionaryData dictionaryData) {

        if (dictionaryData.getId() == null) {
            dictionaryData.setTheStatus(1);

            dictionaryDataManager.saveOrUpdateDictionaryData(dictionaryData);
        } else {
            DictionaryData repositoryDictionaryData = dictionaryDataManager.getDictionaryDataById(dictionaryData.getId());
            repositoryDictionaryData.setData(dictionaryData.getData());
            dictionaryDataManager.saveOrUpdateDictionaryData(repositoryDictionaryData);
        }

        String em = request.getParameter("em");
        String nm = request.getParameter("nm");

        return new ModelAndView("redirect:/dictionary/listDictionaryData.do?em=" + em + "&nm=" + nm + "&dictionaryId=" + dictionaryData.getDictionaryId());
    }

    //删除数据字典
    @RequestMapping(value = "/deleteDictionaryData.do")
    public ModelAndView deleteDictionaryData(HttpServletRequest request, String dictionaryDataId) {
        DictionaryData dictionaryData = dictionaryDataManager.getDictionaryDataById(dictionaryDataId);
        dictionaryData.setTheStatus(0);
        dictionaryDataManager.saveOrUpdateDictionaryData(dictionaryData);

        String em = request.getParameter("em");
        String nm = request.getParameter("nm");

        return new ModelAndView("redirect:/dictionary/listDictionaryData.do?em=" + em + "&nm=" + nm + "&dictionaryId=" + dictionaryData.getDictionaryId());
    }


    //返回 dictionaryTypeList 分类列表
    public String gobackdictionarytype() {
        /*  org.dom4j.Document document = readDocument(DICTIONIES_MODEL);                             //读取dictionaries.xml
        List<org.dom4j.Node> nodeList = document.selectNodes("/dictionaries/dictDefination");
        for (org.dom4j.Node node : nodeList) {


            String sid = node.selectSingleNode("@sid").getText();
            String name = node.selectSingleNode("@name").getText();

            dictionaryDefinationMap.put(sid, name);
            request.setAttribute("dictionaryDefinationMap", dictionaryDefinationMap);


        }*/

        return "success";
    }


    //获取一个对象的数据字典
    public String getDirctionaryDataById() {

       /* String sid=request.getParameter("sid");
          org.dom4j.Document document = readDocument(DICTIONIES_MODEL);                             //读取dictionaries.xml
        List<org.dom4j.Node> nodeList = document.selectNodes("/dictionaries/dictDefination");
        for (org.dom4j.Node node : nodeList) {
            String sidxml = node.selectSingleNode("@sid").getText();

            if (sid.equals(sidxml)) {
                String name = node.selectSingleNode("@name").getText();

                request.setAttribute("dictionaryName", name);
                request.setAttribute("sid",sid);
            }
        }
        String dataId = request.getParameter("id");
        int  id=Integer.parseInt(dataId) ;
        


        dictionaryData = dictionaryDataManager.getByIdDirctionaryData(id);
           request.setAttribute("dictionaryData",dictionaryData);
*/
        dictionary = dictionaryDataManager.getDictionaryBySid(dictionary.getSid());
//        dictionaryData.set(dictionaryDataManager.getDictionaryData(myUser.getBranch().getId(), dictionaryData.getId()));
        return "success";
    }

    //修改数据字典
    public String updateDictionaryData() {
//        String sid = request.getParameter("sid");
//        request.setAttribute("sid", sid);
//        dictionaryData.setDefinationName(sid);
//        String definationValue = request.getParameter("dictionaryValue");
//        dictionaryData.setDictionaryValue(definationValue);
//
//        dictionaryDataManager.updateDictionaryData(myUser.getBranch().getId(),dictionaryData.getId(),dictionaryData.getDictionaryValue());
        return "success";
    }

    @RequestMapping(value = "/listDictionaryDataByJson.do")
    @ResponseBody
    public List<DictionaryData> listDictionaryDataByJson(HttpServletRequest request) {
        String dictionaryId = request.getParameter("dictionaryId");

        List<DictionaryData> dictionaryDataList = dictionaryDataManager.getDictionaryDataList(dictionaryId);
        return dictionaryDataList;
    }

    public Dictionary getDictionary() {
        return dictionary;
    }

    public void setDictionary(Dictionary dictionary) {
        this.dictionary = dictionary;
    }

}
