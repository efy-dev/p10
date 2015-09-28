package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterFollowed;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectFollowed;
import com.efeiyi.ec.project.model.ProjectRecommended;
import com.efeiyi.ec.wiki.model.Praise2Product;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.http.HttpResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2015/7/31.
 *
 */
@Controller
@RequestMapping("/base")
public class WikiIndexController extends WikibaseController {
    private static Logger logger = Logger.getLogger(WikiIndexController.class);
    @Autowired
    BaseManager baseManager;

    /**
     * 非遗百科首页展示
     * @param request is HttpServletRequest,model
     * @return "/wiki/showIndex"
     */
    @RequestMapping("/getTenant.do")
    public ModelAndView getTenant( HttpServletRequest request  , Model model)throws Exception{
        logger.info("weiki  for efeiyi index begin...");

        model.addAttribute("bannerList",getWikiBannerList(request));
        model.addAttribute("projectList",getFeiyiProjectList(request));
        model.addAttribute("recommendProjectList",getRecommendProjectList());
        model.addAttribute("recommendTenantList",getRecommendTenantList());
        model.addAttribute("wondenfulProjectList",getWondenfulProjectList());
        model.addAttribute("wondenfulVideosList",getWondenfulVideosList());

        logger.info("weiki for efeiyi index end...");
        return new ModelAndView("/wiki/showIndex");

    }

    /**
     * 首页轮播图
     * @param request is HttpServletRequest
     * @return bannerList
     * @throws Exception
     */
    public List getWikiBannerList(HttpServletRequest request)throws Exception{
        XQuery xQuery = new XQuery("listWikiBanner_default",request);
        return baseManager.listObject(xQuery);
    }

