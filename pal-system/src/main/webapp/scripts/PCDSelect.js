/**
 * Created by Administrator on 2015/9/7.
 *  Ajax 三级省市联动
 */
var select_preHtml="<option value=''>请选择</option>";
var temp_html = "";

(function($){
    $.fn.citySelect=function(purl, curl, durl, pid, cid, did){
        if(this.length<1){return;};

        var prov_obj=$("#province");
        var city_obj=$("#city");
        var dist_obj=$("#district");

        if(cid == null || cid == ""){
            city_obj.empty().attr("disabled",true);
        }
        if(did == null || did == ""){
            dist_obj.empty().attr("disabled",true);
        }

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

        var provinceChange=function(){
            var pid = $("#province").val();
            var city_obj=$("#city");
            var dist_obj=$("#district");
            dist_obj.empty().attr("disabled",true);
            if(pid == null || pid == ""){
                city_obj.empty().attr("disabled",true);
            }else{
                $.ajax({
                    type: 'post',
                    async: false,
                    url: curl+pid,
                    dataType: 'json',
                    success: function (data) {
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

        var cityChange=function(){
            var cid = $("#city").val();
            var dist_obj=$("#district");
            if(cid == null || cid == ""){
                dist_obj.empty().attr("disabled",true);
            }else {
                $.ajax({
                    type: 'post',
                    async: false,
                    url: durl+cid,
                    dataType: 'json',
                    success: function (data) {
                        temp_html=select_preHtml;
                        $.each(data,function(i,dist){
                            temp_html+="<option value='"+dist.id+"'>"+dist.name+"</option>";
                        });
                        dist_obj.html(temp_html).attr("disabled",false).css({"display":"","visibility":""});
                        $("#district option[value='" + did + "']").attr("selected", "selected");
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

        if(cid != null && cid != ""){
            provinceChange();
        }

        if(did != null && did != ""){
            cityChange();
        }

    };
})(jQuery);
