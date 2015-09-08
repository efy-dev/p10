/**
 * Created by Administrator on 2015/9/7.
 *  Ajax 三级省市联动
 */
var select_preHtml="<option value=''>请选择</option>";
var temp_html = "";

(function($){
    $.fn.pcdSelect=function(purl, curl, durl, pid, cid, did){
        if(this.length<1){return;};

        var prov_obj=$("#province");
        var city_obj=$("#city");
        var dist_obj=$("#district");

        city_obj.empty().attr("disabled",true);
        dist_obj.empty().attr("disabled",true);

        var initProvince=function(data){
            // 遍历赋值省份下拉列表
            temp_html=select_preHtml;
            $.each(data,function(i,prov){
                temp_html+="<option value='"+prov.id+"'>"+prov.name+"</option>";
            });
            prov_obj.html(temp_html);
            if(pid != null && pid != ""){
                $("#province option[value='" + pid + "']").attr("selected", "selected");
                provinceChange();
            }

            // 选择省份时发生事件
            prov_obj.bind("change",function(){
                provinceChange();
            });
            // 选择市级时发生事件
            city_obj.bind("change",function(){
                cityChange();
            });
        };

        // 赋值市级函数
        var provinceChange=function(){
            var p_id = prov_obj.val();
            dist_obj.empty().attr("disabled",true);
            city_obj.empty().attr("disabled",true);
            if(p_id != null && p_id != ""){
                $.ajax({
                    type: 'post',
                    async: false,
                    url: curl+p_id,
                    dataType: 'json',
                    success: function (data) {
                        // 遍历赋值市级下拉列表
                        if(data.length==1){
                            temp_html="";
                            $.each(data,function(i,city){
                                temp_html+="<option value='"+city.id+"'>"+city.name+"</option>";
                            });
                            city_obj.html(temp_html).attr("disabled",false).css({"display":"","visibility":""});
                            $("#city option[value='" + data[0].id + "']").attr("selected", "selected");
                            cityChange();
                        }else {
                            temp_html=select_preHtml;
                            $.each(data,function(i,city){
                                temp_html+="<option value='"+city.id+"'>"+city.name+"</option>";
                            });
                            city_obj.html(temp_html).attr("disabled",false).css({"display":"","visibility":""});
                            if(cid != null && cid != ""){
                                $("#city option[value='" + cid + "']").attr("selected", "selected");
                                cityChange();
                            }
                        }
                        cid = "";
                        did = "";
                    },
                    failure:function(msg){
                        alert(msg.toString);
                    }
                });
            }
        };

        // 赋值地区（县）函数
        var cityChange=function(){
            var c_id = city_obj.val();
            dist_obj.empty().attr("disabled",true);
            if(c_id != null && c_id != ""){
                $.ajax({
                    type: 'post',
                    async: false,
                    url: durl+c_id,
                    dataType: 'json',
                    success: function (data) {
                        // 遍历赋值市级下拉列表
                        if(data.length==1){
                            temp_html="";
                            $.each(data,function(i,dist){
                                temp_html+="<option value='"+dist.id+"'>"+dist.name+"</option>";
                            });
                            dist_obj.html(temp_html).attr("disabled",false).css({"display":"","visibility":""});
                            $("#district option[value='" + data[0].id + "']").attr("selected", "selected");
                        }else {
                            temp_html=select_preHtml;
                            $.each(data,function(i,dist){
                                temp_html+="<option value='"+dist.id+"'>"+dist.name+"</option>";
                            });
                            dist_obj.html(temp_html).attr("disabled",false).css({"display":"","visibility":""});
                            $("#district option[value='" + did + "']").attr("selected", "selected");
                        }
                        did = "";
                    },
                    failure:function(msg){
                        alert(msg.toString);
                    }
                });
            }
        }

        $.ajax({
            type: 'post',
            async: false,
            url: purl,
            dataType: 'json',
            success: function (data) {
                initProvince(data);
            },
            failure:function(msg){
                alert(msg.toString);
            }
        });

    };
})(jQuery);
