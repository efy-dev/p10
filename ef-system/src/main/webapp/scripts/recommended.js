/**
 * 推荐 取消推荐 切换
 * @param obj
 * @param td 推荐标示位于哪一列
 */
function recommended(obj,td,deleteUrl){
    //推荐  recommend 为1时 推荐  显示出排序文本框
    if($(obj).attr("recommend")=="1"){
        $(obj).next("span").css({"display":"block"});
    }
    if($(obj).attr("recommend")=="0"){
        var id = $(obj).attr("id"); //推荐对象id
        deleteRecommended(obj,id,td,deleteUrl);
    }
}

/**
 *  删除推荐对象  切换用的删除方法不直接调用
 * @param obj
 * @param id
 */
function deleteRecommended(obj,id,td,url){
    var  recommendedId = $(obj).attr("recommendedId");
    $.ajax({
        type:"get",
        url:url,
        data:{id:id},
        success:function(data){
            $(obj).attr("recommend","1");
            $(obj).attr("id","");
            $(obj).find("span").text("推荐");
            $("table tr[id='"+recommendedId+"'] td:eq("+td+") span ").remove();
        }
    });
}


/**
 *保存推荐对象
 * @param obj
 * @param groupName 组名
 * @param td 推荐标示所在列
 */
function saveRecommended(obj,groupName,td,saveUrl){
    var recommendId = $(obj).parent().prev("a").attr("recommendedId");
    var sort = $(obj).prev("input").val();
    if(sort==""){
        alert("请填写序号!");
    }else {
        $.ajax({
            type: "get",
            url: saveUrl,
            dataType: "json",
            data: {groupName: groupName, recommendId: recommendId, status: "1", sort: sort},
            success: function (data) {
                $(obj).parent("span").css({"display": "none"});
                $(obj).parent("span").find("input").val("");
                $(obj).parent().prev("a").attr("recommend", "0");
                $(obj).parent().prev("a").attr("id", data);
                $(obj).parent().prev("a").find("span").text("取消推荐");
                $("table tr[id='" + recommendId + "'] td:eq(" + td + ")").append("<span  id=" + data + " style=\"margin-left: 5px;color: red;\" >推荐(" + sort+")</span>");
            }
        });
    }
}


/**********************推荐列表有关****************/
/**
 * 跳转更新序号
 * @param obj
 */
function toUpdateSort(obj,updateUrl){
    var sort = $(obj).attr("sort");
    var id = $(obj).attr("id");
    $(obj).parent().html("<input id="+id+" onblur=\"updateSort(this,'"+updateUrl+"')\" type=\"text\" name=\"sort\" style=\"width: 35px;\" value="+sort+" />");
}

/**
 * 更新序号
 * @param obj
 */
function updateSort(obj,updateUrl){
    var sort = $(obj).val();
    var id = $(obj).attr("id");
    $.ajax({
        type: "get",
        url: updateUrl,
        cache: false,
        dataType: "json",
        data:{id:id,sort:sort},
        success: function (data) {
            $(obj).parent().html("<a onclick=\"toUpdateSort(this,'"+updateUrl+"')\" sort="+sort+" id="+id+">"+sort+"</a>");
        }
    });
}

/***
 * 删除推荐对象  可直接调用
 */
function deleteObjectRecommended(id,delteUrl){
    $.ajax({
        type:"get",
        url:delteUrl,
        data:{id:id},
        success:function(data){

            $("table tr[id='"+id+"']").remove();
        }
    });
}