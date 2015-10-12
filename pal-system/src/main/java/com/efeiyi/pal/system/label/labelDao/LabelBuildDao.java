package com.efeiyi.pal.system.label.labelDao;

import com.efeiyi.pal.label.model.LabelBatch;

/**
 * Created by Administrator on 2015/8/19.
 * 批量生成标签 Dao 接口
 */

public interface LabelBuildDao {

    void buildLabelSetByLabelBatch(LabelBatch labelBatch) throws Exception;

    void buildLabelSetByLabelBatchNFC(LabelBatch labelBatch) throws Exception;
}
