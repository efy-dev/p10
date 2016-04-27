package com.efeiyi.ec.gift.base.tag;

import com.efeiyi.ec.organization.model.User;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.ApplicationContextUtil;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-7
 * Time: 下午4:33
 * To change this template use File | Settings | File Templates.
 */
public class UserNameTag extends TagSupport {
    private String ids;

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    @Override
    public int doStartTag() {

        return SKIP_BODY;   //忽略对body的处理
    }

    @Override
    public int doEndTag() throws JspException {
        JspWriter out = pageContext.getOut();
        try {
            out.println(this.getHtmlTag()); //页面中显示的内容
        } catch (IOException e) {
            throw new JspException(e);
        }
        return EVAL_PAGE; //继续处理页面内容
    }

    private String getHtmlTag() {
        String names = "";
        BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
        String hql = "from User u where u.id in (:ids)";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("ids", ids.split(","));
        List<User> userList = baseManager.listObject(hql, queryParamMap);
        for (User user : userList) {
            names += user.getName();
        }
        return names;
    }

}
