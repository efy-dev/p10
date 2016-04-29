package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.efeiyi.ec.personal.master.MasterUtil;
import com.efeiyi.ec.personal.master.service.MasterWorkManager;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by AC丶man on 2015/6/29.
 */
@Controller
public class TenantController extends BaseMasterController {

    @Autowired
    BaseManager baseManager;
    @Autowired
    private AliOssUploadManager aliOssUploadManager;
    @Autowired
    private MasterWorkManager masterWorkManager;

    /**
     * 获取某传承人的详情页
     *
     * @param
     * @return
     */
    @RequestMapping("/home.do")
    public ModelAndView getTenant(HttpServletRequest request, Model model) throws Exception {
        Master tenant = getMasterfromDomain(request);
        if (tenant == null) {
            return new ModelAndView("redirect:/index");
        }
        String queryHql = "from MasterWork t where t.master.id = :tenantId and t.status !='0' order by t.sort desc";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId", tenant.getId());
        List list = baseManager.listObject(queryHql, queryParamMap);
        XQuery xQuery = new XQuery("listMasterBanner_default", request);
        xQuery.put("master_id", tenant.getId());
        model.addAttribute("bannerList", baseManager.listObject(xQuery));
        model.addAttribute("tenantWorkList", list);
        model.addAttribute("tenant", tenant);
        model.addAttribute("pageMsg", "1");
        return new ModelAndView("/tenant/tenantView");
    }


    @ResponseBody
    @RequestMapping("/getTenant.do")
    public Object getTenant(HttpServletRequest request) throws Exception {
        return getMasterfromDomain(request);
    }

    @RequestMapping("/masterDatils.do")
    public String MasterDatil(String id, Model model) {
        Master master = (Master) baseManager.getObject(Master.class.getName(), id);
        model.addAttribute("object", master);
        return "/master/masterIntro";
    }

    @RequestMapping("/uploadify.do")
    @ResponseBody
    public String uploadProductImg(HttpServletRequest request) throws Exception {
        String data = "";
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "";
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            url = "tenant/" + identify + fileName;
            try {
                aliOssUploadManager.uploadFile(mf, "tenant", url);
                data = url;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        System.out.print(url);
        return data;


    }

    @RequestMapping("/toCheck.do")
    public String toCheck(String id, String flag, Master master) {
        master.setCreateDateTime(new Date());
        master.setReview(flag);
        baseManager.saveOrUpdate(Master.class.getName(), master);
        return "redirect:/basic/xm.do?qm=viewMaster&id=" + id;
    }

    @ResponseBody
    @RequestMapping("/getMaster.do")
    public String getOnlyMaster() {
        Master master = MasterUtil.findMaster();
        return master.getFullName();
    }

//    public Master findMaster() {
//        String hql = "from MasterUser m where m.user.id =:userId and m.status = '1'";
//        LinkedHashMap<String, Object> map = new LinkedHashMap<>();
//        map.put("userId", AuthorizationUtil.getMyUser().getId());
//        List<MasterUser> list = baseManager.listObject(hql, map);
//        Master master = list.get(0).getMaster();
//        return master;
//    }


    @RequestMapping("/onlyMaster.do")
    public String OnlyMaster() {
        Master master = MasterUtil.findMaster();
        return "redirect:/basic/xm.do?qm=viewMaster&id=" + master.getId();
    }


    @ResponseBody
    @RequestMapping("/getMasterUser.do")
    public String getOyMaster() {
        Master master = MasterUtil.findMaster();
        return master.getReview();
    }


    @RequestMapping("/onMaster.do")
    public String onMaster() {
        Master master = MasterUtil.findMaster();
        return "redirect:/basic/xm.do?qm=viewMaster&id=" + master.getId();
    }

    @RequestMapping("/onMasterWork.do")
    public String onMasterWork(Model model) {
        Master master = MasterUtil.findMaster();
        model.addAttribute("id", master.getId());
        return "/master/masterWork";
    }

    @RequestMapping("/onWork.do")
    public String onWork(Model model, String workId , HttpServletRequest request) throws Exception {
        Master master = MasterUtil.findMaster();
        MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(),workId);
        XQuery xQuery = new XQuery("listMasterBanner_default", request);
        xQuery.put("master_id", master.getId());
        model.addAttribute("masterBannerList", baseManager.listObject(xQuery));
        model.addAttribute("object", work);
        return "/master/masterWorkView";
    }

