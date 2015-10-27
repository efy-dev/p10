/**
 * Created by Administrator on 2015/8/14.
 */

/**
 * 发送ajax请求的通用方法
 * @param url  请求路径
 * @param data  请求参数对象(json格式)
 * @param success  请求成功的回调
 * @param error   请求失败的回调
 * @param requestType 请求类型 （get post）
 */
function ajaxRequest(url, param, success, error,requestType) {
    if(typeof requestType == "undefined"){

    }
    $.ajax({
        type: requestType,
        url: url,
        cache: false,
        dataType: "json",
        data: param,
        success: success,
        error: error,
    });
}