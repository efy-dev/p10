/**
 * Created by Administrator on 2015/8/25.
 */

$(function(){
    var isClick = false;
    var btnNum = 0;
    var mark = new Array("�ǳ����ȥ������", "����ǲ��������˵����", "һ�㣬������ȥ��", "�ܺã�������Ҫ�Ķ���", "̫�����ˣ�����ֻ�������У��˼��ĵü�����!");
    $('#star','.a-star').each(function (index) {
        $(this).hover(function () {
            $("#star .a-star").each(function (i){
                if (i <= index) {
                    $(this).addClass('ye-star');
                    $(this).removeClass('no-star');
                    $('#showText').html(mark[index]);
                } else {
                    $(this).addClass("no-star");
                    $(this).removeClass('ye-star');
                }
            });
        }, function(){


            var script = document.createElement('script');
            script.src = 'http://static.pay.baidu.com/resource/baichuan/ns.js';
            document.body.appendChild(script);


            $('#star?.a-star').each(function (i) {
                if (!isClick) {
                    if (i <= index) {
                        $(this).addClass("no-star");
                        $(this).removeClass('ye-star');
                    }
                } else {
                    if (i <= index) {
                        $(this).addClass("no-star");
                        $(this).removeClass('ye-star');
                    }
                    $('#showText').html(mark[btnNum]);
                    $('#star?.a-star').each(function (k) {
                        if (k <= btnNum) {
                            $(this).addClass('ye-star');
                            $(this).removeClass('no-star');
                        } else {
                            $(this).addClass("no-star");
                            $(this).removeClass('ye-star');
                        }
                    });
                }
            });
        });
        $(this).click(function () {
            $('#star?.a-star').each(function (i) {
                if (i <= index) {
                    $(this).addClass('ye-star');
                    $(this).removeClass('no-star');
                } else {
                    $(this).addClass("no-star");
                    $(this).removeClass('ye-star');
                }
            });
            btnNum = index;//���λ��?????????????????????isClick?=?true;??
        });
    });
});