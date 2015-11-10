package com.efeiyi.util;


import com.efeiyi.bean.CheckResultBean;

import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/7/28.
 * 诚品宝验真伪常量
 */
public class PalConst {

    public CheckResultBean trueBean;
    public CheckResultBean fakeBean;
    public CheckResultBean recheckTrueBean;
    public CheckResultBean recheckFakeBean;
    public CheckResultBean wrongBean;

    private static PalConst instance;

    public String checkLabelParam1 = "serial";                      //标签ID
    public String checkLabelParam2 = "code";                      //nfc防伪码
    public String productId = "id";                          //商品ID
//    public String queryRecheckLabelColumn = "id";                //二次查询码被访问次数时绑定的字段

    public String checkLabel = "from Label a where a.code =:" + checkLabelParam1;//查询标签hql
    public String viewProduct = "from Product a where a.id =:" + productId;//查询商品hql
    //    public String recheckLabel = "select new com.efeiyi.LabelRecordResult(MIN(createDatetime),MAX(createDatetime),COUNT(1) + 1,label.serial) from LabelCheckRecord where label.serial=:" + qryRecheckLabelCol;
    public String resultView = "/result";                           //标签验真伪返回页面
    public String certificateView = "/viewCertificate";                           //wap端证书详情返回页面
    public String productView = "/viewProduct";                           //wap端证书详情返回页面
    public String sourceView = "/viewSource";                           //wap端证书详情返回页面
    public String aboutUsView = "/aboutUs";                                //关于我们
    public String userManualView = "/userManual";                           //使用前必读
    public String resultLabel = "result";                                //标签验真伪返回的bean
    public String resultProduct = "product";                                //标签验真伪返回的product
    public String code = "code";                                //标签验真伪返回的product

    public String unusedStatus = "3";                                 //查询为未使用的序列号状态
    public String trueMsg = "恭喜您，您查询的商品是正品";              //查询为未使用的序列号返回消息
    public String usedStatus = "9";                                   //查询为已使用的序列号状态
    public String fakeMsg = "您查询的防伪码无效，注意防伪，谨防假冒";       //码不存在，或已失效，或未激活返回消息
    public String recheckMsg = "<div>第#N#次验证</div><div>上次验证时间#TIME#</div><div id=\"ipAddress\"></div><div>若这是您购买后首次验证，请注意伪造风险，感谢您的支持！</div>";//第N次查询返回消息
    public String weixinRecheckMsg = "第#N#次验证\n上次验证时间#TIME#\n若这是您购买后首次验证，请注意伪造风险，感谢您的支持！";//第N次查询返回消息
    public String wrongMsg = "您查询的防伪码无效，注意防伪，谨防假冒...";

    public String fakeLogo = "resources/upload/fake-logo.jpg";        //查为伪的logo
    public String trueLogo = "resources/upload/true-logo.jpg";        //查为真的logo
    public String uploadImgBaseUrl = "http://pal.efeiyi.com/";
    public int _true = 1, _false = -1, _null = 0;   //查询真伪结果, 1真 -1伪 0不显示


    public String ip = "ip";                                            //访问的IP
    public String authenticity = "authenticity";            //标签已查询次数
    public Long hour = 24l;             //查码时间跨度
    public Long timeIncrement = 1000 * 3600 * 24 * hour;//时间跨度对应毫秒
    public int timeLimit = 120000;   //查询结果页有效时间秒(2分)
    public boolean isTimeLimited = true;
    public boolean isNotTimeLimited = false;


    //    public String weiXinMsgType = "text";
    public String weiXinMsgType = "news";
    public String weiXinSubscribeEvent = "subscribe";
    public String weiXinScanEvent = "SCAN";
    public String weiXinToken = "11111111111111111111111111111111";
    public DateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
    public String baiduApiUrl = "http://api.map.baidu.com/location/ip?ak=zKrEDoOM6VCNjYDcBgpufSWR";
    public String solrUrl = "http://localhost:8080/solr-5.3.1/product/select?wt=json&indent=true&hl=true&hl.fl=product_name%2Csub_name%2Ctenant_name%2Cmaster_name&hl.simple.pre=%3Cfont+color%3D%27red%27%3E&hl.simple.post=%3C%2Ffont%3E&hl.simple.post=%3C%2Ffont%3E&q=";


    public Map<String, String> labelCache = new HashMap<String, String>();

    public String appId = "wx7f6aa253b75466dd";
    public String encodingAESKey = "vo3dJHGXZTkDCtf9kyyhiKtGdTFdzdb62CGxk1eqxkw";

    private PalConst() {
        trueBean = new CheckResultBean();
        fakeBean = new CheckResultBean();
        recheckTrueBean = new CheckResultBean();
        recheckFakeBean = new CheckResultBean();
        wrongBean = new CheckResultBean();
        trueBean.setLogo(trueLogo);
        trueBean.setMsg(trueMsg);
        trueBean.setAuthenticity(_true);
        trueBean.setIsTimeLimited(isTimeLimited);
        fakeBean.setLogo(fakeLogo);
        fakeBean.setMsg(fakeMsg);
        fakeBean.setAuthenticity(-1);
        fakeBean.setIsTimeLimited(isNotTimeLimited);
        recheckTrueBean.setLogo(trueLogo);
        recheckTrueBean.setMsg(recheckMsg);
        recheckTrueBean.setAuthenticity(_true);
        recheckTrueBean.setIsTimeLimited(isTimeLimited);
        recheckFakeBean.setLogo(fakeLogo);
        recheckFakeBean.setMsg(recheckMsg);
        recheckFakeBean.setAuthenticity(_true);
        recheckFakeBean.setIsTimeLimited(isNotTimeLimited);
        wrongBean.setAuthenticity(_false);
        wrongBean.setMsg(wrongMsg);
    }

    public static PalConst getInstance() {

        if (instance == null) {
            instance = new PalConst();
        }
        return instance;
    }

}
