package com.efeiyi.ec.website.base.tag;

import com.efeiyi.ec.organization.model.BigUser;
import com.ming800.core.taglib.ScopeTag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

public class AuthTag extends TagSupport {
    private BigUser bigUser;
    private String roleName;

    public BigUser getBigUser() {
        return bigUser;
    }

    public void setBigUser(BigUser bigUser) {
        this.bigUser = bigUser;
    }

    public String getRoleName() {
        return this.roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public int doStartTag() throws JspException {
        Tag parentTag = getParent();
        if ((parentTag != null) && (parentTag instanceof ScopeTag)) {
            ScopeTag scopeTag = (ScopeTag) parentTag;
            if ((scopeTag.isEvalOtherAuth()) && (processAuth())) {
                scopeTag.setEvalOtherAuth(false);
                return 1;
            }
        } else if (processAuth()) {
            return 1;
        }

        return 0;
    }

    private boolean processAuth() {
//    if (this.bigUser == null)
//      return processAuthDetails(AuthorizationUtil.getMyUser());

        return processAuthDetails(this.bigUser);
    }

    private boolean processAuthDetails(BigUser bigUser) {
       /* String[] roleNames = this.roleName.split(",");
        List<Role> roleList = new ArrayList<Role>();
        if(bigUser.getRoles()!=null){
            for(String roleName : bigUser.getRoles().split(",")) {
                Role role= new Role();//没个用户都默认带ROLE_USER这个权限
                role.setName(roleName);
                roleList.add(role);
            }
        }
        Role role1= new Role();//没个用户都默认带ROLE_USER这个权限
            role1.setName("ROLE_USER");
            role1.setLabel("普通用户");
            roleList.add(role1);
        for(Role role:roleList){
            for(String str:roleNames){
                if(role.getName().equals("SUPER_M")||role.getName().equals(str)){
                    return true;
                }
            }
        }*/
       /*###role###*/
        return false;
    }
}