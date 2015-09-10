/**
 * Created by Administrator on 2015/9/9 0009.
 */

$().ready(function(){

    $("[data-efy-choose-btn]").each(function(){
        $(this).click(function(){
            $.ajax({
                type: "post",
                url: $(this).attr("url"),
                cache: false,
                dataType: "json",
                data: {param:$(this).attr("param")} ,
                success: function(data){
                    if(data){
                        window.opener=null;
                        window.open('','_self');
                        window.close();
                    }else{
                        showAlert("提示",data);
                    }
                },
            });
        });
    });

    // url新建BaseChoose的链接 param新建BaseChoose的参数  target跳转页面的路径  finish选择完成之后的接口
    $("[data-efy-choose-input]").each(function(){
        $(this).click(function(){
            var target = $(this).attr("target");
            var finish = $(this).attr("finish")
            $.ajax({
                type: "post",
                url: $(this).attr("url"),
                cache: false,
                dataType: "json",
                success: function(data){
                    var a = "<a id='targetUrl' target=\"_blank\" href='"+target+"' ";
                    $("body").append(a);
                    $("#targetUrl").click()
                    window.open(target);
                    showConfirm("提示","是否选完？", function () {
                        $.ajax({
                            type: "post",
                            url:finish ,
                            cache: false,
                            dataType: "json",
                            data: {chooseId:data.id},
                            success: function(dataTemp){
                                $(this).val(dataTemp.modelId);
                            },
                        });
                    })
                },
            });
        });
    })

})