    @RequestMapping("/master/removeMasterBannerPicture.do")
    @ResponseBody
    public boolean removeMasterBannerPicture(String id) {

        try {
            baseManager.remove(MasterBanner.class.getName(), id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();

            return false;
        }

    }

    @RequestMapping("/master/saveMasterWork.do")
    public String saveMasterWork(HttpServletRequest request, MultipartRequest multipartRequest, ModelMap modelMap) {
        modelMap.put("result", "false");
        modelMap.put("name", request.getParameter("name"));
        try {
            String workId = masterWorkManager.saveMasterWork(request, multipartRequest);
            modelMap.put("result", "true");
            modelMap.put("workId", workId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/basic/xm.do?qm=plistMasterWork_default1";
    }

    @RequestMapping("/master/uploadify.do")
    @ResponseBody
    public String uploadProductImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String data = "";
        Master master = null;
        if (!StringUtils.isEmpty(request.getParameter("id"))) {
            master = (Master) baseManager.getObject(Master.class.getName(), request.getParameter("id"));
        }
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url;
        Integer sort = 0;
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            String hz = fileName.substring(fileName.indexOf("."), fileName.length());
            String imgName = fileName.substring(0, fileName.indexOf(hz));
            url = "banner/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;
            MasterBanner anner = new MasterBanner();
            try {
                anner.setImageUrl(url);
                anner.setMaster(master);
                anner.setStatus("1");
                anner.setGroup("tenant");
                anner.setTitle(imgName);
                aliOssUploadManager.uploadFile(mf, "tenant", url);
                baseManager.saveOrUpdate(MasterBanner.class.getName(), anner);
                data = anner.getId() + ":" + url + ":" + imgName + hz + ":" + sort;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return data;
    }


    @RequestMapping("/onMasterNews.do")
    public String onMasterNews(Model model) {
        Master master = MasterUtil.findMaster();
        model.addAttribute("master",master);
        return "/master/masterNewsForm";
    }


    @RequestMapping("/saveMasterNews.do")
    public String saveMasterNews(String masterId ,MasterNews news, Model model) {
        Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
        news.setMaster(master);
        news.setStatus("1");
        baseManager.saveOrUpdate(MasterNews.class.getName(),news);
        model.addAttribute("masterId",master.getId());
        model.addAttribute("object",news);
        return "redirect:/basic/xm.do?qm=plistMasterNews_default";
    }


    @ResponseBody
    @RequestMapping("/master/linkProject.do")
    public boolean linkProject(HttpServletRequest request) {
        try {
            XQuery xQuery = new XQuery("listMasterProject_byAll",request);
            xQuery.put("master_id",MasterUtil.findMaster().getId());
            xQuery.put("project_id",request.getParameter("id"));
            List<MasterProject> masterProjects = baseManager.listObject(xQuery);
            if(masterProjects!=null && masterProjects.size()>0){
                return  true;
            }else {
                MasterProject masterProject = new MasterProject();
                masterProject.setMaster(MasterUtil.findMaster());
                masterProject.setStatus("1");
                masterProject.setProject((Project)baseManager.getObject(Project.class.getName(),request.getParameter("id")));
                baseManager.saveOrUpdate(MasterProject.class.getName(),masterProject);

            }
        }catch (Exception e){
            e.printStackTrace();
            return  false;

        }

        return true;
    }

}
