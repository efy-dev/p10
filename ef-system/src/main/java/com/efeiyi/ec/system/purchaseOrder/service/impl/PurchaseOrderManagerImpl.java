package com.efeiyi.ec.system.purchaseOrder.service.impl;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.efeiyi.ec.system.purchaseOrder.dao.PurchaseOrderDao;
import com.efeiyi.ec.system.purchaseOrder.service.PurchaseOrderManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AutoSerialManager;
import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: ����5:02
 * To change this template use File | Settings | File Templates.
 */

@Service
@Transactional
public class PurchaseOrderManagerImpl implements PurchaseOrderManager {

    @Autowired
    private PurchaseOrderDao purchaseOrderDao;

    @Autowired
    private BaseManager baseManager;


    @Override
    public String updateOrderStatus(PurchaseOrder purchaseOrder, String serial, String logisticsCompany) {

        try {
            purchaseOrderDao.updateOrderStatus(purchaseOrder);
            PurchaseOrderDelivery purchaseOrderDelivery = new PurchaseOrderDelivery();
            purchaseOrderDelivery.setPurchaseOrder(purchaseOrder);
            purchaseOrderDelivery.setCreateDateTime(new Date());
            purchaseOrderDelivery.setSerial(serial);
            purchaseOrderDelivery.setLogisticsCompany(logisticsCompany);
            purchaseOrderDelivery.setStatus("1");
            baseManager.saveOrUpdate(PurchaseOrderDelivery.class.getName(), purchaseOrderDelivery);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return purchaseOrder.getId();
    }

    @Override
    public String updateOrderStatus(PurchaseOrder purchaseOrder) {
        return purchaseOrderDao.updateOrderStatus(purchaseOrder);
    }

    @Override
    public String outExcel(String path, String[] homes,String startTime,String endTime,String selectTenant) throws WriteException {
        List<Object[]> resultList = purchaseOrderDao.getResult(startTime,endTime,selectTenant);
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String date1 = sdf.format(date);

        FileOutputStream fileOut = null;
        File downloadFile = new File(path);

        if (!downloadFile.exists()) {
            downloadFile.mkdir();
        }
        String fileName = path + "//purchaseOrder" + date1 + ".xls";
        String returnFileName = "purchaseOrder" + date1 + ".xls";

        try {
            File file = new File(fileName);
            file.createNewFile();
            fileOut = new FileOutputStream(file);

            WritableWorkbook workbook = Workbook.createWorkbook(fileOut);//创建工作簿

            WritableSheet sheet1 = workbook.createSheet("商品规格详情", 1);
            /** **********设置纵横打印（默认为纵打）、打印纸***************** */
            SheetSettings sheetset = sheet1.getSettings();
            sheetset.setProtected(false);


            /** ************设置单元格字体************** */
            WritableFont NormalFont = new WritableFont(WritableFont.ARIAL, 10);
            WritableFont BoldFont = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD);

            /** ************以下设置三种单元格样式，灵活备用************ */
            // 用于标题居中
            WritableCellFormat wcf_center = new WritableCellFormat(BoldFont);
            wcf_center.setBorder(Border.ALL, BorderLineStyle.THIN); // 线条
            wcf_center.setVerticalAlignment(VerticalAlignment.CENTRE); // 文字垂直对齐
            wcf_center.setAlignment(Alignment.CENTRE); // 文字水平对齐
            wcf_center.setWrap(false); // 文字是否换行

            // 用于正文居左
            WritableCellFormat wcf_left = new WritableCellFormat(NormalFont);
            wcf_left.setBorder(Border.NONE, BorderLineStyle.THIN); // 线条
            wcf_left.setVerticalAlignment(VerticalAlignment.CENTRE); // 文字垂直对齐
            wcf_left.setAlignment(Alignment.LEFT); // 文字水平对齐
            wcf_left.setWrap(false); // 文字是否换行
            //第一行
            for (int n = 0; n < homes.length; n++) {
                sheet1.addCell(new Label(n, 0, homes[n], wcf_center));
            }

            for (int i = 0; i < resultList.size(); i++) {
                Object[] o = resultList.get(i);
                for (int j = 0; j < o.length; j++) {
                    if (j == 8) {
                        if (null == o[j] || "".equals(o[j])) {
                            sheet1.addCell(new Label(j, i + 1, "", wcf_left));
                        } else {
                            sheet1.addCell(new Label(j, i + 1, sdf1.format(o[j]), wcf_left));
                        }
                    }else if (j == 19){
                        if (null == o[j] || "".equals(o[j])) {
                            sheet1.addCell(new Label(j, i + 1, "", wcf_left));
                        } else {
                            sheet1.addCell(new Label(j, i + 1, "http://pro.efeiyi.com/"+o[j].toString(), wcf_left));
                        }
                    }else {
                        if (null == o[j] || "".equals(o[j])) {
                            sheet1.addCell(new Label(j, i + 1, "", wcf_left));
                        } else {
                            sheet1.addCell(new Label(j, i + 1, o[j].toString(), wcf_left));
                        }
                    }
                }
            }

            workbook.write();
            workbook.close();
            System.out.print("OK");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return returnFileName;
    }
}
