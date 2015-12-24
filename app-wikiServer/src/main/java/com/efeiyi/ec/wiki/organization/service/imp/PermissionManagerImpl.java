package com.efeiyi.ec.wiki.organization.service.imp;


import com.efeiyi.ec.wiki.organization.service.PermissionManager;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-16
 * Time: 下午4:58
 * To change this template use File | Settings | File Templates.
 */
@Service
public class PermissionManagerImpl implements PermissionManager {
    @Autowired
    private DoManager doManager;
/*    @Autowired
    private XdoDao basicDao;*/

    private String userId;

    @Override
    public Boolean processAccess(String accesses, String userId) {
        this.userId = userId;

        if (accesses == null || accesses.equals("")) {//没有权限限制
            return true;
        }

        if (accesses.equals("ALL")) {   //对所有人开放
            return true;
        }

        for (String access : accesses.split(";")) {
            String entity = "";
            String operations = "";
            String[] accessArray = access.split(":");
            if (accessArray.length > 1) {
                entity = accessArray[0];
                operations = accessArray[1];
            } else {
                entity = accessArray[0];
            }
//            if (this.processPermission(entity, operations)) {     //只要有一项权限通过 就通过
            return true;
//            }
        }

        return false;
    }

    @Override
    public Boolean processNewAccess(String accesses, String roleType) {

        return null;
    }

    //    /**
//     * @param entity   单个值 例如student
//     * @param operations    多个值（多个值之前用,隔开） 例：em,dm
//     * @return
//     */
//    private Boolean processPermission(String entity, String operations) {
//        Role role = AuthorizationUtil.getMyUser().getRole();
//        if (entity == null || entity.equals("")) {      //传入的entity和解析获得的entity都不存在 说明没有权限空
//            return true;
//        }
//        if (role.getPermissionMap().get(entity) == null) {  //当前用户不存在该权限
//            return false;
//        } else {
//            if (role.getPermissionMap().get(entity).getAll()) {   //拥有该模块的全部权限
//                return true;
//            } else {
//                return this.processOperations(entity,operations);
//            }
//        }
//
//    }

//    /**
//     * @param entity   单个值 例如student
//     * @param operations    多个值（多个值之前用,隔开） 例：em,dm
//     * @return
//     */
    /*private Boolean processOperations(String entity,String operations) {
        if (operations == null || operations.equals("")) {//没有operations限制 只要拥有该模块的entity就拥有权限
            return true;
        }

        Permission permission = AuthorizationUtil.getMyUser().getRole().getPermissionMap().get(entity);

        if (permission.getBasic() != null) {
            String basic = permission.getBasic();
            if (basic.contains("ea") && !basic.contains("em")) {
                basic += ",em";
            }
            if (basic.contains("da") && !basic.contains("dm")) {
                basic += ",dm";
            }
            for(String operation:operations.split(",")){
                //如果页面上是em（修改自己的数据）  当前用户角色中没有ea(修改全部全部数据)但是有修改自己数据的权限
                //如果页面上是em  当前用户拥有ea(修改全部)那么也不用根据userId做判断
                //如果页面上是ea  那当前用户的角色里必须有ea能通过
                if (operation.equals("em") && !basic.contains("ea") && basic.contains("em")) {
                    return processUser();
                }else if (operation.equals("dm") && !basic.contains("da") && basic.contains("dm")) {
                    return processUser();
                }else if (operation.equals("vm") && !basic.contains("va") && basic.contains("vm")) {
                    return processUser();
                }else if(basic.contains(operation)){
                    return true;
                }
            }
        }

        if (permission.getOthers() != null) {
            for(String operation:operations.split(",")){
                if (permission.getOthers().contains(operation)) {
                    return true;
                }
            }
        }

        return false;
    }*/

    public Boolean processUser() {
        if (this.userId == null || this.userId.equals("")) {
            return true;
        } else if (userId.equals(AuthorizationUtil.getMyUser().getId())) {
            return true;
        } else {
            return false;
        }
    }


    @Override
    public String convertUrlToEntityName(String url) throws Exception {
        String entityName = "";

        String qm = "";
        if (url.indexOf("qm=") != -1) {
            qm = url.substring(url.indexOf("qm=") + 3);
            if (qm.indexOf("&") != -1) {
                qm = qm.substring(0, qm.indexOf("&"));
            }
        }

        if (!qm.equals("")) {
            String doStr = qm.contains("_") ? qm.split("_")[0] : qm;
            Do queryDo = doManager.getDoByQueryModel(doStr);
            if (queryDo != null) {
                entityName = queryDo.getXentity().getName();
            }
        }

        return entityName;
    }

    @Override
    public String convertUrlToOperation(String url) {
        String operations = "";
        if (url == null || url.equals("")) {
            return operations;
        }

        if (url.indexOf("qm=") != -1) {
            url = url.substring(url.indexOf("qm=") + 3);
        }
        if (url.startsWith("listMy") || url.startsWith("plistMy")) {
            operations = "vm";
        } else if (url.startsWith("list") || url.startsWith("plist")) {
            operations = "va";
        } else if (url.startsWith("form")) {
            if (url.indexOf("&id") != -1) {
                operations = "em";
            } else {
                operations = "new";
            }
        } else if (url.startsWith("delete") || url.startsWith("remove")) {
            operations = "dm";
        }

        return operations;
    }

}
