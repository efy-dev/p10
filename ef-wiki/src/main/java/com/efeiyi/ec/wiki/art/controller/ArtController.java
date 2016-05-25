package com.efeiyi.ec.wiki.art.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.wiki.model.Artistry;
import com.efeiyi.ec.wiki.model.ArtistryDescription;
import com.efeiyi.ec.wiki.model.ArtistryRecord;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/4/12.
 */
@Controller
public class ArtController extends BaseController {

    @Autowired
    BaseManager baseManager;
    @Autowired
    ObjectRecommendedManager objectRecommendedManager;

    /**
     * 工艺详情:description技艺描述；
     * 相关大师，在MasterProject中取；相关作品取project下面的ProductModel推荐；
     * @param projectWikiId
     * @param request
     * @param model
     */
    @RequestMapping("/project/{projectWikiId}")
    public String getProjectDetail(HttpServletRequest request,Model model,@PathVariable String projectWikiId) throws Exception {
        Artistry artistry = (Artistry) baseManager.getObject(Artistry.class.getName(),projectWikiId);
        String projectId = null;
        try {
            projectId = artistry.getProject().getId();
        }catch (Exception e){
            projectId = null;
        }
        //相关大师
        XQuery xquery = new XQuery("listMasterProject_byProject",request);
        xquery.put("project_id",projectId);
        List<MasterProject> masterProjectList = baseManager.listObject(xquery);
        XQuery mwXQuery = new XQuery("listMasterWork_default", request);
        //相关作品
        mwXQuery.put("project_id",projectId);
        List<MasterWork> masterWorkList = baseManager.listObject(mwXQuery);
        model.addAttribute("masterProjectList",masterProjectList);
        model.addAttribute("masterWorkList",masterWorkList);
        model.addAttribute("artistry",artistry);
        return "/project/craftDescription";
    }
    @RequestMapping(value="/test.do",method = RequestMethod.POST)
    @ResponseBody
    public String getQU(HttpServletRequest request){
        StringBuffer url = request.getRequestURL();
        String method = request.getMethod();
        String param = request.getQueryString();
        System.out.println(param);
        String header = request.getHeader("num");
        System.out.println(header);
        System.out.println(method);
        System.out.println(url);
        Cookie[] cookies = request.getCookies();
        for(int i=0;i<cookies.length;i++){
            System.out.println(cookies[i].getValue());
        }
        return "";

    }

//    @RequestMapping({"ueditor.do"})
//    public String ueditor(HttpServletRequest request,Model model) {
//        String descriptionId =  request.getParameter("descriptionId");
//        ArtistryDescription description = (ArtistryDescription) baseManager.getObject(ArtistryDescription.class.getName(),descriptionId);
//        model.addAttribute("description",description);
//        return "/project/editor";
//    }
    @RequestMapping({"/save.do"})
    public String save(HttpServletRequest request,Model model){
        String content = request.getParameter("content");
        ArtistryRecord artistryRecord = new ArtistryRecord();
        User user  = AuthorizationUtil.getUser();
        ArtistryDescription artistryDescription = new ArtistryDescription();
        artistryDescription.setDescriptionPC(content);
        baseManager.saveOrUpdate(ArtistryDescription.class.getName(),artistryDescription);
        String artistryId = request.getParameter("artistryId");
        Artistry artistry = (Artistry) baseManager.getObject(Artistry.class.getName(),artistryId);
        artistryRecord.setArtistry(artistry);
        artistryRecord.setArtistryDescription(artistryDescription);
        artistryRecord.setUser(user);
        Date date = new Date();
        artistryRecord.setCreateDatetime(date);
        artistryRecord.setCheckResult("0");
        baseManager.saveOrUpdate(ArtistryRecord.class.getName(),artistryRecord);
        model.addAttribute("artistryDescription",artistryDescription);
        return "/project/craftDescription1";

    }

    @RequestMapping({"/check.do"})
    @ResponseBody
    public boolean loginCheck(HttpServletRequest request){
        MyUser currentUser = AuthorizationUtil.getMyUser();
        if (currentUser.getId() != null) {
             return true;
        } else {
            return false;
        }
    }
    /**
     * 检索
     *
     */
    @RequestMapping(value = "/artistrySearch.do/{index}")
    @ResponseBody
    public List<Object> searchResult(HttpServletRequest request,@PathVariable String index) {
        String name = request.getParameter("name");
        PageEntity pageEntity = new PageEntity();
        if (index != null) {
            pageEntity.setIndex(Integer.parseInt(index));
        }
        pageEntity.setSize(8);
        LinkedHashMap queryMap = new LinkedHashMap();
        queryMap.put("name", "%"+name+"%");
        String sql = "from Artistry where name like :name and status=1";
        PageInfo pageInfo = baseManager.listPageInfo(sql, pageEntity, queryMap);
        List<Object> list = pageInfo.getList();
        return list;
    }
    @RequestMapping(value = "/artistrySearch.do")
    public String searchResult(HttpServletRequest request,Model model){
        String name = request.getParameter("q");
        LinkedHashMap queryMap = new LinkedHashMap();
        queryMap.put("name", "%"+name+"%");
        String sql = "from Artistry where name like:name and status=1";
        List<Artistry> artistryList = baseManager.listObject(sql,queryMap);
        if(artistryList.size()==1){
            return "forward:/project/"+artistryList.get(0).getId();
        }
        model.addAttribute("artistryList",artistryList);
        model.addAttribute("name",name);
        return "/searchResult" ;
    }
}
