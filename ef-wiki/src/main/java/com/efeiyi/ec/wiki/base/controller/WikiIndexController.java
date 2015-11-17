package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterFollowed;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectFollowed;
import com.efeiyi.ec.project.model.ProjectRecommended;
import com.efeiyi.ec.wiki.base.util.projectConvertprojectModelUtil;
import com.efeiyi.ec.wiki.model.Praise2Product;
import com.efeiyi.ec.wiki.model.ProductComment;
import com.efeiyi.ec.wiki.model.ProductStore;
import com.efeiyi.ec.wiki.model.ProjectRecommendedModel;
import com.efeiyi.ec.wiki.organization.service.UserManager;
import com.efeiyi.ec.wiki.organization.service.imp.UserManagerImpl;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.util.HttpUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

    @Autowired
    UserManagerImpl userManager;
    /**
     * 非遗百科首页展示
     *
     * @param request is HttpServletRequest,model
     * @return "/wiki/showIndex"
     */
    @RequestMapping("/getTenant.do")
    public ModelAndView getTenant(HttpServletRequest request, Model model) throws Exception {
        logger.info("weiki  for efeiyi index begin...");

        model.addAttribute("bannerList", getWikiBannerList(request));
        model.addAttribute("projectList", getFeiyiProjectList(request));
        model.addAttribute("recommendProjectList", getRecommendProjectList());
        model.addAttribute("recommendTenantList", getRecommendTenantList());
        model.addAttribute("wondenfulProjectList", getWondenfulProjectList());
        model.addAttribute("wondenfulVideosList", getWondenfulVideosList());

        logger.info("weiki for efeiyi index end...");
        return new ModelAndView("/wiki/showIndex");

    }

    /**
     * 首页轮播图
     *
     * @param request is HttpServletRequest
     * @return bannerList
     * @throws Exception
     */
    public List getWikiBannerList(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listWikiBanner_default", request);
        return baseManager.listObject(xQuery);
    }

    /**
     * 非遗百科热门展示
     *
     * @param request is HttpServletRequest,model
     * @return "/wiki/showIndex"
     */
    @RequestMapping("/home.do")
    public ModelAndView getHotProjects(HttpServletRequest request, Model model) throws Exception {
        //为了测试方便，骗过CAS

       /* MyUser userDetails=null;

        try{
             userDetails = (MyUser)userManager.loadUserByUsername("admin");
        }catch (Exception e){

        }
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, userDetails.getPassword(),userDetails.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        HttpSession session = request.getSession(true);*/
       //欺诈结束




        if (!HttpUtil.isPhone(request.getHeader("User-Agent"))) {
            return new ModelAndView("redirect:/pc/index.do");
        }

        XQuery query = new XQuery("plistProjectRecommended_default", request);
        List<ProjectRecommended> list = baseManager.listObject(query);
        model.addAttribute("popularProjectsList", list);

        XQuery query2 = new XQuery("listProjectRecommended_default", request);
        //query2.put("groupName","attentionProject");
        List<ProjectRecommended> list2 = baseManager.listObject(query2);//增加是否已经关注逻辑
        List<ProjectRecommendedModel> list21  = projectConvertprojectModelUtil.getProjectRecommendedModels(list2);
        List<ProjectRecommendedModel> list22  = getProjectRecommendedModels(list21,request);

        model.addAttribute("attentionProjectsList", list22);

        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery query3 = new XQuery("listProjectFollowed_isShow", request);
            query3.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> projectFolloweds = baseManager.listObject(query3);
            if (projectFolloweds.size() >= 5) {
                model.addAttribute("isShow", "ok");
            } else {
                model.addAttribute("isShow", "no");
            }
              /* List hadAttentionProjects =  afterAttention(request,model);
            model.addAttribute("projectFolloweds", hadAttentionProjects);*/
        } else {
            model.addAttribute("isShow", "no");
        }
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
        model.addAttribute("basePath", basePath);
        return new ModelAndView("/hotProjects/PopularProjects");
    }

    @RequestMapping("/getHotProjects.do")
    public List getHotProjects(HttpServletRequest request) throws Exception {
        List list = getWondenfulProjectList();
        return list;
    }

    @RequestMapping("/getPerson.do")
    public ModelAndView getPersonCenter(HttpServletRequest request, Model model) throws Exception {
        return new ModelAndView("/personal/personalCenter");
    }

    @RequestMapping("/getPersonalInfo.do")
    public ModelAndView getPersonInfo(HttpServletRequest request, Model model) throws Exception {
        return new ModelAndView("/personal/personalInfoView");
    }

    @RequestMapping("/attention.do")
    @ResponseBody
    public String saveProjectFollows(HttpServletRequest request, Model model) throws Exception {
        String projectid = request.getParameter("projectId");
        String oper = request.getParameter("oper");
        Project project = (Project) baseManager.getObject(Project.class.getName(), projectid);
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }else{
            String queryHql = "from ProjectFollowed t where t.user.id=:userId and t.project.id=:projectId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("projectId", projectid);
            ProjectFollowed pf = (ProjectFollowed) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (pf != null && pf.getId() != null)//说明已经关注
            {
                //baseManager.delete(ProjectFollowed.class.getName(), pf.getId());
                baseManager.remove(ProjectFollowed.class.getName(), pf.getId());//假删
                long FsAmount =0;
                if(project.getFsAmount() == null){
                    FsAmount =0;
                }else  if(project.getFsAmount() - 1<=0){
                    FsAmount =0;
                }else if (project.getFsAmount() - 1>=1){
                    FsAmount =project.getFsAmount() - 1;
                }
                project.setFsAmount(FsAmount);
                baseManager.saveOrUpdate(Project.class.getName(),project);
                return "del";
            }else{
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

    @RequestMapping("/Isattention/{projectId}")
    @ResponseBody
    public boolean checkIsAttention(@PathVariable String projectId,HttpServletRequest request, Model model) throws Exception {
        boolean flag = false;
        //String projectid = request.getParameter("projectId");
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


    @RequestMapping("/brifProject/{projectId}/{page}")
    public ModelAndView getBrifProject(@PathVariable String projectId,@PathVariable String page,HttpServletRequest request, Model model) throws Exception {
        //String projectId = request.getParameter("projectId");
        //String page = request.getParameter("page");
        Project project = (Project) baseManager.getObject(Project.class.getName(), projectId);
        boolean flag = checkIsAttention(projectId,request, model);//判断用户是否已经关注该项目
        model.addAttribute("flag", flag);
        model.addAttribute("project", project);
        if(page!=null && page.equals("2")){
            return new ModelAndView("/project/brifProject2");
        }
        return new ModelAndView("/project/brifProject");
    }


    @RequestMapping("/IsattentionMaster.do")
    @ResponseBody
    public boolean IsattentionMaster(HttpServletRequest request, Model model) throws Exception {
        boolean flag = false;
        String masterId = request.getParameter("masterId");
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery xQuery = new XQuery("listMasterFollowed_check", request);
            xQuery.put("master_id", masterId);
            xQuery.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list = baseManager.listObject(xQuery);
            if (list != null && list.size() >= 1) {
                flag = true;
            }
        }

        return flag;
    }


    @RequestMapping("/attentionMaster.do")
    @ResponseBody
    public String saveMasterFollows(HttpServletRequest request, Model model) throws Exception {
        String masterId = request.getParameter("masterId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }else{
            Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);

            String queryHql = "from MasterFollowed t where t.user.id=:userId and t.master.id=:masterId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("masterId", masterId);
            MasterFollowed mf = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (mf != null && mf.getId() != null)//说明已经关注
            {
                //baseManager.delete(MasterFollowed.class.getName(), mf.getId());
                mf.setStatus("0");                                                      //假删除
                baseManager.saveOrUpdate(MasterFollowed.class.getName(),mf);
                long FsAmount =0;
                if(master.getFsAmount() == null){
                    FsAmount =0;
                }else  if(master.getFsAmount() - 1<=0){
                    FsAmount =0;
                }else if (master.getFsAmount() - 1>=1){
                    FsAmount =master.getFsAmount() - 1;
                }
                master.setFsAmount(FsAmount);
                baseManager.saveOrUpdate(Master.class.getName(),master);
                return "del";
            }else{//没有关注，可以关注
                MasterFollowed masterFollowed = new MasterFollowed();
                masterFollowed.setUser(user);
                masterFollowed.setCreateDateTime(new Date());
                masterFollowed.setMaster(master);
                masterFollowed.setStatus("1");
                masterFollowed.setUser(user);
                //这里需要同步更新master的粉丝数量字段
                baseManager.saveOrUpdate(MasterFollowed.class.getName(), masterFollowed);
                master.setFsAmount(master.getFsAmount()==null?1:master.getFsAmount()+1);
                baseManager.saveOrUpdate(Master.class.getName(),master);
                return "true";
            }

        }

    }

    @RequestMapping("/showProduct/{productId}")
    public ModelAndView showProduct(@PathVariable String productId, HttpServletRequest request, Model model) throws Exception {
        //String productId = request.getParameter("productId");
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        boolean flag = IsattentionMaster2(request, product.getMaster().getId());//判断用户是否已经关注该作品的大师
        model.addAttribute("flag", flag);
        model.addAttribute("product", product);
        if (AuthorizationUtil.getMyUser().getId() != null) {
            model.addAttribute("myUser", AuthorizationUtil.getMyUser());
        }
        return new ModelAndView("/product/brifProduct");
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


    @RequestMapping("/saveThumbUp.do")
    @ResponseBody
    public String savaUP(HttpServletRequest request, Model model) throws Exception {
        String productId = request.getParameter("productId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        Praise2Product praise2Product = new Praise2Product();
        String oper = request.getParameter("operation");
        if (oper != null && oper.equalsIgnoreCase("up")) {

            String queryHql = "from Praise2Product t where t.user.id=:userId and t.product.id=:productId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("productId", product.getId());
            Praise2Product p21 = (Praise2Product) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (p21 != null && p21.getId() != null)//不为null,说明已经点过赞了
            {
                return "repeat";
            }



            //防止重复点赞


            praise2Product.setUser(user);
            praise2Product.setProduct(product);
            praise2Product.setCreateDateTime(new Date());
            praise2Product.setType("1");
            praise2Product.setWatch("0");
            praise2Product.setStatus("1");
            praise2Product.setModerator(null);
            baseManager.saveOrUpdate(Praise2Product.class.getName(), praise2Product);
            //product.setFsAmount(product.getFsAmount() == null ? 1 : product.getFsAmount() + 1);
            product.setAmount(product.getAmount() == null ? 1 : product.getAmount() + 1);
            baseManager.saveOrUpdate(Product.class.getName(), product);
            System.out.println(product);
        }


        if (oper != null && oper.equalsIgnoreCase("down")) {
            String queryHql = "from Praise2Product t where t.user.id=:userId and t.product.id=:productId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("productId", product.getId());
            Praise2Product praise2Product1 = (Praise2Product) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (praise2Product1 != null && praise2Product1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
                //baseManager.delete(Praise2Product.class.getName(), praise2Product1.getId());
                  baseManager.remove(Praise2Product.class.getName(), praise2Product1.getId());
            long FsAmount =0;
            if(product.getAmount() == null){
                FsAmount =0;
            }else  if(product.getAmount() - 1<=0){
                FsAmount =0;
            }else if (product.getAmount() - 1>=1){
                FsAmount =product.getAmount() - 1;
            }
            //product.setFsAmount(product.getFsAmount() == null ? 0 : product.getFsAmount() - 1);
            //product.setFsAmount(FsAmount);
            product.setAmount(FsAmount);
            baseManager.saveOrUpdate(Product.class.getName(), product);
        }


        return "true";
    }



    @RequestMapping("/commentUpAndDown.do")
    @ResponseBody
    public String commentUpAndDown(HttpServletRequest request, Model model) throws Exception {
        String productId = request.getParameter("productId");
        String commentId = request.getParameter("commentId");

        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        ProductComment productComment = (ProductComment) baseManager.getObject(ProductComment.class.getName(), commentId);
        Praise2Product praise2Product = new Praise2Product();
        String oper = request.getParameter("operation");
        if (oper != null && oper.equalsIgnoreCase("up")) {

            //String queryHql = "from Praise2Product t where t.user.id=:userId and t.product.id=:productId and t.comment.id=:commentId";
            String queryHql = "from Praise2Product t where t.user.id=:userId and t.comment.id=:commentId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            //map.put("productId", product.getId());
            map.put("commentId", commentId);
            Praise2Product p2 = (Praise2Product) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (p2 != null && p2.getId() != null)//不为null,说明已经点过赞了
            {
                return "repeat";
            }
            //防止重复点赞



            praise2Product.setUser(user);
            praise2Product.setProduct(product);
            praise2Product.setCreateDateTime(new Date());
            praise2Product.setType("2");
            praise2Product.setWatch("0");
            praise2Product.setModerator(productComment.getUser());
            praise2Product.setComment(productComment);
            baseManager.saveOrUpdate(Praise2Product.class.getName(), praise2Product);
            productComment.setAmount(productComment.getAmount() == null ? 1 : productComment.getAmount() + 1);
            baseManager.saveOrUpdate(ProductComment.class.getName(), productComment);
        }


        if (oper != null && oper.equalsIgnoreCase("down")) {
            String queryHql = "from Praise2Product t where t.user.id=:userId and t.product.id=:productId and t.comment.id=:commentId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("productId", product.getId());
            map.put("commentId", commentId);
            Praise2Product praise2Product1 = (Praise2Product) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (praise2Product1 != null && praise2Product1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
                //baseManager.delete(Praise2Product.class.getName(), praise2Product1.getId());
                baseManager.remove(Praise2Product.class.getName(), praise2Product1.getId());
            long Amount=0;
            if(productComment.getAmount() == null){
                Amount=0;
            }else if (productComment.getAmount() - 1<=0){
                Amount=0;
            }else if (productComment.getAmount() - 1>=1){
                Amount = productComment.getAmount() - 1;
            }
            //productComment.setAmount(productComment.getAmount() == null ? 0 : productComment.getAmount() - 1);
            productComment.setAmount(Amount);
            baseManager.saveOrUpdate(ProductComment.class.getName(), productComment);
        }


        return "true";
    }


    @RequestMapping("/storeProduct.do")
    @ResponseBody
    public String storeProduct(HttpServletRequest request, Model model) throws Exception {
        String productId = request.getParameter("productId");
        ProductStore productStore = new ProductStore();
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }


        if (user.getId() != null) {
            String queryHql = "from ProductStore t where t.user.id=:userId and t.product.id=:productId";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("productId", productId);
            ProductStore ps = (ProductStore) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (ps != null && ps.getId() != null){
               return "repeat" ;
            }//不为null,说明已经收藏了
        }
        productStore.setUser(user);
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        productStore.setProduct(product);
        productStore.setStatus("1");
        productStore.setCreateDateTime(new Date());
        baseManager.saveOrUpdate(ProductStore.class.getName(), productStore);

        return "true";
    }


    @RequestMapping("/afterAttention.do")
    @ResponseBody
    public  List afterAttention(HttpServletRequest request, Model model) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return new ArrayList();
        }
        XQuery query3 = new XQuery("plistProjectFollowed_after", request);
        query3.put("user_id", AuthorizationUtil.getMyUser().getId());
        PageInfo pageInfo = baseManager.listPageInfo(query3);
        List<ProjectFollowed> projectFolloweds = pageInfo.getList();
        HashMap<String,ProjectFollowed> map = new HashMap<String,ProjectFollowed>();
        List<HashMap<String,ProjectFollowed>> res = new ArrayList<HashMap<String,ProjectFollowed>>();
        if (projectFolloweds!=null && projectFolloweds.size()>=1){
          for (ProjectFollowed projectFollowed : projectFolloweds) {
            Project project = projectFollowed.getProject();
            XQuery query = new XQuery("listProduct_after", request);
            query.put("project_id", project.getId());
            query.put("createDateTime",user.getLastLoginDatetime() );
            query.put("createDateTime2", user.getLastLogoutDatetime());
            List<Product> lp = baseManager.listObject(query);
            int num=0;
            if (lp!=null && lp.size()>=1)
                num = lp.size();
            map.put(num+"",projectFollowed);
            res.add(map);
         }
        }
     return res;
    }

    public  List<ProjectRecommendedModel> getProjectRecommendedModels(List<ProjectRecommendedModel> projectRecommendedModels,HttpServletRequest request) throws Exception {
        List<ProjectRecommendedModel> list = projectRecommendedModels;

        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery query = new XQuery("listProjectFollowed_isShow", request);
            query.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> projectFolloweds = baseManager.listObject(query);
        for (ProjectRecommendedModel projectRecommendedModel : projectRecommendedModels){
            for (ProjectFollowed projectFollowed : projectFolloweds){
              if(projectRecommendedModel.getProject().getId().equals(projectFollowed.getProject().getId())){
                  projectRecommendedModel.setAttention("1");
              }

            }
        }

        }
        return list;
    }





}