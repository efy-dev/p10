package com.efeiyi.pal.system.order.service.impl;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.efeiyi.pal.purchase.model.PurchaseOrderLabel;
import com.efeiyi.pal.system.order.dao.LabelDao;
import com.efeiyi.pal.system.order.service.LabelServiceManager;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by Administrator on 2015/8/18.
 */

@Service
@EnableTransactionManagement
public class LabelServiceManagerImpl implements LabelServiceManager {

    @Autowired
    @Qualifier("labelDaoHibernate")
    private LabelDao labelDao;

    @Override
    public List<Label> getLabelListByMinSerialAndSumProduct(Integer sumProduct, String type) {
        return labelDao.getLabelListByMinSerialAndSumProduct(sumProduct, type);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void distributeLabelList(PurchaseOrder purchaseOrder, Map<String, List<Label>> listMap) {

        List<PurchaseOrderLabel> POLList = purchaseOrder.getPurchaseOrderLabelList();
        int flag = 0;
        //分配二维码标签
        for (int j = 0; j < POLList.size(); j++) {
            PurchaseOrderLabel pol = POLList.get(j);
            if (!"1".equals(pol.getType())) {
                continue;
            }
            for (int i = 0; i < pol.getAmount(); i++) {
                Label label = listMap.get("listQR").get(i + flag);
                label.setPurchaseOrderLabel(pol);
                label.setSeller(purchaseOrder.getTenant());
                label.setStatus("2");
                labelDao.saveOrUpdate(Label.class.getName(), label);
            }
            flag += pol.getAmount();
        }

        flag = 0;
        //分配NFC标签
        for (int j = 0; j < POLList.size(); j++) {
            PurchaseOrderLabel pol = POLList.get(j);
            if (!"2".equals(pol.getType())) {
                continue;
            }
            for (int i = 0; i < pol.getAmount(); i++) {
                Label label = listMap.get("listNFC").get(i + flag);
                label.setPurchaseOrderLabel(pol);
                label.setSeller(purchaseOrder.getTenant());
                label.setStatus("2");
                labelDao.saveOrUpdate(Label.class.getName(), label);
            }
            buildNfcLabelFile(listMap.get("listNFC"), pol, flag);
            flag += pol.getAmount();
        }

        //还需要写入文件---待处理


    }

    private void buildNfcLabelFile(List<Label> listNFC, PurchaseOrderLabel pol, Integer flag) {
        BufferedWriter bw = null;
        String path = this.getClass().getClassLoader().getResource("/").getPath();
        File clazzDir = new File(path);
        String webInfPath = clazzDir.getParent() + "/file/";
        File parent = new File(webInfPath);
        if (!parent.exists()) {
            parent.mkdirs();
        }
        try {
            long startTime = System.currentTimeMillis();
            List<File> cfgFileList = new ArrayList<File>(pol.getAmount());
            for (int x = 0; x < pol.getAmount(); x++) {
                File tmpCfgFile = new File(webInfPath + listNFC.get(x + flag).getCode() + ".tmp");
                bw = new BufferedWriter(new FileWriter(tmpCfgFile));
                StringBuilder line = new StringBuilder();
                line.append("code=").append(listNFC.get(x + flag).getCode()).append("\n").append("apoid=8\n");
                bw.write(line.toString());
                bw.flush();
                File cfgFile = new File(webInfPath + listNFC.get(x + flag).getCode() + ".cfg");
                FileUtils.copyFile(tmpCfgFile, cfgFile);
                cfgFileList.add(cfgFile);
            }

            compressFiles(cfgFileList, clazzDir.getParent() + "/file/" + pol.getId() + ".rar");

            System.out.println("输出用时：" + (System.currentTimeMillis() - startTime));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (bw != null) {
                try {
                    bw.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void compressFiles(List<File> fileList, String fullName) throws Exception {
        ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(fullName));
        FileInputStream fis = null;
        try {
            for (File file : fileList) {
                fis = new FileInputStream(file);
                ZipEntry ze = new ZipEntry(file.getName());
                zos.putNextEntry(ze);
                byte[] content = new byte[1024];
                int len;
                while ((len = fis.read(content)) != -1) {
                    zos.write(content, 0, len);
                    zos.flush();
                }
            }
        } catch (Exception e) {
            throw e;
        } finally {
            try {
                if (fis != null) {
                    fis.close();
                }
                zos.close();
            } catch (IOException e) {
                throw e;
            }
        }

    }

    @Override
    public List<Label> getLabelListByOrder(PurchaseOrder purchaseOrder) {
        return labelDao.getLabelListByOrder(purchaseOrder);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void activateOrCancelLabelList(String status, List<Label> labels) {
        for (Label label : labels) {
            label.setStatus(status);
            labelDao.saveOrUpdate(Label.class.getName(), label);
        }
    }

}
