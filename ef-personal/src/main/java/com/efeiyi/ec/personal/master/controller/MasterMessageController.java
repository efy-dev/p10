package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.organization.model.AddressProvince;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.efeiyi.ec.personal.ConvertMasterModelUtil;
import com.efeiyi.ec.personal.master.model.MasterModel;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.taglib.PageEntity;
import org.apache.log4j.Logger;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/9/21.
 */

@Controller
@RequestMapping("/masterMessage")
public class MasterMessageController {
    private static Logger log = Logger.getLogger(MasterMessageController.class);

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/index.do")
    public String mainPage(HttpServletRequest request, Model model) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        if (user != null && user.getId() != null) {
            XQuery xQuery = new XQuery("listMasterFollow_default", request);
            xQuery.put("user_id", user.getId());
            List<MasterFollowed> list = baseManager.listObject(xQuery);
            if (list != null && list.size() > 0) {
                model.addAttribute("result", "show");
            } else {
                model.addAttribute("result", "hide");
            }
        } else {
            model.addAttribute("result", "hide");
        }
        return "/masterMessage/masterMessageList";
    }

    @ResponseBody
    @RequestMapping("/masterMessageList/{qm}/{size}/{index}")
    public List MasterMessagePList(HttpServletRequest request, @PathVariable String qm, @PathVariable String size, @PathVariable String index) throws Exception {
        XQuery xQuery = new XQuery(qm, request);
        MyUser user = AuthorizationUtil.getMyUser();
        PageEntity pageEntity = new PageEntity();
        if (index != null) {
            pageEntity.setIndex(Integer.parseInt(index));
            pageEntity.setSize(Integer.parseInt(size));
        }
        xQuery.setPageEntity(pageEntity);
        PageInfo pageInfo = baseManager.listPageInfo(xQuery);
        List<MasterMessage> messageList = pageInfo.getList();
        List<MasterModel> msgList = new ArrayList<>();
        if (messageList != null && messageList.size() > 0) {
            for (MasterMessage message : messageList) {
                message.getMaster().setFollowStatus(getFollowStatus(message.getMaster(), (User) baseManager.getObject(User.class.getName(),user.getId())));
                message.setFollowStatus(message.getMaster().getFollowStatus());
                message.setPraiseStatus(getPraiseStatus(message, (User) baseManager.getObject(User.class.getName(),user.getId())));
                message.setMasterId(message.getMaster().getId());
                message.setMasterName(message.getMaster().getFullName());
                message.setAmount(message.getAmount() == null ? 0 : message.getAmount());
                message.setFsAmount(message.getFsAmount() == null ? 0 : message.getFsAmount());
                MasterModel msgModel = ConvertMasterModelUtil.convertMasterModel(message);
                msgList.add(msgModel);
            }
        }
        return msgList;
    }

    @RequestMapping("/getOnlyMasterMessageList.do")
    public String getMaster(HttpServletRequest request, Model model) {
        String masterId = request.getParameter("masterId");
        String queryHql = "from MasterMessage m where m.master.id=:masterId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("masterId", masterId);
        List<MasterMessage> list = baseManager.listObject(queryHql, queryMap);
        Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
        model.addAttribute("objectList", list);
        model.addAttribute("object", master);
        return "/masterMessage/masterMessageListView";
    }

    @RequestMapping("/getMasterMessage.do")
    public String getMasterMessage(HttpServletRequest request, Model model) {
        String messageId = request.getParameter("messageId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (!StringTools.isEmpty(messageId)) {
            MasterMessage message = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(), messageId);
            message.setFollowStatus(getMasterFollowedStatus(message.getMaster()));
            model.addAttribute("object", message);
            model.addAttribute("myUser", user);
        }
        return "/masterMessage/masterMessageView";
    }

    public String getMasterFollowedStatus(Master master) {
        String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.status='1'";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("masterId", master.getId());
        List<MasterFollowed> list = baseManager.listObject(queryHql, queryMap);
        if (list != null && list.size() > 0) {
            master.setFollowStatus("已关注");
        } else {
            master.setFollowStatus("关注");
        }
        return master.getFollowStatus();
    }

    public String getPraiseStatus(MasterMessage message, User user) {
        String queryHql = "from MasterMessagePraise p where p.message.id=:messageId and p.user.id=:userId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("messageId", message.getId());
        queryMap.put("userId", user.getId());
        List<MasterMessagePraise> list = baseManager.listObject(queryHql, queryMap);
        if (list != null && list.size() > 0) {
            message.setPraiseStatus("取消赞");
        } else {
            message.setPraiseStatus("赞");
        }
        return message.getPraiseStatus();
    }

    @RequestMapping("/forwardMasterDetails.do")
    public String forwardDetails(HttpServletRequest request, Model model) {
        String masterId = request.getParameter("masterId");
        Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
        model.addAttribute("object", master);
        return "/masterMessage/masterMessageDetails";
    }

    @ResponseBody
    @RequestMapping("/getMasterDetails.do")
    public List getMasterDetails(HttpServletRequest request) {
        String masterId = request.getParameter("masterId");
        Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
        master.setProjectName(mainMasterProject(master.getMasterProjectList()));
        String queryHql = "from MasterMessage m where m.master.id=:masterId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("masterId", master.getId());
        List<MasterMessage> list = baseManager.listObject(queryHql, queryMap);
        MyUser user = AuthorizationUtil.getMyUser();
        if (list != null && list.size() > 0) {
            for (MasterMessage message : list) {
                String queryHql1 = "from MasterMessagePraise m where m.message.id=:messageId and m.user.id=:userId";
                LinkedHashMap<String, Object> queryMap1 = new LinkedHashMap<>();
                queryMap1.put("messageId", message.getId());
                queryMap1.put("userId", user.getId());
                List<MasterMessagePraise> praiseList = baseManager.listObject(queryHql1, queryMap1);
                if (praiseList != null && praiseList.size() > 0) {
                    message.setPraiseStatus("取消赞");
                } else {
                    message.setPraiseStatus("赞");
                }
                message.setAmount(message.getAmount() == null ? 0 : message.getAmount());
                String querySql = "from MasterMessageStore m where m.masterMessage.id=:messageId and m.user.id=:userId";
                LinkedHashMap<String, Object> query = new LinkedHashMap<>();
                query.put("messageId", message.getId());
                query.put("userId", user.getId());
                List<MasterMessageStore> storeList = baseManager.listObject(querySql, query);
                if (storeList != null && storeList.size() > 0) {
                    message.setStoreStatus("已收藏");
                } else {
                    message.setStoreStatus("收藏");
                }
            }
        }
        return list;
    }

    public String mainMasterProject(List<MasterProject> masterProjects) {

        MasterProject masterProject = null;

        if (masterProjects != null && masterProjects.size() > 0) {

            for (MasterProject masterProjectTemp : masterProjects) {
                if (masterProjectTemp.getStatus().equals("1")) {
                    masterProject = masterProjectTemp;
                }
            }
            if (masterProject == null) {
                masterProject = masterProjects.get(0);
            }

            return masterProject.getProject().getName();
        } else {

            return "";
        }
    }

    @RequestMapping("/commentUpAndDown.do")
    @ResponseBody
    public String commentUpAndDown(HttpServletRequest request) throws Exception {
        String commentId = request.getParameter("commentId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }
        MasterComment comment = (MasterComment) baseManager.getObject(MasterComment.class.getName(), commentId);
        MasterMessagePraise praise = new MasterMessagePraise();
        String oper = request.getParameter("operation");
        if (oper != null && oper.equalsIgnoreCase("up")) {
            String queryHql = "from MasterMessagePraise t where t.user.id=:userId and t.comment.id=:commentId";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("commentId", commentId);
//			List<MasterWorkPraise> list = baseManager.listObject(queryHql,map);

            MasterMessagePraise p2 = (MasterMessagePraise) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (p2 != null && p2.getId() != null)//不为null,说明已经点过赞了
            {
                return "repeat";
            }
            //防止重复点赞
            praise.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
            praise.setCreateDateTime(new Date());
            praise.setComment(comment);
            baseManager.saveOrUpdate(MasterMessagePraise.class.getName(), praise);
            comment.setAmount(comment.getAmount() == null ? 1 : comment.getAmount() + 1);
            baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
        }

        if (oper != null && oper.equalsIgnoreCase("down")) {
            String queryHql = "from MasterMessagePraise t where t.user.id=:userId and t.comment.id=:commentId";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("commentId", commentId);
            MasterMessagePraise praise1 = (MasterMessagePraise) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (praise1 != null && praise1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
                baseManager.delete(MasterMessagePraise.class.getName(), praise1.getId());

            int Amount = 0;
            if (comment.getAmount() == null) {
                Amount = 0;
            } else if (comment.getAmount() - 1 <= 0) {
                Amount = 0;
            } else if (comment.getAmount() - 1 >= 1) {
                Amount = comment.getAmount() - 1;
            }
            comment.setAmount(Amount);
            baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
        }
        return "true";
    }

    @RequestMapping("/saveThumbUp.do")
    @ResponseBody
    public String savaUP(HttpServletRequest request) throws Exception {
        String msgId = request.getParameter("msgId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }
        MasterMessage msg = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(), msgId);
        MasterMessagePraise praise = new MasterMessagePraise();
        String oper = request.getParameter("operation");
        if (oper != null && oper.equalsIgnoreCase("up")) {

            String queryHql = "from MasterMessagePraise t where t.user.id=:userId and t.message.id=:workId";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("workId", msg.getId());
            MasterMessagePraise praise1 = (MasterMessagePraise) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (praise1 != null && praise1.getId() != null)//不为null,说明已经点过赞了
            {
                return "repeat";
            }


            //防止重复点赞


            praise.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
            praise.setMessage(msg);
            praise.setCreateDateTime(new Date());
            baseManager.saveOrUpdate(MasterMessagePraise.class.getName(), praise);
            msg.setFsAmount(msg.getFsAmount() == null ? 1 : msg.getFsAmount() + 1);
            baseManager.saveOrUpdate(MasterMessage.class.getName(), msg);
        }


        if (oper != null && oper.equalsIgnoreCase("down")) {
            String queryHql = "from MasterMessagePraise t where t.user.id=:userId and t.message.id=:workId";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("workId", msg.getId());
            MasterMessagePraise praise1 = (MasterMessagePraise) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (praise1 != null && praise1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
                baseManager.delete(MasterMessagePraise.class.getName(), praise1.getId());
            int FsAmount = 0;
            if (msg.getFsAmount() == null) {
                FsAmount = 0;
            } else if (msg.getFsAmount() - 1 <= 0) {
                FsAmount = 0;
            } else if (msg.getFsAmount() - 1 >= 1) {
                FsAmount = msg.getFsAmount() - 1;
            }
            msg.setFsAmount(FsAmount);
            baseManager.saveOrUpdate(MasterMessage.class.getName(), msg);
        }


        return "true";
    }

    @RequestMapping("/storeWork.do")
    @ResponseBody
    public String storeWork(HttpServletRequest request) throws Exception {
        String msgId = request.getParameter("msgId");
        MasterMessageStore store = new MasterMessageStore();
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }
        if (user.getId() != null) {
            String queryHql = "from MasterMessageStore t where t.user.id=:userId and t.masterMessage.id=:workId";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("workId", msgId);
            MasterMessageStore ps = (MasterMessageStore) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (ps != null && ps.getId() != null) {
                return "repeat";
            }//不为null,说明已经收藏了
        }
        store.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
        MasterMessage work = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(), msgId);
        store.setMasterMessage(work);
        store.setStatus("1");
        store.setCreateDateTime(new Date());
        baseManager.saveOrUpdate(MasterMessageStore.class.getName(), store);
        return "true";
    }

    @ResponseBody
    @RequestMapping("/userComments")
    public String getUserComments() {

        return null;
    }

    @ResponseBody
    @RequestMapping("/userPraises")
    public String getUserPraises() {

        return null;
    }

	/*--------------PC-Start--------------*/

    @ResponseBody
    @RequestMapping("/mainData/{qm}/{conditions}/{size}/{index}")
    public List getMainMessage(HttpServletRequest request, @PathVariable String qm, @PathVariable String conditions, @PathVariable String size, @PathVariable String index) throws Exception {
        if (null == qm || "".equalsIgnoreCase(qm)) {
            qm = "plistMasterMessage_default";
        }
        XQuery query = new XQuery(qm, request);
        if (!"0".equals(conditions)) {
            String[] attr = conditions.split(":");
            query.put("master_id", attr[1].substring(0, attr[1].length()));
        }
        PageEntity pageEntity = new PageEntity();
        if (index != null) {
            pageEntity.setIndex(Integer.parseInt(index));
            pageEntity.setSize(Integer.parseInt(size));
        }
        query.setPageEntity(pageEntity);
        PageInfo pageInfo = baseManager.listPageInfo(query);
        List<MasterModel> list = new ArrayList<>();
        MyUser user = AuthorizationUtil.getMyUser();
        if (pageInfo.getList() != null && pageInfo.getList().size() > 0) {
            List<MasterMessage> list1 = pageInfo.getList();
            for (MasterMessage message : list1) {
                if (user.getId() != null) {
                    String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status = '1'";
                    LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
                    queryMap.put("masterId", message.getMaster().getId());
                    queryMap.put("userId", user.getId());
                    MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
                    if (followed != null) {
                        message.setFollowStatus("已关注");
                    } else {
                        message.setFollowStatus("关注");
                    }
                    message.setPraiseStatus("赞");
                    String sql = "from MasterMessageStore p where p.user.id=:userId and p.masterMessage.id=:msgId and p.status = '1'";
                    queryMap.clear();
                    queryMap.put("userId", user.getId());
                    queryMap.put("msgId", message.getId());
                    MasterMessageStore store = (MasterMessageStore) baseManager.getUniqueObjectByConditions(sql, queryMap);
                    if (store != null) {
                        message.setStoreStatus("已收藏");
                    } else {
                        message.setStoreStatus("收藏");
                    }
                } else {
                    message.setFollowStatus("关注");
                    message.setPraiseStatus("赞");
                    message.setStoreStatus("收藏");
                }
                MasterModel masterModel = ConvertMasterModelUtil.convertMasterModel(message);
                list.add(masterModel);
            }
        }
        return list;
    }

    @ResponseBody
    @RequestMapping("subMaster/{qm}/{size}/{index}")
    public List getSubMaster(HttpServletRequest request, @PathVariable String qm, @PathVariable String size, @PathVariable String index) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        if (null == qm || "".equalsIgnoreCase(qm)) {
            qm = "plistMaster_default";
        }
        XQuery query = new XQuery(qm, request);
        PageEntity pageEntity = new PageEntity();
        if (index != null) {
            pageEntity.setIndex(Integer.parseInt(index));
            pageEntity.setSize(Integer.parseInt(size));
        }
        query.setPageEntity(pageEntity);
        PageInfo pageInfo = baseManager.listPageInfo(query);
        List<MasterModel> list = new ArrayList<>();
        if (pageInfo.getList() != null && pageInfo.getList().size() > 0) {
            List<Master> list1 = pageInfo.getList();
            for (Master master : list1) {
                if (user != null) {
                    String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status = '1'";
                    LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
                    queryMap.put("masterId", master.getId());
                    queryMap.put("userId", user.getId());
                    MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
                    if (followed != null) {
                        master.setFollowStatus("已关注");
                    } else {
                        master.setFollowStatus("关注");
                    }
                } else {
                    master.setFollowStatus("关注");
                }
                XQuery xQuery = new XQuery("listMasterProject_byMaster", request);
                xQuery.put("master_id", master.getId());
                List<MasterProject> projectList = baseManager.listObject(xQuery);
                if (projectList != null && projectList.size() > 0) {
                    master.setProjectName(mainMasterProject(projectList));
                }
                MasterModel masterModel = ConvertMasterModelUtil.convertMaster(master);
                list.add(masterModel);
            }
        }
        return list;
    }

    @ResponseBody
    @RequestMapping("/hotMaster/{qm}/{size}/{index}")
    public List getRecommendMaster(HttpServletRequest request, @PathVariable String qm, @PathVariable String size, @PathVariable String index) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