    /**
     * 非遗百科热门展示
     * @param request is HttpServletRequest,model
     * @return "/wiki/showIndex"
     */
    @RequestMapping("/home.do")
    public ModelAndView getHotProjects( HttpServletRequest request  , Model model)throws Exception{

        XQuery query = new XQuery("plistProjectRecommended_default",request);
        List<ProjectRecommended> list = baseManager.listObject(query);
        model.addAttribute("popularProjectsList",list);

        XQuery query2 = new XQuery("plistProjectRecommended_default",request);
        //query2.put("groupName","attentionProject");
        List<ProjectRecommended> list2 = baseManager.listObject(query2);
        model.addAttribute("attentionProjectsList",list2);

        if(AuthorizationUtil.getMyUser().getId()!=null){
            XQuery query3 = new XQuery("listProjectFollowed_isShow",request);
            query3.put("user_id",AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed>  projectFolloweds = baseManager.listObject(query3);
            if (projectFolloweds.size()>=5){
                model.addAttribute("isShow","ok");
            }else {
                model.addAttribute("isShow","no");
            }
        }else{
            model.addAttribute("isShow","no");
        }

        return new ModelAndView("/hotProjects/PopularProjects");
    }
    @RequestMapping("/getHotProjects.do")
    public List getHotProjects( HttpServletRequest request)throws Exception{
        List list = getWondenfulProjectList();
        return list;
    }

    @RequestMapping("/getPerson.do")
     public ModelAndView getPersonCenter( HttpServletRequest request, Model model)throws Exception{
        return new ModelAndView("/personal/personalCenter");
    }

    @RequestMapping("/getPersonalInfo.do")
     public ModelAndView getPersonInfo( HttpServletRequest request, Model model)throws Exception{
        return new ModelAndView("/personal/personalInfoView");
    }

    @RequestMapping("/attention.do")
    @ResponseBody
    public boolean saveProjectFollows( HttpServletRequest request, Model model)throws Exception{
        String projectid = request.getParameter("projectId");
        ProjectFollowed projectFollowed = new ProjectFollowed();
        MyUser user= AuthorizationUtil.getMyUser();
        if (user.getId()==null){
            return false;
        }
        projectFollowed.setUser(user);
        Project project = (Project)baseManager.getObject(Project.class.getName(),projectid);
        projectFollowed.setProject(project);
        projectFollowed.setStatus("1");
        projectFollowed.setCreateDatetime(new Date());
        project.setFsAmount(project.getFsAmount()==null?(0+1):(project.getFsAmount()+1));
        baseManager.saveOrUpdate(Project.class.getName(),project);
        baseManager.saveOrUpdate(ProjectFollowed.class.getName(),projectFollowed);

        return true;
    }
    @RequestMapping("/Isattention.do")
    @ResponseBody
    public boolean checkIsAttention( HttpServletRequest request,Model model)throws Exception{
        boolean flag = false;
        String projectid = request.getParameter("projectId");
        if (AuthorizationUtil.getMyUser().getId()!= null){
            XQuery xQuery = new XQuery("plistProjectFollowed_check",request);
            xQuery.put("project_id",projectid);
            xQuery.put("user_id",AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list =  baseManager.listObject(xQuery);
            if (list!= null || list.size()>=1){
                flag = true;
            }
        }

        return  flag;
    }


    @RequestMapping("/brifProject.do")
    public ModelAndView getBrifProject( HttpServletRequest request,Model model)throws Exception{
           String projectId = request.getParameter("projectId");
           Project project = (Project)baseManager.getObject(Project.class.getName(),projectId);
        boolean flag = checkIsAttention(request, model);//判断用户是否已经关注该项目
        model.addAttribute("flag",flag);
           model.addAttribute("project",project);
        return new ModelAndView("/project/brifProject");
    }


    @RequestMapping("/IsattentionMaster.do")
    @ResponseBody
    public boolean IsattentionMaster( HttpServletRequest request,Model model)throws Exception{
        boolean flag = false;
        String masterId = request.getParameter("masterId");
        if (AuthorizationUtil.getMyUser().getId()!= null){
            XQuery xQuery = new XQuery("listMasterFollowed_check",request);
            xQuery.put("master_id",masterId);
            xQuery.put("user_id",AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list =  baseManager.listObject(xQuery);
            if (list!= null || list.size()>=1){
                flag = true;
            }
        }

        return  flag;
    }


    @RequestMapping("/attentionMaster.do")
    @ResponseBody
    public boolean saveMasterFollows( HttpServletRequest request, Model model)throws Exception{
        String masterId = request.getParameter("masterId");
        MasterFollowed masterFollowed = new MasterFollowed();
        MyUser user= AuthorizationUtil.getMyUser();
        if (user.getId()==null){
            return false;
        }
        masterFollowed.setUser(user);
        Master master = (Master)baseManager.getObject(Master.class.getName(),masterId);
        masterFollowed.setCreateDateTime(new Date());
        masterFollowed.setMaster(master);
        masterFollowed.setStatus("1");
        masterFollowed.setUser(user);
        //这里需要同步更新master的粉丝数量字段，待大师项目跟进后修改
        baseManager.saveOrUpdate(MasterFollowed.class.getName(),masterFollowed);

        return true;
    }

    @RequestMapping("/showProduct.do")
    public ModelAndView showProduct( HttpServletRequest request,Model model)throws Exception{
        String productId = request.getParameter("productId");
        Product product = (Product)baseManager.getObject(Product.class.getName(),productId);
        boolean flag = IsattentionMaster2(request, product.getMaster().getId());//判断用户是否已经关注该作品的大师
        model.addAttribute("flag",flag);
        model.addAttribute("product",product);
        return new ModelAndView("/product/brifProduct");
    }


    public boolean IsattentionMaster2( HttpServletRequest request,String userid)throws Exception{
        boolean flag = false;
        if (AuthorizationUtil.getMyUser().getId()!= null){
            XQuery xQuery = new XQuery("listMasterFollowed_check",request);
            xQuery.put("master_id",userid);
            xQuery.put("user_id",AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list =  baseManager.listObject(xQuery);
            if (list!= null || list.size()>=1){
                flag = true;
            }
        }
        return  flag;
    }



    @RequestMapping("/saveThumbUp.do")
    @ResponseBody
    public boolean savaUP( HttpServletRequest request, Model model)throws Exception{
        String productId = request.getParameter("productId");
        MyUser user= AuthorizationUtil.getMyUser();
        if (user.getId()==null){
            return false;
        }
        Product product = (Product)baseManager.getObject(Product.class.getName(),productId);
        Praise2Product praise2Product = new Praise2Product();
        String oper = request.getParameter("operation");
        if (oper!=null && oper.equalsIgnoreCase("up")){
            praise2Product.setUser(user);
            praise2Product.setProduct(product);
            baseManager.saveOrUpdate(Praise2Product.class.getName(),praise2Product);
            product.setFsAmount(product.getFsAmount()==null?1:product.getFsAmount()+1);
            baseManager.saveOrUpdate(Product.class.getName(),product);
        }


        if (oper!=null && oper.equalsIgnoreCase("down")){
            String queryHql ="from Praise2Product t where t.user.id=:userId and t.product.id=:productId";
            LinkedHashMap<String,Object> map = new LinkedHashMap<>();
            map.put("userId",user.getId());
            map.put("productId",product.getId());
            Praise2Product praise2Product1 = (Praise2Product)baseManager.getUniqueObjectByConditions(queryHql,map);
            if (praise2Product1!= null && praise2Product1.getId()!=null)//不为null,说明已经点过赞了，可以取消点赞
            baseManager.delete(Praise2Product.class.getName(),praise2Product1.getId());
            product.setFsAmount(product.getFsAmount() == null ? 0 : product.getFsAmount() - 1);
            baseManager.saveOrUpdate(Product.class.getName(),product);
        }



        return true;
    }


}
