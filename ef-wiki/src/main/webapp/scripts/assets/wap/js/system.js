$(function(){
    //头部无logoA
    $('#menu').click(function(){
        $(this).hide();
        $('#menu2').show();
        $('.menu-list').slideDown();
    });
    $('#menu2').click(function() {
        $(this).hide();
        $('#menu').show();
        $('.menu-list').slideUp();
    })
    //


    //大师---作品
    var oParent=$('.master-works');
    oParent.find('.user').css('height',oParent.find('.img-bg').height()+'px');
    oParent.find('.user-nav li').click(function(){
        $(this).addClass('active').siblings('li').removeClass('active');
        $(this).append('<i class="user-arrow-up"></i>').siblings('li').find('.user-arrow-up').remove();
    });
    //
    $('img').load(function(){
        var box = $('.item');
        var boxHeight = {
            leftBox:[],
            centerBox:[],
            rightBox:[]
        }

        for(var i=0;i<box.length;i++){
            var now = i%3;		//now的值为0，1，2

            switch(now){
                case 0:
                    box.eq(i).css('left','10px');
                    boxHeight.leftBox.push(box.eq(i).height());
                    var now2 = Math.floor(i/3);

                    if(now2==0){
                        box.eq(i).css('top',0);
                    }else{
                        var total = 0;
                        for(var j=0;j<now2;j++){
                            total += boxHeight.leftBox[j]+10;
                        }
                        box.eq(i).css('top',total+'px')
                    }

                    break;

                case 1:
                    box.eq(i).css('left','270px');
                    boxHeight.centerBox.push(box.eq(i).height());
                    var now2 = Math.floor(i/3);

                    if(now2==0){
                        box.eq(i).css('top',0);
                    }else{
                        var total = 0;
                        for(var j=0;j<now2;j++){
                            total += boxHeight.centerBox[j]+10;
                        }
                        box.eq(i).css('top',total+'px')
                    }
                    break;

                case 2:
                    box.eq(i).css('left','530px');
                    boxHeight.rightBox.push(box.eq(i).height());
                    var now2 = Math.floor(i/3);

                    if(now2==0){
                        box.eq(i).css('top',0);
                    }else{
                        var total = 0;
                        for(var j=0;j<now2;j++){
                            total += boxHeight.rightBox[j]+10;
                        }
                        box.eq(i).css('top',total+'px')
                    }
                    break;
            }
        }
    });



})

var afterNum=1;

function getData3(url){
    $.ajax({
        type:"get",//设置get请求方式
        url:url+afterNum,//设置请求的脚本地址
        data:"",//设置请求的数据
        dataType:"json",//设置请求返回的数据格式
        success:function(data){
            var pubu = $("#attention");
            if(data && data.length>=1){
                for(i in data){
                for(var key in data[i]){
                    var box = $(" <li> <div class='suit-zt--2-img am-u-sm-5 am-u-end'>" +
                        " <a href='/base/brifProject.do?projectId="+data[i][key].project.id+"'><img src='"+data[i][key].project.picture_url+"'> " +
                        "<div class='tp-bg-0'> " +
                        "<table> <tr><td>" +
                        "<div style='padding: 0 1rem;'>"+data[i][key].project.name+"</div></td></tr> </table> " +
                        "</div></a> </div> <div class='suit-zt--2-text am-u-sm-7 am-u-end'> " +
                        "<h4>"+data[i][key].project.name+"详情更新了</h4> <p>" +
                        "<a href=\""+ getRootPath()+"/base/brifProject.do?projectId="+data[i][key].project.id+"\"> 增加相关作品"+key+"幅</a></p> </div> </li> </ul>");

                }

                    pubu.append(box);

                }

            }else{
                alert("暂时没有更新，敬请期待")
            }
            PBL("#after","#attention",2);
        },
        error:function(){

            alert("出错了，请联系管理员！！！");
            return false;
        },
        complete:function(){

        }
    });
}


function getRootPath(){
    var curWwwPath=window.document.location.href;
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    var localhostPaht=curWwwPath.substring(0,pos);
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    return(localhostPaht+projectName);
}

//120201工艺-----关注-------轮播
(function(){
    var leaderUl=$('.great .suit-focus .div-list ul');
    var leaderLi=leaderUl.find('li');
    var leaderLiW=leaderLi.eq(0).outerWidth(true);
    var cur=0;
    leaderUl.css('width',leaderLiW*leaderLi.length+'px')
    //向右移动
    $('.great .bot-btn').click(function(){
        cur++;
        $(this).siblings('.btn-gz').animate({'opacity':'1'},0);
        if(leaderLi.length%2==0){
            if(cur<=leaderLi.length/(cur+1)+1){
                leaderUl.stop(true,true).animate({'margin-left':-(leaderLiW*2)*cur+'px'},500);
            }
            if(cur==leaderLi.length/(cur+1)+1){
                cur=leaderLi.length/2-1;
                $(this).parents('.suit-focus').append('<a href="#上一页" title="上一页" class="btn-gz bot-btn opa02"></a>');
                $(this).animate({'opacity':'0'},0);

            }
        }else{
            if(cur<=(leaderLi.length+1)/(cur+1)+1){
                leaderUl.stop(true,true).animate({'margin-left':-(leaderLiW*2)*cur+'px'},500);
            }
            if(cur==(leaderLi.length+1)/(cur+1)+1){
                $(this).hide();
            }
        }
        return false;
    });
    //向左移动
    $('.great .top-btn').click(function(){
        cur--;
        $(this).siblings('.btn-gz').animate({'opacity':'1'},0);
        $(this).siblings('.opa02').remove();
        if(cur>0){
            leaderUl.stop(true,true).animate({'margin-left':-(leaderLiW*2)*cur+'px'},500);
        }
        if(cur<=0){
            cur=0;
            $(this).animate({'opacity':'0.2'},0);
            leaderUl.stop(true,true).animate({'margin-left':-(leaderLiW*2)*cur+'px'},500);
        }
        return false;
    })

})();