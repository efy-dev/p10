package com.efeiyi.pal.system.label.labelService;

import com.efeiyi.pal.label.model.LabelBatch;

/**
 * Created by Administrator on 2015/8/19.
 */

public interface LabelBuildService {

    void buildLabelSetByLabelBatch(LabelBatch labelBatch) throws Exception;

}
