package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.LinkedHashMap;
/**
 * Created by AC丶man on 2015/9/21.
 */
@Controller
@RequestMapping("/masterComment")
public class MasterCommentController {

	@Autowired
	BaseManager baseManager;



	@ResponseBody
	@RequestMapping("/workComment.do")
	public boolean workCommented(HttpServletRequest request)throws Exception{
		String workId = request.getParameter("workId");
		String content = request.getParameter("content");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user == null){
			return false;
		}
		MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(),workId);
		MasterComment comment = new MasterComment();
		comment.setContent(content);
		comment.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
		comment.setAmount(1);
		comment.setCreateDateTime(new Date());
		comment.setMasterWork(work);
		comment.setStatus("1");
		MasterComment fatherComment = new MasterComment();
		fatherComment.setId("0");
		comment.setFatherComment(fatherComment);
		baseManager.saveOrUpdate(MasterComment.class.getName(),comment);
		work.setAmount(work.getAmount()==null? 1 :work.getAmount() + 1);
		baseManager.saveOrUpdate(MasterWork.class.getName(),work);
		return true;
	}

	@ResponseBody
	@RequestMapping("/commentOther.do")
	public boolean fatherCommented(HttpServletRequest request)throws Exception{
		String workId = request.getParameter("workId");
		String content = request.getParameter("content");
		String fatherId = request.getParameter("contentId");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user == null){
			return false;
		}
		MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(),workId);
		MasterComment comment = new MasterComment();
		comment.setContent(content);
		comment.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
		comment.setAmount(1);
		comment.setCreateDateTime(new Date());
		comment.setMasterWork(work);
		comment.setStatus("1");
		MasterComment fatherComment = new MasterComment();
		fatherComment.setId(fatherId);
		comment.setFatherComment(fatherComment);
		baseManager.saveOrUpdate(MasterComment.class.getName(),comment);
		work.setAmount(work.getAmount()==null? 1 :work.getAmount() + 1);
		baseManager.saveOrUpdate(MasterWork.class.getName(),work);
		return true;
	}

	@RequestMapping("/commentUpAndDown.do")
	@ResponseBody
	public String commentUpAndDown(HttpServletRequest request) throws Exception {
		String workId = request.getParameter("workId");
		String commentId = request.getParameter("commentId");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user.getId() == null) {
			return "false";
		}
		MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(),workId);
		MasterComment comment = (MasterComment) baseManager.getObject(MasterComment.class.getName(),commentId);
		MasterWorkPraise praise = new MasterWorkPraise();
		String oper = request.getParameter("operation");
		if (oper != null && oper.equalsIgnoreCase("up")) {
			String queryHql = "from MasterWorkPraise t where t.user.id=:userId and t.comment.id=:commentId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("commentId", commentId);
//			List<MasterWorkPraise> list = baseManager.listObject(queryHql,map);

			MasterWorkPraise p2 = (MasterWorkPraise) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (p2 != null && p2.getId() != null)//不为null,说明已经点过赞了
			{
				return "repeat";
			}
			//防止重复点赞
			praise.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
			praise.setCreateDateTime(new Date());
			praise.setComment(comment);
			baseManager.saveOrUpdate(MasterWorkPraise.class.getName(), praise);
			comment.setAmount(comment.getAmount() == null ? 1 : comment.getAmount() + 1);
			baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
		}

		if (oper != null && oper.equalsIgnoreCase("down")) {
			String queryHql = "from MasterWorkPraise t where t.user.id=:userId and t.comment.id=:commentId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("commentId", commentId);
			MasterWorkPraise praise1 = (MasterWorkPraise) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (praise1 != null && praise1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
				baseManager.delete(MasterWorkPraise.class.getName(), praise1.getId());

			int Amount=0;
			if(comment.getAmount() == null){
				Amount=0;
			}else if (comment.getAmount() - 1<=0){
				Amount=0;
			}else if (comment.getAmount() - 1>=1){
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
		String workId = request.getParameter("workId");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user.getId() == null) {
			return "false";
		}
		MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(),workId);
		MasterWorkPraise praise = new MasterWorkPraise();
		String oper = request.getParameter("operation");
		if (oper != null && oper.equalsIgnoreCase("up")) {

			String queryHql = "from MasterWorkPraise t where t.user.id=:userId and t.work.id=:workId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("workId", work.getId());
			MasterWorkPraise praise1 = (MasterWorkPraise) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (praise1 != null && praise1.getId() != null)//不为null,说明已经点过赞了
			{
				return "repeat";
			}



			//防止重复点赞


			praise.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
			praise.setWork(work);
			praise.setCreateDateTime(new Date());
			baseManager.saveOrUpdate(MasterWorkPraise.class.getName(), praise);
			work.setFsAmount(work.getFsAmount() == null ? 1 : work.getFsAmount() + 1);
			baseManager.saveOrUpdate(MasterWork.class.getName(), work);
		}


		if (oper != null && oper.equalsIgnoreCase("down")) {
			String queryHql = "from MasterWorkPraise t where t.user.id=:userId and t.work.id=:workId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("workId", work.getId());
			MasterWorkPraise praise1 = (MasterWorkPraise) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (praise1 != null && praise1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
				baseManager.delete(MasterWorkPraise.class.getName(), praise1.getId());
			int FsAmount =0;
			if(work.getFsAmount() == null){
				FsAmount =0;
			}else  if(work.getFsAmount() - 1<=0){
				FsAmount =0;
			}else if (work.getFsAmount() - 1>=1){
				FsAmount =work.getFsAmount() - 1;
			}
			work.setFsAmount(FsAmount);
			baseManager.saveOrUpdate(MasterWork.class.getName(), work);
		}


		return "true";
	}

	@RequestMapping("/storeWork.do")
	@ResponseBody
	public String storeWork(HttpServletRequest request) throws Exception {
		String workId = request.getParameter("workId");
		MasterWorkStore store = new MasterWorkStore();
		MyUser user = AuthorizationUtil.getMyUser();
		if (user.getId() == null) {
			return "false";
		}
		if (user.getId() != null) {
			String queryHql = "from MasterWorkStore t where t.user.id=:userId and t.work.id=:workId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("workId", workId);
			MasterWorkStore ps = (MasterWorkStore) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (ps != null && ps.getId() != null){
				return "repeat" ;
			}//不为null,说明已经收藏了
		}
		store.setUser((User) baseManager.getObject(User.class.getName(),user.getId()));
		MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(), workId);
		store.setWork(work);
		store.setStatus("1");
		store.setCreateDateTime(new Date());
		baseManager.saveOrUpdate(MasterWorkStore.class.getName(), store);

		return "true";
	}

}
