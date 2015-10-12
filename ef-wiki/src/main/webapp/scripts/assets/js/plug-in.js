/**
 * Created by Administrator on 2015/10/10.
 */
//判断:当前元素是否是被筛选元素的子元素
jQuery.fn.isChildOf = function(b){
    return (this.parents(b).length > 0);
};
//判断:当前元素是否是被筛选元素的子元素或者本身
jQuery.fn.isChildAndSelfOf = function(b){
    return (this.closest(b).length > 0);
};