/**
 * Created by pgwt on 2016/3/2 0002.
 */
//选择数量组建 有个三个可选部分，1 加号 2减号 3.输入框
//加号减号分别有可选状态和不可选状态，代表着组建value的上下限
//输入框有两种状态 1.可以输入 2.不可以输入 同样也共有上限下限
//加减号的组件一版作为表单的一项 还有就是加号减号都有一些毁掉函数
//js组件 通过js调用 确定组件再页面中的位置  需要父节点
//使用例子：<div class="addsub" data-option='{"upLimit":"${seckillProduct.limitAmount}","inputName":"amount"}'></div>
//需要引用 components.css文件
var ChooseCountComponent = function () {
    var parentDiv = $(".addsub");
    var options = new Object();
    options["upLimit"] = 100; //默认上限  当数值达到上限的时候 加号不可点
    options["downLimit"] = 1; //默认下限   当数值达到下限的时候 减号不可点
    options["inputStatus"] = 0; //0为不可输入  1为可输入
    options["defaultValue"] = 1;
    options["inputName"] = "";
    var componentOption = parentDiv.attr("data-option"); //json字符串
    if (typeof componentOption != "undefined") {
        componentOption = JSON.parse(componentOption);

        if (typeof componentOption["defaultValue"] == "string") {
            options["defaultValue"] = Number(componentOption["defaultValue"]);
        }
        if (typeof componentOption["upLimit"] == "string") {
            options["upLimit"] = Number(componentOption["upLimit"]);
        }
        if (typeof componentOption["downLimit"] == "string") {
            options["downLimit"] = Number(componentOption["downLimit"]);
        }
        if (typeof componentOption["inputStatus"] == "string") {
            options["inputStatus"] = Number(componentOption["inputStatus"]);
        }
        if (typeof componentOption["inputName"] == "string") {
            options["inputName"] = componentOption["inputName"];
        }
    }
    var disabled = "";
    if (options["inputStatus"]== 1){
        disabled = "disabled";
    }
    var html = '<div class="opt"><a class="sub" title="减" ></a><input name="' + options["inputName"] + '" '+disabled+' class="ipt-txt" type="text" value="' + options["defaultValue"] + '" /><a class="add" title="加" ></a></div>'
    //加号的事件
    var addAction = function (e) {
        var inputElement = $(e.target).parent().find(".ipt-txt");
        var actionOptions = options;
        var currentValue = Number(inputElement.val());
        if (Number(currentValue) < actionOptions["upLimit"]) {
            currentValue += 1;
            inputElement.val(currentValue);
        }
    }
    var subAction = function (e) {
        var inputElement = $(e.target).parent().find(".ipt-txt");
        var actionOptions = options;
        var currentValue = Number(inputElement.val());
        if (Number(currentValue) > actionOptions["downLimit"]) {
            currentValue -= 1;
            inputElement.val(currentValue);
        }
    }
    parentDiv.on("click", ".add", addAction);
    parentDiv.on("click", ".sub", subAction);
    parentDiv.html(html);
}