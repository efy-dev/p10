package com.efeiyi;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2015/7/28.
 * 诚品宝验真伪常量
 */
public class PalConst {

    @Autowired
    public ResultBean trueBean;
    @Autowired
    public ResultBean fakeExistBean;
    @Autowired
    public ResultBean fakeNonExistBean;

    private static PalConst instance;

    public String pageParam1 = "serial";                              //页面传来的参数Key
    public String qryLabelCol = "serial";                             //查询表对应的字段col

    public String checkLabel = "from Label a where a.serial =:" + pageParam1;//标签验真伪查询表hql
    public String resultView = "/result";                           //标签验真伪返回页面
    public String resultLab = "result";                                //标签验真伪返回的bean
    public String resultPdu = "product";                                //标签验真伪返回的product

    public String unusedStatus = "1";                                 //查询为未使用的序列号状态
    public String trueMsg = "恭喜您，该购买商品是正品！";              //查询为未使用的序列号返回消息
    public String usedStatus = "2";                                   //查询为已使用的序列号状态
    public String fakeExistMsg = "请注意，该购买商品已被验证！";       //查询为已使用的序列号返回消息
    public String fakeNonExistMsg = "不存在的序号！";                   //查询不存在的序列号返回消息
    public String fakeLogo = "./scripts/assets/upload/fake-logo.jpg";        //查为伪的logo
    public String trueLogo = "./scripts/assets/upload/true-logo.jpg";        //查为真的logo

    public String ip = "ip";                                            //访问的IP

    private PalConst(){
        trueBean = new ResultBean();
        fakeExistBean = new ResultBean();
        fakeNonExistBean = new ResultBean();
        trueBean.setLogo(trueLogo);
        trueBean.setMsg(trueMsg);
        fakeExistBean.setLogo(fakeLogo);
        fakeExistBean.setMsg(fakeExistMsg);
        fakeNonExistBean.setLogo(fakeLogo);
        fakeNonExistBean.setMsg(fakeNonExistMsg);
    }
    public static PalConst getInstance(){

        if(instance == null){
            instance =  new PalConst();
        }
        return instance;
    }
}
