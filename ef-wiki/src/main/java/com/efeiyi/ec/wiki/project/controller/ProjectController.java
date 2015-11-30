package com.efeiyi.ec.wiki.project.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectFollowed;
import com.efeiyi.ec.wiki.base.controller.WikibaseController;
import com.efeiyi.ec.wiki.model.ProductStore;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/10/12.
 *
 */
@Controller
public class ProjectController extends WikibaseController {
    private static Logger logger = Logger.getLogger(ProjectController.class);
    @Autowired
    BaseManager baseManager;

    @RequestMapping("/project/brifProject/{projectId}")
    public ModelAndView getBrifProject(@PathVariable String projectId,HttpServletRequest request, Model model) throws Exception {
        Project project = getBrifProjectHeader(projectId);
        boolean flag = checkIsAttention(projectId,request);
        model.addAttribute("flag", flag);
        model.addAttribute("project", project);
        return new ModelAndView("/project/brifProject");
    }

    @RequestMapping("/project/Isattention.do")
    @ResponseBody
    public boolean checkIsAttention(HttpServletRequest request) throws Exception {
        boolean flag = false;
        String projectid = request.getParameter("projectId");
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery xQuery = new XQuery("plistProjectFollowed_check", request);
            xQuery.put("project_id", projectid);
            xQuery.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list = baseManager.listObject(xQuery);
            if (list != null && list.size() >= 1) {
                flag = true;
            }
        }

        return flag;
    }//Waiting for the invalid 待删除

    @RequestMapping("/project/brifMaster/{projectId}")
    public ModelAndView getBrifMaster(@PathVariable String projectId,HttpServletRequest request, Model model) throws Exception {
        Project project = getBrifProjectHeader(projectId);
        boolean flag = checkIsAttention(projectId,request);
        model.addAttribute("flag", flag);
        model.addAttribute("project", project);
        return new ModelAndView("/project/brifMaster");
    }

    @RequestMapping("/project/listProduct/{projectId}")
    public ModelAndView getListProducts(@PathVariable String projectId,HttpServletRequest request, Model model) throws Exception {
        Project project = getBrifProjectHeader(projectId);
        boolean flag = checkIsAttention(projectId,request);
        model.addAttribute("flag", flag);
        model.addAttribute("project", project);
        return new ModelAndView("/project/listProduct");
    }

    @RequestMapping("/project/showProduct/{productId}/{projectId}")
    public String showProduct(@PathVariable String productId,@PathVariable String projectId,HttpServletRequest request, Model model) throws Exception {
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        boolean flag = false;
        if(product.getMaster()!=null && !"".equals(product.getMaster().getId())){
            flag = IsattentionMaster2(request, product.getMaster().getId());//判断用户是否已经关注该作品的大师
        }

        model.addAttribute("flag", flag);
        model.addAttribute("product", product);
        if (AuthorizationUtil.getMyUser().getId() != null) {
            model.addAttribute("myUser", AuthorizationUtil.getMyUser());
        }
        boolean hasStore =  IsStoreProduct(request,productId);
        model.addAttribute("hasStore", hasStore);
        model.addAttribute("projectId", projectId);
        return "/product/brifProduct";
    }



    @RequestMapping("/base/attention.do")
    @ResponseBody
    public String saveProjectFollows(HttpServletRequest request) throws Exception {
        String projectid = request.getParameter("projectId");
        Project project = (Project) baseManager.getObject(Project.class.getName(), projectid);
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        } else {
            String queryHql = "from ProjectFollowed t where t.user.id=:userId and t.project.id=:projectId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("projectId", projectid);
            ProjectFollowed pf = (ProjectFollowed) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (pf != null && pf.getId() != null)//说明已经关注
            {
                //baseManager.delete(ProjectFollowed.class.getName(), pf.getId());
                baseManager.remove(ProjectFollowed.class.getName(), pf.getId());//假删
                long FsAmount = 0;
                if (project.getFsAmount() == null) {
                    FsAmount = 0;
                } else if (project.getFsAmount() - 1 <= 0) {
                    FsAmount = 0;
                } else if (project.getFsAmount() - 1 >= 1) {
                    FsAmount = project.getFsAmount() - 1;
                }
                project.setFsAmount(FsAmount);
                baseManager.saveOrUpdate(Project.class.getName(), project);
                return "del";
            } else {
                ProjectFollowed projectFollowed = new ProjectFollowed();
                projectFollowed.setUser(user);
                projectFollowed.setProject(project);
                projectFollowed.setStatus("1");
                projectFollowed.setCreateDatetime(new Date());
                project.setFsAmount(project.getFsAmount() == null ? (0 + 1) : (project.getFsAmount() + 1));
                baseManager.saveOrUpdate(Project.class.getName(), project);
                baseManager.saveOrUpdate(ProjectFollowed.class.getName(), projectFollowed);

                return "true";
            }

        }
    }
    @RequestMapping("/base/Isattention/{projectId}")
    @ResponseBody
    public boolean checkIsAttention(@PathVariable String projectId,HttpServletRequest request) throws Exception {
        boolean flag = false;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery xQuery = new XQuery("plistProjectFollowed_check", request);
            xQuery.put("project_id", projectId);
            xQuery.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list = baseManager.listObject(xQuery);
            if (list != null && list.size() >= 1) {
                flag = true;
            }
        }

        return flag;
    }


    @RequestMapping("/base/brifProject/{projectId}/{page}")
    public ModelAndView getBrifProject(@PathVariable String projectId,@PathVariable String page,HttpServletRequest request, Model model) throws Exception {
        Project project = (Project) baseManager.getObject(Project.class.getName(), projectId);
        boolean flag = checkIsAttention(projectId,request);//判断用户是否已经关注该项目
        model.addAttribute("flag", flag);
        model.addAttribute("project", project);
        if(page!=null && page.equals("2")){
            return new ModelAndView("/project/brifProject2");
        }
        return new ModelAndView("/project/brifProject");
    }


    public Project getBrifProjectHeader(String projectId) throws Exception {
        return (Project) baseManager.getObject(Project.class.getName(), projectId);
    }

    public boolean IsattentionMaster2(HttpServletRequest request, String userid) throws Exception {
        boolean flag = false;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery xQuery = new XQuery("listMasterFollowed_check", request);
            xQuery.put("master_id", userid);
            xQuery.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list = baseManager.listObject(xQuery);
            if (list != null && list.size() >= 1) {
                flag = true;
            }
        }
        return flag;
    }

    public boolean IsStoreProduct(HttpServletRequest request, String productId) throws Exception {
        boolean flag = false;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            String queryHql = "from ProductStore t where t.user.id=:userId and t.product.id=:productId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", AuthorizationUtil.getMyUser().getId());
            map.put("productId", productId);
            ProductStore ps = (ProductStore) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (ps != null && ps.getId() != null){
                flag = true;
            }//不为null,说明已经收藏了
        }
        return flag;
    }
}
