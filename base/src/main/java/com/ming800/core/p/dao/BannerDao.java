package com.ming800.core.p.dao;

import com.ming800.core.base.dao.BaseDao;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.model.Tag;

import java.util.List;


public interface BannerDao  {

    /**
     * 获取 轮播图
     * @param groupName
     * @return
     */
    List getBannerList(String groupName);

    /**
     * 保存轮播图
     * @param banner
     */
    void saveBanner(Banner banner);

    /**
     * 删除轮播图真删
     * @param banner
     */
    void  deleteBanner(Banner banner);

    /**
     * 假删 删除轮播图
     * @param banner
     */
    void  removeBanner(Banner banner);

    /**
     * 更新排序
     * @param banner
     */
    void  updateBannerOrder(Banner banner);
}
