package com.efeiyi.ec.system.zero.company.util;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
import com.ming800.core.util.ApplicationContextUtil;
import net.sourceforge.rtf.RTFTemplate;
import net.sourceforge.rtf.context.image.FormatBase;
import net.sourceforge.rtf.context.image.ImageConstants;
import net.sourceforge.rtf.helper.RTFTemplateBuilder;
import org.apache.commons.io.IOUtils;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.krysalis.barcode4j.impl.code39.Code39Bean;
import org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider;
import org.krysalis.barcode4j.tools.UnitConv;

import javax.print.*;
import javax.print.attribute.DocAttributeSet;
import javax.print.attribute.HashDocAttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.swing.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Created by Administrator on 2016/1/6.
 */
public class BatchPrintReactor implements Runnable {
    private SessionFactory sessionFactory = ((SessionFactory) ApplicationContextUtil.getApplicationContext().getBean("scheduleSessionFactory"));
    private List<PurchaseOrderProduct> purchaseOrderProductList;
    private Session session;
    public static AtomicInteger runningFlag = new AtomicInteger(0);
    public static final int idle = 0;
    public static final int busy = 1;
    private String path;//模板和输出打印文件的路径

    public BatchPrintReactor(List<PurchaseOrderProduct> purchaseOrderProductList) {
        this.purchaseOrderProductList = purchaseOrderProductList;
        path = Thread.currentThread().getContextClassLoader().getResource("").getPath();
    }

    @Override
    public void run() {
        try {
            session = sessionFactory.openSession();
            for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrderProductList) {
                purchaseOrderProduct = (PurchaseOrderProduct) session.get(PurchaseOrderProduct.class.getName(), purchaseOrderProduct.getId());
                File docTarget = executeWrite(purchaseOrderProduct.getPurchaseOrder());
                executePrint(docTarget);
                purchaseOrderProduct.getPurchaseOrder().setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE);
                session.saveOrUpdate(purchaseOrderProduct.getPurchaseOrder());
                session.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            BatchPrintReactor.runningFlag.compareAndSet(busy, idle);
        }
    }

    private File executeWrite(PurchaseOrder purchaseOrder) throws Exception {

        File rtfSource = new File(path + "/wayBillTemplate.rtf");
        File docTarget = new File(path + "/" + purchaseOrder.getSerial() + ".rtf");
        RTFTemplateBuilder builder = RTFTemplateBuilder.newRTFTemplateBuilder();
        RTFTemplate rtfTemplate = builder.newRTFTemplate();
        rtfTemplate.setTemplate(rtfSource);
        rtfTemplate.put("receiverName", purchaseOrder.getReceiverName());//把rtfSource 文件中的"$apId"替换成"a"
        rtfTemplate.put("receiverPhone", purchaseOrder.getReceiverPhone());
        rtfTemplate.put("address", purchaseOrder.getPurchaseOrderAddress());
        rtfTemplate.put("barCode", generateBarCode(purchaseOrder.getPurchaseOrderDeliveryList().get(0).getSerial(), 1.8f));
        rtfTemplate.merge(docTarget);
        removeEscapeCharacter(docTarget);
        return docTarget;
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
     * 打印
     */
    private void executePrint(File docTarget) {
        ComThread.InitSTA();
        ActiveXComponent wd = new ActiveXComponent("Word.Application");
        try {
            // 不打开文档
            Dispatch.put(wd, "Visible", new Variant(false));
            Dispatch document = wd.getProperty("Documents").toDispatch();
            // 打开文档
            Dispatch doc = Dispatch.invoke(document, "Open", Dispatch.Method,
                    new Object[] { docTarget.getAbsolutePath() }, new int[1]).toDispatch();
            // 开始打印
            Dispatch.callN(doc, "PrintOut", new Object[]{});
            wd.invoke("Quit", new Variant[]{});
            deleteOldFile(docTarget);
        } catch (Exception e) {


            e.printStackTrace();
        } finally {
            // 始终释放资源
            ComThread.Release();
        }
    }

    /**
     * 删除旧文件，重命名新文件，防止
     * @param docTarget
     */
    private void deleteOldFile(File docTarget) {
        File file = new File(docTarget.getAbsolutePath().substring(0, docTarget.getAbsolutePath().lastIndexOf(".")));
        if(file.exists()){
            file.delete();
        }
        docTarget.renameTo(file);
    }
}
