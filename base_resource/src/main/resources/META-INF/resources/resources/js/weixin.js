/**
 * Created by Administrator on 2015/12/25 0025.
 */
//调用微信接口的步骤 1.获取access_token 2获得jsapi_tickit 3 生成signature 4 缓存signature 7200秒
//获取accesstoken的步骤最好在服务端做，为了安全性考虑最后js端获得的只是signatrue 其他的都在服务端做

//初始化微信参数
function initWx(initUrl) {
    var noncestr = "Wm3WZYTPz0wzccnW";
    var timestamp = new Date().getTime();
    var config = {
        debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        appId: 'wx7f6aa253b75466dd', // 必填，公众号的唯一标识
        timestamp: timestamp, // 必填，生成签名的时间戳
        nonceStr: noncestr, // 必填，生成签名的随机串
        signature: '',// 必填，签名，见附录1
        jsApiList: ["onMenuShareTimeline",
            "onMenuShareAppMessage",
            "onMenuShareQQ",
            "onMenuShareWeibo",
            "onMenuShareQZone"] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    };
    ajaxRequest(initUrl, {"noncestr": noncestr, "timestamp": timestamp}, function (data) {
        config.signature=data;
    },function(){},"get");

    wx.config(config);

}