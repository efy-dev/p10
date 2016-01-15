package com.efeiyi.ec.system.zero.company.service;

import java.io.File;
import java.util.List;

/**
 * Created by Administrator on 2016/1/13.
 */
public interface BatchPrintManager {

    File downloadFiles(List fileList) throws Exception;
}
