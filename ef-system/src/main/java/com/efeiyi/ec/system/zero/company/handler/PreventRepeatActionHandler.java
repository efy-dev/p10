package com.efeiyi.ec.system.zero.company.handler;

import com.efeiyi.ec.system.zero.company.util.BatchLogisticsReactor;
import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/12/18.
 */
public class PreventRepeatActionHandler implements DoHandler {
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        if (BatchLogisticsReactor.runningFlag.get() == 1) {
            modelMap.put("msg", "已启动后台运行！注意不要再次启动！");
        }
        return modelMap;
    }
}