//		String qm = request.getParameter("qm");
        if (null == qm || "".equalsIgnoreCase(qm)) {
            qm = "plistMasterRecommend_group";
        }
        XQuery query = new XQuery(qm, request);
        PageEntity pageEntity = new PageEntity();
//		String pageIndex = request.getParameter("pageEntity.index");
//		String pageSize = request.getParameter("pageEntity.size");
        if (index != null) {
            pageEntity.setIndex(Integer.parseInt(index));
            pageEntity.setSize(Integer.parseInt(size));
        }
        query.setPageEntity(pageEntity);
        PageInfo pageInfo = baseManager.listPageInfo(query);
        List<MasterModel> list = new ArrayList<>();
        if (pageInfo.getList() != null && pageInfo.getList().size() > 0) {
            List<MasterRecommended> list1 = pageInfo.getList();
            for (MasterRecommended recommended : list1) {
                if (user != null) {
                    String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status = '1'";
                    LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
                    queryMap.put("masterId", recommended.getMaster().getId());
                    queryMap.put("userId", user.getId());
                    MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
                    if (followed != null) {
                        recommended.getMaster().setFollowStatus("已关注");
                    } else {
                        recommended.getMaster().setFollowStatus("关注");
                    }
                } else {
                    recommended.getMaster().setFollowStatus("关注");
                }
                XQuery xQuery = new XQuery("listMasterProject_byMaster", request);
                xQuery.put("master_id", recommended.getMaster().getId());
                List<MasterProject> projectList = baseManager.listObject(xQuery);
                if (projectList != null && projectList.size() > 0) {
                    recommended.getMaster().setProjectName(mainMasterProject(projectList));
                }
                MasterModel masterModel = ConvertMasterModelUtil.convertMaster(recommended.getMaster());
                list.add(masterModel);
            }
        }
        return list;
    }

    @ResponseBody
    @RequestMapping("/followMaster.do")
    public String followMaster(HttpServletRequest request) {
        String masterId = request.getParameter("masterId");
        Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
        MyUser user = AuthorizationUtil.getMyUser();
        if (user != null && user.getId() != null) {
            String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status = '1'";
            LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
            queryMap.put("masterId", masterId);
            queryMap.put("userId", user.getId());
            MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
            if (followed == null || followed.getId() == null) {
                MasterFollowed follow = new MasterFollowed();
                follow.setCreateDateTime(new Date());
                follow.setMaster(master);
                follow.setStatus("1");
                follow.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
                baseManager.saveOrUpdate(MasterFollowed.class.getName(), follow);
                master.setFsAmount(master.getFsAmount() == null ? 1 : master.getFsAmount() + 1);
                baseManager.saveOrUpdate(Master.class.getName(), master);
                return "add";
            } else {
                baseManager.delete(MasterFollowed.class.getName(), followed.getId());
                master.setFsAmount(master.getFsAmount() == null ? 0 : master.getFsAmount() - 1);
                baseManager.saveOrUpdate(Master.class.getName(), master);
                return "del";
            }
        } else {
            return "noRole";
        }
    }

    @RequestMapping("/getMessageView/{msgId}")
    public String forwardMessageViewPage(@PathVariable String msgId, Model model) {
//		String msgId = request.getParameter("msgId");
        MasterMessage msg = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(), msgId);
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        String queryHql1 = "from MasterProject p where p.master.id=:masterId and p.status='1'";
        queryMap.put("masterId", msg.getMaster().getId());
        List<MasterProject> projects = baseManager.listObject(queryHql1, queryMap);
        msg.getMaster().setProjectName(mainMasterProject(projects));
        MyUser user = AuthorizationUtil.getMyUser();
        if (user == null || user.getId() == null) {
            msg.getMaster().setFollowStatus("关注");
            msg.setPraiseNum(msg.getPraiseNum() == null ? 0 : msg.getPraiseNum());
            model.addAttribute("result", "收藏");
        } else {
            String queryHql2 = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status = '1'";
            queryMap.clear();
            queryMap.put("masterId", msg.getMaster().getId());
            queryMap.put("userId", user.getId());
            MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql2, queryMap);
            if (followed != null && followed.getId() != null) {
                msg.getMaster().setFollowStatus("已关注");
            } else {
                msg.getMaster().setFollowStatus("关注");
            }
            String querHql = "from MasterMessageStore f where f.masterMessage.id=:msgId and f.user.id=:userId and f.status = '1'";
            queryMap.clear();
            queryMap.put("msgId", msg.getId());
            queryMap.put("userId", user.getId());
            MasterMessageStore store = (MasterMessageStore) baseManager.getUniqueObjectByConditions(querHql, queryMap);
            if (store != null && store.getId() != null) {
                model.addAttribute("result", "已收藏");
            } else {
                model.addAttribute("result", "收藏");
            }
        }
        model.addAttribute("msg", msg);
        String queryHql = "from MasterComment c where c.masterMessage.id =:msgId order by createDateTime Desc";
        queryMap.clear();
        queryMap.put("msgId", msgId);
        List<MasterComment> list = baseManager.listObject(queryHql, queryMap);
        if (list != null && list.size() > 0) {
            model.addAttribute("commentList", list);
        }
        return "/masterMessage/masterMessageDatils";
    }

    @ResponseBody
    @RequestMapping("/getSubCommentList.do")
    public List getSubCommentListByFatherId(HttpServletRequest request) {
        String fatherId = request.getParameter("fatherId");
        String queryHql = "from MasterComment c where c.fatherComment.id=:fatherId order by createDateTime Desc";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("fatherId", fatherId);
        List<MasterComment> list = baseManager.listObject(queryHql, queryMap);
        if (list != null && list.size() > 0) {
            return list;
        } else {
            return new ArrayList<>();
        }
    }

    @RequestMapping("/masterView/{masterId}")
    public String masterView(@PathVariable String masterId, Model model) {
//		String masterId = request.getParameter("masterId");
        MyUser user = AuthorizationUtil.getMyUser();
        Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
        if (user != null && user.getId() != null) {
            String query = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status = '1'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("masterId", masterId);
            map.put("userId", user.getId());
            MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(query, map);
            if (followed != null) {
                master.setFollowStatus("已关注");
            }
            if (followed == null || followed.getId() == null) {
                master.setFollowStatus("关注");
            }
        } else {
            master.setFollowStatus("关注");
        }
        master.setProjectName(mainMasterProject(master.getMasterProjectList()));
        master.setFsAmount(master.getFsAmount() == null ? 0 : master.getFsAmount());
        String queryHql = "from MasterWork f where f.master.id =:masterId";
        LinkedHashMap<String, Object> map = new LinkedHashMap<>();
        map.put("masterId", masterId);
        List<MasterWork> list = baseManager.listObject(queryHql, map);
        model.addAttribute("workList", list);
        model.addAttribute("object", master);
        return "/masterDetails/masterDetails";
    }

    @RequestMapping("/introView/{masterId}")
    public String introductionView(HttpServletRequest request, @PathVariable String masterId, Model model) throws Exception {
        //String masterId = request.getParameter("masterId");
        Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
        MyUser user = AuthorizationUtil.getMyUser();
        if (user != null && user.getId() != null) {
            String query = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status = '1'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("masterId", masterId);
            map.put("userId", user.getId());
            MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(query, map);
            if (followed != null) {
                master.setFollowStatus("已关注");
            }
            if (followed == null || followed.getId() == null) {
                master.setFollowStatus("关注");
            }
        } else {
            master.setFollowStatus("关注");
        }
        master.setProjectName(mainMasterProject(master.getMasterProjectList()));
        master.setFsAmount(master.getFsAmount() == null ? 0 : master.getFsAmount());
        XQuery xQuery = new XQuery("listMasterBanner_default", request);
        XQuery query = new XQuery("listMasterIntroduction_default", request);
        xQuery.put("master_id", master.getId());
        query.put("master_id", master.getId());
        List<MasterIntroduction> list = baseManager.listObject(query);
        if (!StringTools.isEmpty(list)) {
            for (MasterIntroduction intro : list) {
                if ("1".equals(intro.getType())) {
                    model.addAttribute("baseIntro", intro);
                }
            }
        }
        model.addAttribute("object", master);
        model.addAttribute("introductionList", baseManager.listObject(query));
        model.addAttribute("bannerList", baseManager.listObject(xQuery));
        return "/masterDetails/masterIntroduction";
    }

    @RequestMapping("/classify")
    public String classify(HttpServletRequest request, Model model) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        if (user != null && user.getId() != null) {
            XQuery xQuery = new XQuery("listMasterFollow_default", request);
            xQuery.put("user_id", user.getId());
            List<MasterFollowed> list = baseManager.listObject(xQuery);
            if (list != null && list.size() > 0) {
                model.addAttribute("result", "show");
            } else {
                model.addAttribute("result", "hide");
            }
        } else {
            model.addAttribute("result", "hide");
        }
        XQuery xQuery = new XQuery("listMasterProject_default", request);
        List<MasterProject> list = baseManager.listObject(xQuery);
        XQuery xQuery2 = new XQuery("listAddressProvince_asc", request);
        List<AddressProvince> list2 = baseManager.listObject(xQuery2);
        model.addAttribute("categoryList", list);
        model.addAttribute("cityList", list2);
        return "/classify/masterClassify";
    }

    /****************************
     * 作品
     **************/

    public String getFollowStatus(Master master, User user) {
        if (user != null && user.getId() != null) {
            String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status='1'";
            LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
            queryMap.put("masterId", master.getId());
            queryMap.put("userId", user.getId());
            MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
            if (followed != null) {
                master.setFollowStatus("已关注");
            } else {
                master.setFollowStatus("关注");
            }
        } else {
            master.setFollowStatus("关注");
        }
        return master.getFollowStatus();
    }

    @RequestMapping("/getFollowBeforeList")
    public String getNoFollowMaster(HttpServletRequest request, Model model) throws Exception {
        List<MasterModel> list = marge(request);
        model.addAttribute("list", list);
        return "/masterFollowed/masterFollowedBefore";
    }

    public List marge(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listMasterRecommend_default", request);
        List<MasterRecommended> list = baseManager.listObject(xQuery);
        List<MasterModel> masters = new ArrayList<>();
        if (list != null && list.size() > 0) {
            for (MasterRecommended recommended : list) {
                recommended.getMaster().setProjectName(mainMasterProject(recommended.getMaster().getMasterProjectList()));
                MasterModel masterModel = ConvertMasterModelUtil.convertMaster(recommended.getMaster());
                masters.add(masterModel);
            }
        }
        return masters;
    }

    @RequestMapping("/forwardUrl")
    public String forwardUrl() {
        return "/masterFollowed/masterFollowedAfter";
    }

    @ResponseBody
    @RequestMapping("/getFollowAfterList/{qm}/{size}/{index}")
    public List getShowFollowMaster(HttpServletRequest request, @PathVariable String qm, @PathVariable String size, @PathVariable String index) throws Exception {
        if (null == qm || "".equalsIgnoreCase(qm)) {
            qm = "plistMasterFollow_default";
        }
        XQuery query = new XQuery(qm, request);
        query.put("user_id", AuthorizationUtil.getUser().getId());
        PageEntity pageEntity = new PageEntity();
        if (index != null) {
            pageEntity.setIndex(Integer.parseInt(index));
            pageEntity.setSize(Integer.parseInt(size));
        }
        query.setPageEntity(pageEntity);
        PageInfo pageInfo = baseManager.listPageInfo(query);
        List<MasterModel> list = new ArrayList<>();
        if (pageInfo.getList() != null && pageInfo.getList().size() > 0) {
            List<MasterFollowed> list1 = pageInfo.getList();
            for (MasterFollowed followed : list1) {
                String masterId = followed.getMaster().getId();
                XQuery xQuery = new XQuery("plistMasterMessage_default1", request);
                xQuery.put("master_id", masterId);
                //xQuery.put("creator_id",followed.getUser().getId());
                List<MasterMessage> list2 = baseManager.listObject(xQuery);
                if (list2 != null && list2.size() > 0) {
                    for (MasterMessage message : list2) {
                        message.setFollowStatus("已关注");
                        String sql = "from MasterMessageStore p where p.user.id=:userId and p.masterMessage.id=:msgId and p.status = '1'";
                        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
                        queryMap.put("userId", AuthorizationUtil.getUser().getId());
                        queryMap.put("msgId", message.getId());
                        MasterMessageStore store = (MasterMessageStore) baseManager.getUniqueObjectByConditions(sql, queryMap);
                        if (store != null) {
                            message.setStoreStatus("已收藏");
                        } else {
                            message.setStoreStatus("收藏");
                        }
                        MasterModel masterModel = ConvertMasterModelUtil.convertMasterModel(message);
                        list.add(masterModel);
                    }
                }

            }
        }
        return list;
    }

    @RequestMapping("/getPartWorks/{masterId}")
    public String getPartMasterWork(@PathVariable String masterId, Model model) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
        master.setProjectName(mainMasterProject(master.getMasterProjectList()));
        master.setFollowStatus(getFollowStatus(master, (User) baseManager.getObject(User.class.getName(),user.getId())));
        MasterModel mmd = ConvertMasterModelUtil.convertMaster(master);
        model.addAttribute("object", mmd);
        return "/masterDetails/masterWorkList";
    }

    @RequestMapping("/getWorkDetails/{workId}")
    public String getMasterWorkDetails(HttpServletRequest request, @PathVariable String workId, Model model) throws Exception {
        MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(), workId);
        work.getMaster().setProjectName(mainMasterProject(work.getMaster().getMasterProjectList()));
        MyUser user = AuthorizationUtil.getMyUser();
        XQuery xQuery = new XQuery("listMasterWorkStore_default", request);
        xQuery.put("work_id", workId);
        xQuery.put("user_id", user.getId());
        List<MasterWorkStore> list = baseManager.listObject(xQuery);
        if (list != null && list.size() > 0) {
            work.setStoreStatus("已收藏");
        } else {
            work.setStoreStatus("收藏");
        }
        work.getMaster().setFollowStatus(getFollowStatus(work.getMaster(), (User) baseManager.getObject(User.class.getName(),user.getId())));
        MasterModel workModel = ConvertMasterModelUtil.convertWork(work);
        model.addAttribute("object", work.getMaster());
        model.addAttribute("work", workModel);
        return "/masterDetails/masterWorkView";
    }

    @ResponseBody
    @RequestMapping("/getWorkComment/{qm}/{msgId}/{size}/{index}")
    public List getWorkComment(HttpServletRequest request, @PathVariable String qm, @PathVariable String msgId, @PathVariable String size, @PathVariable String index) throws Exception {
        XQuery xQuery = new XQuery(qm, request);
        xQuery.put("masterWork_id", msgId);
        PageEntity entity = new PageEntity();
        if (index != null) {
            entity.setIndex(Integer.parseInt(index));
            entity.setSize(Integer.parseInt(size));
        }
        xQuery.setPageEntity(entity);
        PageInfo pageInfo = baseManager.listPageInfo(xQuery);
        List<MasterComment> list = pageInfo.getList();
        if (list != null && list.size() > 0) {
            return list;
        } else {
            return new ArrayList();
        }
    }

    @ResponseBody
    @RequestMapping("/getMsgComment/{qm}/{msgId}/{size}/{index}")
    public List getMsgComment(HttpServletRequest request, @PathVariable String qm, @PathVariable String msgId, @PathVariable String size, @PathVariable String index) throws Exception {
        XQuery xQuery = new XQuery(qm, request);
        xQuery.put("masterMessage_id", msgId);
        PageEntity entity = new PageEntity();
        if (index != null) {
            entity.setIndex(Integer.parseInt(index));
            entity.setSize(Integer.parseInt(size));
        }
        xQuery.setPageEntity(entity);
        PageInfo pageInfo = baseManager.listPageInfo(xQuery);
        List<MasterComment> list = pageInfo.getList();
        if (list != null && list.size() > 0) {
            return list;
        } else {
            return new ArrayList();
        }
    }

    @ResponseBody
    @RequestMapping("/getWorks/{qm}/{conditions}/{size}/{index}")
    public List getWorks(HttpServletRequest request, @PathVariable String qm, @PathVariable String conditions, @PathVariable String size, @PathVariable String index) throws Exception {
        //String url = "http://192.168.1.61:8082/importUsers";

        XQuery xQuery = new XQuery(qm, request);
        xQuery.put("master_id", conditions);
        PageEntity entity = new PageEntity();
        entity.setIndex(Integer.parseInt(index));
        entity.setSize(Integer.parseInt(size));
        xQuery.setPageEntity(entity);
        PageInfo pageInfo = baseManager.listPageInfo(xQuery);
        List<MasterModel> list = new ArrayList<>();
        List<MasterWork> works = pageInfo.getList();
        if (works != null && works.size() > 0) {
            for (MasterWork work : works) {
                MasterModel masterModel = ConvertMasterModelUtil.convertWork(work);
                list.add(masterModel);
            }
        }
        return list;
    }

    @ResponseBody
    @RequestMapping("/praiseWork/{workId}")
    public String praiseWork(@PathVariable String workId) {
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "noRole";
        }
        MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(), workId);
        String queryHql = "from MasterWorkPraise p where p.user.id=:userId and p.work.id=:workId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("userId", user.getId());
        queryMap.put("workId", work.getId());
        MasterWorkPraise praise = (MasterWorkPraise) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
        if (praise != null) {
            baseManager.delete(MasterWorkPraise.class.getName(), praise.getId());
            work.setFsAmount(work.getFsAmount() == null ? 0 : work.getFsAmount() - 1);
            baseManager.saveOrUpdate(MasterWork.class.getName(), work);
            return "del";
        } else {
            MasterWorkPraise workPraise = new MasterWorkPraise();
            workPraise.setWork(work);
            workPraise.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
            workPraise.setCreateDateTime(new Date());
            workPraise.setStatus("1");
            baseManager.saveOrUpdate(MasterWorkPraise.class.getName(), workPraise);
            work.setFsAmount(work.getFsAmount() == null ? 1 : work.getFsAmount() + 1);
            baseManager.saveOrUpdate(MasterWork.class.getName(), work);
            return "add";
        }
    }

    @ResponseBody
    @RequestMapping("/praiseMessage.do")
    public String praiseMessage(HttpServletRequest request) {
        String msgId = request.getParameter("msgId");
        MasterMessage msg = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(), msgId);
        MyUser user = AuthorizationUtil.getMyUser();
        if (user == null || user.getId() == null) {
            return "noRole";
        }
        String queryHql = "from MasterMessagePraise p where p.message.id=:msgId and p.user.id=:userId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("msgId", msgId);
        queryMap.put("userId", user.getId());
        MasterMessagePraise praise = (MasterMessagePraise) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
        if (praise != null) {
            baseManager.delete(MasterMessagePraise.class.getName(), praise.getId());
            msg.setPraiseNum(msg.getPraiseNum() == null ? 1 : msg.getPraiseNum() - 1);
            baseManager.saveOrUpdate(MasterMessage.class.getName(), msg);
            return "del";
        } else {
            MasterMessagePraise messagePraise = new MasterMessagePraise();
            messagePraise.setMessage(msg);
            messagePraise.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
            messagePraise.setCreateDateTime(new Date());
            messagePraise.setStatus("1");
            baseManager.saveOrUpdate(MasterMessagePraise.class.getName(), messagePraise);
            msg.setPraiseNum(msg.getPraiseNum() == null ? 1 : msg.getPraiseNum() + 1);
            baseManager.saveOrUpdate(MasterMessage.class.getName(), msg);
            return "add";
        }
    }

    @ResponseBody
    @RequestMapping("/storeWork/{workId}")
    public String storedWork(@PathVariable String workId) {
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "noRole";
        }
        MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(), workId);
        String queryHql = "from MasterWorkStore p where p.user.id=:userId and p.work.id=:workId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("userId", user.getId());
        queryMap.put("workId", work.getId());
        MasterWorkStore store = (MasterWorkStore) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
        if (store != null) {
            baseManager.delete(MasterWorkStore.class.getName(), store.getId());
            work.setStoreAmount(work.getStoreAmount() == null ? 0 : work.getStoreAmount() - 1);
            baseManager.saveOrUpdate(MasterWork.class.getName(), work);
            return "del";
        } else {
            MasterWorkStore story = new MasterWorkStore();
            story.setWork(work);
            story.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
            story.setCreateDateTime(new Date());
            story.setStatus("1");
            baseManager.saveOrUpdate(MasterWorkStore.class.getName(), story);
            work.setStoreAmount(work.getStoreAmount() == null ? 1 : work.getStoreAmount() + 1);
            baseManager.saveOrUpdate(MasterWork.class.getName(), work);
            return "add";
        }
    }

    @ResponseBody
    @RequestMapping("/storeMessage.do")
    public String storeMessage(HttpServletRequest request) {
        String msgId = request.getParameter("msgId");
        MasterMessage message = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(), msgId);
        MyUser user = AuthorizationUtil.getMyUser();
        if (user == null || user.getId() == null) {
            return "noRole";
        }
        String queryHql = "from MasterMessageStore p where p.masterMessage.id=:msgId and p.user.id=:userId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("msgId", msgId);
        queryMap.put("userId", user.getId());
        MasterMessageStore praise = (MasterMessageStore) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
        if (praise == null) {
            MasterMessageStore msgStore = new MasterMessageStore();
            msgStore.setStatus("1");
            msgStore.setCreateDateTime(new Date());
            msgStore.setMasterMessage(message);
            msgStore.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
            baseManager.saveOrUpdate(MasterMessageStore.class.getName(), msgStore);
            message.setStoreStatus("已关注");
//			message.setAmount(message.getAmount() == null ? 1 : message.getAmount() + 1);
            baseManager.saveOrUpdate(MasterMessage.class.getName(), message);
            return "add";
        } else {
            baseManager.delete(MasterMessageStore.class.getName(), praise.getId());
//			message.setAmount(message.getAmount() == null ? 1 : message.getAmount() - 1);
            message.setStoreStatus("关注");
            baseManager.saveOrUpdate(MasterMessage.class.getName(), message);
            return "del";
        }
    }

    @ResponseBody
    @RequestMapping("/commentWork.do")
    public Object commentWork(HttpServletRequest request) {
        String content = request.getParameter("content");
        String workId = request.getParameter("workId");
        String fatherId = request.getParameter("fatherId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user == null || user.getId() == null) {
            return "noRole";
        }
        if (content == null) {
            return "nothing";
        }
        MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(), workId);
        MasterComment comment = new MasterComment();
        if (!"0".equals(fatherId)) {
            MasterComment fatherCom = (MasterComment) baseManager.getObject(MasterComment.class.getName(), fatherId);
            comment.setFatherComment(fatherCom);
        } else {
            MasterComment fatherCom = new MasterComment();
            fatherCom.setId("0");
            comment.setFatherComment(fatherCom);
        }
        comment.setMasterWork(work);
        comment.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
        comment.setContent(content);
        comment.setAmount(0);
        comment.setCreateDateTime(new Date());
        comment.setStatus("1");
        baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
        work.setAmount(work.getAmount() == null ? 1 : work.getAmount() + 1);
        baseManager.saveOrUpdate(MasterWork.class.getName(), work);
        return comment;
    }

    @ResponseBody
    @RequestMapping("/commentMsg.do")
    public Object commentMsg(HttpServletRequest request) {
        String content = request.getParameter("content");
        String msgId = request.getParameter("msgId");
        String fatherId = request.getParameter("fatherId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user == null || user.getId() == null) {
            return "noRole";
        }
        if (StringTools.isEmpty(content) || content == "undefined") {
            return "nothing";
        }
        MasterMessage work = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(), msgId);
        MasterComment comment = new MasterComment();
        if (!"0".equals(fatherId)) {
            MasterComment fatherCom = (MasterComment) baseManager.getObject(MasterComment.class.getName(), fatherId);
            comment.setFatherComment(fatherCom);
        } else {
            MasterComment fatherCom = new MasterComment();
            fatherCom.setId("0");
            comment.setFatherComment(fatherCom);
        }
        comment.setMasterMessage(work);
        comment.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
        comment.setContent(content);
        comment.setAmount(0);
        comment.setCreateDateTime(new Date());
        comment.setStatus("1");
        baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
        work.setAmount(work.getAmount() == null ? 1 : work.getAmount() + 1);
        baseManager.saveOrUpdate(MasterMessage.class.getName(), work);
        return comment;
    }

    @ResponseBody
    @RequestMapping("/praiseWorkComment.do")
    public String praiseWorkComment(HttpServletRequest request) {
        String commId = request.getParameter("commentId");
        MyUser user = AuthorizationUtil.getMyUser();
        MasterComment comment = (MasterComment) baseManager.getObject(MasterComment.class.getName(), commId);
        if (user.getId() == null) {
            return "noRole";
        }
        String queryHql = "from MasterCommentPraise p where p.author.id=:authorId and p.comment.id=:commId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("authorId", user.getId());
        queryMap.put("commId", commId);
        MasterCommentPraise commentPraise = (MasterCommentPraise) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
        if (commentPraise != null) {
            baseManager.delete(MasterWorkPraise.class.getName(), commentPraise.getId());
            comment.setAmount(comment.getAmount() == null ? 0 : comment.getAmount() - 1);
            baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
            return "del";
        } else {
            MasterCommentPraise praise = new MasterCommentPraise();
            praise.setCreateDateTime(new Date());
            praise.setStatus("1");
            praise.setComment(comment);
            praise.setAuthor((User) baseManager.getObject(User.class.getName(),user.getId()));
            praise.setUser(comment.getUser());
            baseManager.saveOrUpdate(MasterCommentPraise.class.getName(), praise);
            comment.setAmount(comment.getAmount() == null ? 1 : comment.getAmount() + 1);
            baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
            return "add";
        }
    }

    @ResponseBody
    @RequestMapping("/praiseMsgComment.do")
    public String praiseMsgComment(HttpServletRequest request) {
        String commId = request.getParameter("commentId");
        MyUser user = AuthorizationUtil.getMyUser();
        MasterComment comment = (MasterComment) baseManager.getObject(MasterComment.class.getName(), commId);
        if (user.getId() == null) {
            return "noRole";
        }
        String queryHql = "from MasterCommentPraise p where p.author.id=:authorId and p.comment.id=:commId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("authorId", user.getId());
        queryMap.put("commId", commId);
        MasterCommentPraise commentPraise = (MasterCommentPraise) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
        if (commentPraise != null) {
            baseManager.delete(MasterWorkPraise.class.getName(), commentPraise.getId());
            comment.setAmount(comment.getAmount() == null ? 0 : comment.getAmount() - 1);
            baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
            return "del";
        } else {
            MasterCommentPraise praise = new MasterCommentPraise();
            praise.setCreateDateTime(new Date());
            praise.setStatus("1");
            praise.setComment(comment);
            praise.setAuthor((User) baseManager.getObject(User.class.getName(),user.getId()));
            praise.setUser(comment.getUser());
            baseManager.saveOrUpdate(MasterCommentPraise.class.getName(), praise);
            comment.setAmount(comment.getAmount() == null ? 1 : comment.getAmount() + 1);
            baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
            return "add";
        }
    }

}
