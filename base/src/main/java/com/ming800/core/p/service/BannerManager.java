package com.ming800.core.p.service;

import com.ming800.core.p.model.Banner;

import java.util.List;

public interface BannerManager {

    /**
     * 获取 轮播图
     * @param groupName
     * @return
     */
    List getBannerList(String groupName) throws Exception;
    /**
     * 保存轮播图
     * @param banner
     */
    void saveBanner(Banner banner);

    /**
     * 假删
     * @param banner
     */
    void removeBanner(Banner banner);

    /**
     * 真删
     * @param banner
     */
    void  deleteBanner(Banner banner);
    /**
     * 更新排序
     * @param banner
     */
    void  updateBannerOrder(Banner banner);

}
