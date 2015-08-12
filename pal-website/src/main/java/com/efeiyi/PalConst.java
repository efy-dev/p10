package com.efeiyi;


import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2015/7/28.
 * 诚品宝验真伪常量
 */
public class PalConst {

    public ResultBean trueBean;
    public ResultBean fakeBean;
    public ResultBean recheckTrueBean;
    public ResultBean recheckFakeBean;

    private static PalConst instance;

    public String pageParam1 = "serial";                              //页面传来的参数Key
    public String queryLabelColumn = "serial";                             //查询表对应的字段col
    public String queryRecheckLabelColumn = "id";                //二次查询码被访问次数时绑定的字段

    public String checkLabel = "from Label a where a.serial =:" + pageParam1;//标签验真伪查询表hql
//    public String recheckLabel = "select new com.efeiyi.LabelRecordResult(MIN(createDatetime),MAX(createDatetime),COUNT(1) + 1,label.serial) from LabelCheckRecord where label.serial=:" + qryRecheckLabelCol;
    public String resultView = "/result";                           //标签验真伪返回页面
    public String resultLabel = "result";                                //标签验真伪返回的bean
    public String resultProduct = "product";                                //标签验真伪返回的product

    public String unusedStatus = "1";                                 //查询为未使用的序列号状态
    public String trueMsg = "恭喜您，您查询的商品是正品";              //查询为未使用的序列号返回消息
    public String usedStatus = "2";                                   //查询为已使用的序列号状态
    public String fakeMsg = "您查询的防伪码无效，注意防伪，谨防假冒";       //码不存在，或已失效，或未激活返回消息
    public String recheckMsg = "第#N#次验证，上次验证时间#TIME#，地点，若这是您购买后首次验证，请注意伪造风险，感谢您的支持！";//第N次查询返回消息
    public String fakeLogo = "resources/upload/fake-logo.jpg";        //查为伪的logo
    public String trueLogo = "resources/upload/true-logo.jpg";        //查为真的logo
    public int _true = 1,_false = -1,_null = 0;   //查询真伪结果, 1真 -1伪 0不显示


    public String ip = "ip";                                            //访问的IP
    public Long hour = 24l;             //查码时间跨度
    public Long timeIncrement = 1000 * 3600 * 24 * hour;//时间跨度对应毫秒


    public String weiXinMsgType = "text";
    public String weiXinSubscribeEvent = "subscribe";

    private PalConst(){
        trueBean = new ResultBean();
        fakeBean = new ResultBean();
        recheckTrueBean = new ResultBean();
        recheckFakeBean = new ResultBean();
        trueBean.setLogo(trueLogo);
        trueBean.setMsg(trueMsg);
        trueBean.setAuthenticity(_true);
        fakeBean.setLogo(fakeLogo);
        fakeBean.setMsg(fakeMsg);
        fakeBean.setAuthenticity(-1);
        recheckTrueBean.setLogo(trueLogo);
        recheckTrueBean.setMsg(recheckMsg);
        recheckTrueBean.setAuthenticity(_true);
        recheckFakeBean.setLogo(fakeLogo);
        recheckFakeBean.setMsg(recheckMsg);
        recheckFakeBean.setAuthenticity(_true);
    }
    public static PalConst getInstance(){

        if(instance == null){
            instance =  new PalConst();
        }
        return instance;
    }
}
