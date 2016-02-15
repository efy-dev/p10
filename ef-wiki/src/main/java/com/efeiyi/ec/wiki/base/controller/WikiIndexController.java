package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterFollowed;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectFollowed;
import com.efeiyi.ec.project.model.ProjectRecommended;
import com.efeiyi.ec.wiki.base.util.projectConvertprojectModelUtil;
import com.efeiyi.ec.wiki.model.ProductPraise;
import com.efeiyi.ec.wiki.model.ProductComment;
import com.efeiyi.ec.wiki.model.ProjectRecommendedModel;
import com.efeiyi.ec.wiki.organization.service.imp.UserManagerImpl;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.util.HttpUtil;
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
        UsernamePasswordAuthenticationToken com.efeiyi.ec.website.base.authentication = new UsernamePasswordAuthenticationToken(userDetails, userDetails.getPassword(),userDetails.getAuthorities());
        com.efeiyi.ec.website.base.authentication.setDetails(new WebAuthenticationDetails(request));
        SecurityContextHolder.getContext().setAuthentication(com.efeiyi.ec.website.base.authentication);
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
        if (request.getAttribute("flag")!=null && "2".equals(request.getAttribute("flag").toString())){
            return new ModelAndView("/hotProjects/PopularProjects2");
        }
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


    @RequestMapping("/IsattentionMaster.do")
    @ResponseBody
    public boolean IsattentionMaster(HttpServletRequest request) throws Exception {
        boolean flag = false;
        String masterId = request.getParameter("masterId");
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery xQuery = new XQuery("listMasterFollowed_check", request);
            xQuery.put("master_id", masterId);
            xQuery.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list = baseManager.listObject(xQuery);
            if (list!=null && !list.isEmpty()) {
                flag = true;
            }
        }

        return flag;
    }


    @RequestMapping("/attentionMaster.do")
    @ResponseBody
    public String saveMasterFollows(HttpServletRequest request) throws Exception {
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
                }else{
                    MasterFollowed masterFollowed = new MasterFollowed();
                    masterFollowed.setCreateDateTime(new Date());
                    masterFollowed.setMaster(master);
                    masterFollowed.setStatus("1");
                    masterFollowed.setUser(AuthorizationUtil.getUser());
                    //这里需要同步更新master的粉丝数量字段
                    baseManager.saveOrUpdate(MasterFollowed.class.getName(), masterFollowed);
                    master.setFsAmount(master.getFsAmount()==null?1:master.getFsAmount()+1);
                    baseManager.saveOrUpdate(Master.class.getName(),master);
                    return "true";
                }


        }



    }

    @RequestMapping("/saveThumbUp.do")
    @ResponseBody
    public String savaUP(HttpServletRequest request) throws Exception {
        String productId = request.getParameter("productId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        ProductPraise productPraise = new ProductPraise();
        String oper = request.getParameter("operation");
        if (oper != null && oper.equalsIgnoreCase("up")) {

            String queryHql = "from ProductPraise t where t.user.id=:userId and t.product.id=:productId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("productId", product.getId());
            ProductPraise p21 = (ProductPraise) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (p21 != null && p21.getId() != null)//不为null,说明已经点过赞了
            {
                return "repeat";
            }//防止重复点赞
            //productPraise.setUser((User)baseManager.getObject(User.class.getName(),user.getId()));
            productPraise.setUser(AuthorizationUtil.getUser());
            productPraise.setProduct(product);
            productPraise.setCreateDateTime(new Date());
            productPraise.setType("1");
            productPraise.setWatch("0");
            productPraise.setStatus("1");
            productPraise.setModerator(null);
            baseManager.saveOrUpdate(ProductPraise.class.getName(), productPraise);
            //product.setFsAmount(product.getFsAmount() == null ? 1 : product.getFsAmount() + 1);
            product.setAmount(product.getAmount() == null ? 1 : product.getAmount() + 1);
            baseManager.saveOrUpdate(Product.class.getName(), product);
        }


        if (oper != null && "down".equalsIgnoreCase(oper)) {
            String queryHql = "from ProductPraise t where t.user.id=:userId and t.product.id=:productId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("productId", product.getId());
            ProductPraise productPraise1 = (ProductPraise) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (productPraise1 != null && productPraise1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
                //baseManager.delete(ProductPraise.class.getName(), productPraise1.getId());
                  baseManager.remove(ProductPraise.class.getName(), productPraise1.getId());
            long FsAmount =0;
            if(product.getAmount() == null){
                FsAmount =0;
            }else  if(product.getAmount() - 1<=0){
                FsAmount =0;
            }else if (product.getAmount() - 1>=1){
                FsAmount =product.getAmount() - 1;
            }
            product.setAmount(FsAmount);
            baseManager.saveOrUpdate(Product.class.getName(), product);
        }


        return "true";
    }



    @RequestMapping("/commentUpAndDown.do")
    @ResponseBody
    public String commentUpAndDown(HttpServletRequest request) throws Exception {
        String productId = request.getParameter("productId");
        String commentId = request.getParameter("commentId");

        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        ProductComment productComment = (ProductComment) baseManager.getObject(ProductComment.class.getName(), commentId);
        ProductPraise productPraise = new ProductPraise();
        String oper = request.getParameter("operation");
        if (oper != null && oper.equalsIgnoreCase("up")) {

            String queryHql = "from ProductPraise t where t.user.id=:userId and t.comment.id=:commentId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            //map.put("productId", product.getId());
            map.put("commentId", commentId);
            ProductPraise p2 = (ProductPraise) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (p2 != null && p2.getId() != null)//不为null,说明已经点过赞了
            {
                return "repeat";
            }
            //防止重复点赞
            //productPraise.setUser((User)baseManager.getObject(User.class.getName(),user.getId()));
            productPraise.setUser(AuthorizationUtil.getUser());
            productPraise.setProduct(product);
            productPraise.setCreateDateTime(new Date());
            productPraise.setType("2");
            productPraise.setWatch("0");
            productPraise.setStatus("1");
            productPraise.setModerator(productComment.getUser());
            productPraise.setComment(productComment);
            baseManager.saveOrUpdate(ProductPraise.class.getName(), productPraise);
            productComment.setAmount(productComment.getAmount() == null ? 1 : productComment.getAmount() + 1);
            baseManager.saveOrUpdate(ProductComment.class.getName(), productComment);
        }


        if (oper != null && "down".equalsIgnoreCase(oper)) {
            String queryHql = "from ProductPraise t where t.user.id=:userId and t.product.id=:productId and t.comment.id=:commentId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("productId", product.getId());
            map.put("commentId", commentId);
            ProductPraise productPraise1 = (ProductPraise) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (productPraise1 != null && productPraise1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
                baseManager.remove(ProductPraise.class.getName(), productPraise1.getId());
            long Amount=0;
            if(productComment.getAmount() == null){
                Amount=0;
            }else if (productComment.getAmount() - 1<=0){
                Amount=0;
            }else if (productComment.getAmount() - 1>=1){
                Amount = productComment.getAmount() - 1;
            }
            productComment.setAmount(Amount);
            baseManager.saveOrUpdate(ProductComment.class.getName(), productComment);
        }


        return "true";
    }


    @RequestMapping("/afterAttention.do")
    @ResponseBody
    public  List afterAttention(HttpServletRequest request) throws Exception {
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
        if (projectFolloweds!=null &&!projectFolloweds.isEmpty()){
          for (ProjectFollowed projectFollowed : projectFolloweds) {
            Project project = projectFollowed.getProject();
            XQuery query = new XQuery("listProduct_after", request);
            query.put("project_id", project.getId());
            query.put("createDateTime",user.getLastLoginDatetime() );
            query.put("createDateTime2", user.getLastLogoutDatetime());
            List<Product> lp = baseManager.listObject(query);
            Integer num=0;
            if (lp!=null && !lp.isEmpty())
                num = lp.size();
            map.put(num.toString(),projectFollowed);
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


    public boolean IsattentionMaster2(HttpServletRequest request, String userid) throws Exception {
        boolean flag = false;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery xQuery = new XQuery("listMasterFollowed_check", request);
            xQuery.put("master_id", userid);
            xQuery.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list = baseManager.listObject(xQuery);
            if (list!=null && !list.isEmpty()) {
                flag = true;
            }
        }
        return flag;
    }


}