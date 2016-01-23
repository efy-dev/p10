package com.efeiyi.ec.art.master.controller;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.art.base.model.LogBean;
import com.efeiyi.ec.art.base.util.AppConfig;
import com.efeiyi.ec.art.master.model.MasterModel;
import com.efeiyi.ec.art.master.util.ConvertMasterModelUtil;
import com.efeiyi.ec.art.base.util.DigitalSignatureUtil;
import com.efeiyi.ec.art.base.util.JsonAcceptUtil;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.taglib.PageEntity;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2016/1/14.
 *
 */
@Controller
@RequestMapping("/app")
public class MasterMessageController extends BaseController {
    private static Logger logger = Logger.getLogger(MasterMessageController.class);
    @Autowired
    BaseManager baseManager;


    @RequestMapping(value = "/masterMessage.do",method = RequestMethod.POST)
    @ResponseBody
    public Map MasterMessagePList(HttpServletRequest request) throws Exception {
        String qm ="plistMasterMessage_default";

        LogBean logBean = new LogBean();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        TreeMap treeMap = new TreeMap();
        try {
            JSONObject jsonObj=new JSONObject();
            try {
                 jsonObj = JsonAcceptUtil.receiveJson(request);
            }catch (Exception e){
                logBean.setResultCode("10009");
                logBean.setMsg("json格式错误");
                resultMap.put("resultCode", "10009");
                resultMap.put("resultMsg", "json格式错误");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }

            logBean.setCreateDate(new Date());
            logBean.setRequestMessage(jsonObj.toString());//************记录请求报文
            if ("".equals(jsonObj.getString("signmsg")) || "".equals(jsonObj.getString("username"))
                    || "".equals(jsonObj.getString("timestamp")) ) {
                logBean.setResultCode("10001");
                logBean.setMsg("必选参数为空，请仔细检查");
                resultMap.put("resultCode", "10001");
                resultMap.put("resultMsg", "必选参数为空，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                return resultMap;
            }

            String signmsg = jsonObj.getString("signmsg");
            String pagesize = jsonObj.getString("pagesize");
            String index = jsonObj.getString("index");
            treeMap.put("username", jsonObj.getString("username"));
            treeMap.put("timestamp", jsonObj.getString("timestamp"));//时间戳
            if(pagesize!=null)
            treeMap.put("pagesize", pagesize);//异步加载，每次加载数量
            if(index!=null)
            treeMap.put("index", index);//页码

            boolean verify = DigitalSignatureUtil.verify(treeMap, signmsg);
            if (verify != true) {
                logBean.setResultCode("10002");
                logBean.setMsg("参数校验不合格，请仔细检查");
                resultMap.put("resultCode", "10002");
                resultMap.put("resultMsg", "参数校验不合格，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }

            LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
            map.put("username", jsonObj.getString("username"));
            MyUser user = (MyUser) baseManager.getUniqueObjectByConditions(AppConfig.SQL_USER_GET, map);
            if (user == null || user.getId() == null){
                logBean.setResultCode("10007");
                logBean.setMsg("用户名不存在");
                resultMap.put("resultCode", "10007");
                resultMap.put("resultMsg", "用户名不存在");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }

            XQuery xQuery = new XQuery(qm, request);
            PageEntity pageEntity = new PageEntity();
            if (index != null)
                pageEntity.setIndex(Integer.parseInt(index));
            if (pagesize != null)
                pageEntity.setSize(Integer.parseInt(pagesize));

            xQuery.setPageEntity(pageEntity);
            PageInfo pageInfo = baseManager.listPageInfo(xQuery);
            List<MasterMessage> messageList = pageInfo.getList();
            if(messageList==null || messageList.isEmpty()){
                logBean.setResultCode("10008");
                logBean.setMsg("查无数据，稍后再试");
                resultMap.put("resultCode", "10008");
                resultMap.put("resultMsg", "查无数据，稍后再试");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }

            List<MasterModel> msgList = new ArrayList<>();
            if (messageList != null && messageList.size() > 0) {
                for (MasterMessage message : messageList) {
                    message.getMaster().setFollowStatus(getFollowStatus(message.getMaster(), (User) baseManager.getObject(User.class.getName(), user.getId())));
                    message.setPraiseStatus(getPraiseStatus(message, (User) baseManager.getObject(User.class.getName(), user.getId())));
                    message.setStoreStatus(getStorePraiseStatus(message,(User) baseManager.getObject(User.class.getName(), user.getId())));
                    message.setFollowStatus(message.getMaster().getFollowStatus());
                    message.setMasterId(message.getMaster().getId());
                    message.setMasterName(message.getMaster().getFullName());
                    message.setAmount(message.getAmount() == null ? 0 : message.getAmount());
                    message.setFsAmount(message.getFsAmount() == null ? 0 : message.getFsAmount());
                    MasterModel msgModel = ConvertMasterModelUtil.convertMasterModel(message);
                    msgList.add(msgModel);
                }
            }
            logBean.setResultCode("0");
            logBean.setMsg("成功 ");
            resultMap.put("resultCode", "0");
            resultMap.put("resultMsg", "成功");
            resultMap.put("responseInfo",msgList);
        }catch(Exception e){
            logBean.setResultCode("10004");
            logBean.setMsg("未知错误，请联系管理员");
            resultMap.put("resultCode", "10004");
            resultMap.put("resultMsg", "未知错误，请联系管理员");
            baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
            return resultMap;
        }


        return resultMap;
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

    public String getStorePraiseStatus(MasterMessage message, User user){
        String queryHql = "from MasterMessageStore p where p.masterMessage.id=:messageId and p.user.id=:userId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("messageId", message.getId());
        queryMap.put("userId", user.getId());
        List<MasterMessageStore> list = baseManager.listObject(queryHql, queryMap);
        if (list != null && list.size() > 0) {
            message.setStoreStatus("已收藏");
        } else {
            message.setStoreStatus("收藏");
        }
        return message.getStoreStatus();
    }


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
}
