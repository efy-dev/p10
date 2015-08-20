package com.efeiyi.pal.system.label.labelService.impl;

import com.efeiyi.pal.label.model.LabelBatch;
import com.efeiyi.pal.system.label.labelDao.LabelBuildDao;
import com.efeiyi.pal.system.label.labelService.LabelBuildService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/8/19.
 */

@Service
public class LabelBuildServiceImpl implements LabelBuildService {

    @Autowired
    private LabelBuildDao labelBuildDao;

    @Override
    public void buildLabelSetByLabelBatch(LabelBatch labelBatch) throws Exception {
        labelBuildDao.buildLabelSetByLabelBatch(labelBatch);
    }

}
