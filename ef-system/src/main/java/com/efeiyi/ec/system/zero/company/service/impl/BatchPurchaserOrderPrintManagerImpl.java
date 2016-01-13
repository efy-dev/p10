package com.efeiyi.ec.system.zero.company.service.impl;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.system.zero.company.service.BatchPrintManager;
import com.ming800.core.base.service.BaseManager;
import net.sourceforge.rtf.RTFTemplate;
import net.sourceforge.rtf.context.image.FormatBase;
import net.sourceforge.rtf.context.image.ImageConstants;
import net.sourceforge.rtf.helper.RTFTemplateBuilder;
import org.apache.commons.io.IOUtils;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.krysalis.barcode4j.impl.code39.Code39Bean;
import org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider;
import org.krysalis.barcode4j.tools.UnitConv;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.image.BufferedImage;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by Administrator on 2016/1/13.
 */
@Service
public class BatchPurchaserOrderPrintManagerImpl implements BatchPrintManager {

    @Autowired
    private BaseManager baseManager;
    private String path = Thread.currentThread().getContextClassLoader().getResource("").getPath();

    /**
     * 下载运单
     * @param purchaseOrderProductList
     * @return
     * @throws Exception
     */
    @Override
    public File downloadFiles(List purchaseOrderProductList) throws Exception {

        List<File> fileList = new ArrayList<>(purchaseOrderProductList.size());
        for (Object object : purchaseOrderProductList) {

            PurchaseOrderProduct purchaseOrderProduct = (PurchaseOrderProduct) object;
            File docTarget = executeWrite(purchaseOrderProduct.getPurchaseOrder());
            fileList.add(docTarget);
            purchaseOrderProduct.getPurchaseOrder().setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderProduct.getPurchaseOrder());
        }

        return zipFiles(fileList, new File(path + "/" + System.currentTimeMillis() + ".rar"));
    }

    /**
     * 压缩运单文件
     *
     * @param fileList
     * @param zipFile
     * @return
     * @throws Exception
     */
    private File zipFiles(List<File> fileList, File zipFile) throws Exception {
        ZipOutputStream zipOutputStream = new ZipOutputStream(new FileOutputStream(zipFile));

        FileInputStream inputStream = null;
        BufferedInputStream bufferedInputStream = null;
        for (File file : fileList) {
            try {
                inputStream = new FileInputStream(file);
                bufferedInputStream = new BufferedInputStream(inputStream, 512);
                //org.apache.tools.zip.ZipEntry
                ZipEntry entry = new ZipEntry(file.getName());
                zipOutputStream.putNextEntry(entry);
                // 向压缩文件中输出数据
                int nNumber;
                byte[] buffer = new byte[512];
                while ((nNumber = bufferedInputStream.read(buffer)) != -1) {
                    zipOutputStream.write(buffer, 0, nNumber);
                }
            } catch (Exception e) {
                throw e;
            } finally {
                // 关闭创建的流对象
                bufferedInputStream.close();
                inputStream.close();
            }
        }
        zipOutputStream.close();
        return zipFile;
    }

    /**
     * RTF模板输出运单
     *
     * @param purchaseOrder
     * @return
     * @throws Exception
     */
    private File executeWrite(PurchaseOrder purchaseOrder) throws Exception {

        File rtfSource = new File(path + "/wayBillTemplate.rtf");
        File docTarget = new File(path + "/" + purchaseOrder.getSerial() + ".rtf");
        RTFTemplateBuilder builder = RTFTemplateBuilder.newRTFTemplateBuilder();
        RTFTemplate rtfTemplate = builder.newRTFTemplate();
        rtfTemplate.setTemplate(rtfSource);
        rtfTemplate.put("receiverName", purchaseOrder.getReceiverName());//把rtfSource 文件中的"$apId"替换成"a"
        rtfTemplate.put("receiverPhone", purchaseOrder.getReceiverPhone());
        rtfTemplate.put("address", purchaseOrder.getPurchaseOrderAddress());
        rtfTemplate.put("bigPen", purchaseOrder.getPurchaseOrderDeliveryList().get(0).getBigPen());
        rtfTemplate.put("to", purchaseOrder.getCity().getName());
        rtfTemplate.put("barCode", generateBarCode(purchaseOrder.getPurchaseOrderDeliveryList().get(0).getSerial(), 1.8f));
        rtfTemplate.merge(docTarget);
        removeEscapeCharacter(docTarget);
        return docTarget;
    }

    /**
     * 生成条形码
     *
     * @param mailNo
     * @param size
     * @return
     * @throws IOException
     */
    private String generateBarCode(String mailNo, float size) throws IOException {

        //Create the barcode bean
        Code39Bean bean = new Code39Bean();
        final int dpi = 150;
        //Configure the barcode generator
        bean.setModuleWidth(UnitConv.in2mm(size / dpi)); //makes the narrow bar
        //width exactly one pixel
        bean.setWideFactor(3);
        bean.doQuietZone(false);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ByteArrayInputStream in = null;
        try {
            //Set up the canvas provider for monochrome JPEG output
            BitmapCanvasProvider canvas = new BitmapCanvasProvider(
                    out, "image/jpeg", dpi, BufferedImage.TYPE_BYTE_BINARY, false, 0);

            //Generate the barcode
            bean.generateBarcode(canvas, mailNo);
            //Signal end of generation
            canvas.finish();
            in = new ByteArrayInputStream(out.toByteArray());
            return format(in).toString();
        } finally {
            out.close();
            in.close();
        }
    }

    /**
     * 图片转为16进制，添加RTF图片头
     *
     * @param in
     * @return
     * @throws IOException
     */
    private StringBuffer format(InputStream in) throws IOException {

        byte[] imagedata = null;
        try {
            imagedata = IOUtils.toByteArray(in);
        } catch (Exception e) {
            throw e;
        } finally {
            IOUtils.closeQuietly(in);
        }
        StringBuffer buf = new StringBuffer("");
        if (imagedata != null) {
            // Test if image date is image
            FormatBase imageformat = FormatBase.determineFormat(imagedata);
            if (!(imageformat.getType() == ImageConstants.I_NOT_SUPPORTED
                    | imageformat.getRtfTag() == "")) {

                buf = new StringBuffer(imagedata.length * 3);

                for (int i = 0; i < imagedata.length; i++) {
                    int iData = imagedata[i];

                    // Make positive byte
                    if (iData < 0) {
                        iData += 256;
                    }

                    if (iData < 16) {
                        // Set leading zero and append
                        buf.append('0');
                    }
                    buf.append(Integer.toHexString(iData));
                }

                buf.insert(0, "{\\*\\shppict{\\pict\\wmetafile8\\picw9155\\pich2778\\picwgoal5190\\pichgoal1575 \n");
                buf.append("}}");

            }
        }
        return buf;
    }

    /**
     * 移除RTFTemplate输出图片时产生的转义字符\
     *
     * @param file
     * @throws Exception
     */
    private void removeEscapeCharacter(File file) throws Exception {
        FileInputStream fis = null;
        FileOutputStream fos = null;
        try {
            fis = new FileInputStream(file);
            byte[] b = new byte[(int) file.length()];
            fis.read(b);
            String content = new String(b);
            content = content.replace("\\{", "{").replace("\\}", "}");
            fos = new FileOutputStream(file);
            fos.write(content.getBytes());
        } catch (Exception e) {
            throw e;
        } finally {
            fis.close();
            fos.close();
        }
    }
}

