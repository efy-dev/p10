package com.efeiyi.pal.system.order.dao;

import com.efeiyi.pal.label.model.Label;

import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */
public interface LabelDao {

    String getMinSerial();

    List<Label> getLabelListByMinSerialAndSumProduct(String minSerial, Integer sumProduct);

}
