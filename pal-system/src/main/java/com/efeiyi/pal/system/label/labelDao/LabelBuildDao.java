package com.efeiyi.pal.system.label.labelDao;

import com.efeiyi.pal.label.model.LabelBatch;

/**
 * Created by Administrator on 2015/8/19.
 */

public interface LabelBuildDao {

    void buildLabelSetByLabelBatch(LabelBatch labelBatch);

}
