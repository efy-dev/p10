package com.efeiyi.ec.personal.master;



import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterUser;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.ApplicationContextUtil;

import java.util.LinkedHashMap;
import java.util.List;


/**
 * @author WuYingbo
 */
public class MasterUtil {

    private static BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    public static Master findMaster() {
        Master master = null;
        String hql = "from MasterUser m where m.user.id =:userId and m.status = '1'";
        LinkedHashMap<String, Object> map = new LinkedHashMap<>();
        map.put("userId", AuthorizationUtil.getMyUser().getId());
        List<MasterUser> list = baseManager.listObject(hql, map);
        if(list!=null && list.size()>0) {
             master = list.get(0).getMaster();
        }
        return master;
    }

}
