package com.ming800.core.p.service.impl;

import com.ming800.core.p.dao.BannerDao;
import com.ming800.core.p.dao.TagDao;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.model.CommonBanner;
import com.ming800.core.p.model.CommonTag;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.CommonManager;
import com.ming800.core.p.service.TagManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-1-15
 * Time: 13:41:03
 * To change this template use File | Settings | File Templates.
 */

@Service
public class BannerManagerImpl implements BannerManager {


    @Autowired
    private BannerDao bannerDao;

    @Autowired
    private CommonManager commonManager;


    @Override
    public  List getBannerList(String groupName) throws Exception{

        CommonBanner commonBanner =commonManager.getBanner(groupName);

        return  bannerDao.getBannerList(commonBanner.getGroup());
    }

    @Override
    public void saveBanner(Banner banner) {
        bannerDao.saveBanner(banner);
    }

    @Override
    public void removeBanner(Banner banner) {
          bannerDao.removeBanner(banner);
    }

    @Override
    public void deleteBanner(Banner banner) {
           bannerDao.deleteBanner(banner);
    }

    @Override
    public void updateBannerOrder(Banner banner) {
          bannerDao.updateBannerOrder(banner);
    }
}
