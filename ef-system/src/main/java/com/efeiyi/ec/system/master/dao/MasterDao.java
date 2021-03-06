package com.efeiyi.ec.system.master.dao;



import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterWorkRecommended;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-16
 * Time: 下午4:18
 * To change this template use File | Settings | File Templates.
 */
public interface MasterDao {

    /**
     * 商家关联大师列表
     * @param tenantId
     * @return
     */
    List<Master> getMasterList(String tenantId);
}
