<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/18
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>product</title>
</head>
<body>
<form name="form1" action="" method="post" enctype="multipart/form-data">
  <table width="95%" align="center" cellpadding="10" cellspacing="0" border="1">
    <tr>
      <td width="120">商品名称</td>
      <td><input type="text" name="proname" value=${product.name}/></td>
    </tr>
    <tr>
      <td>市场价格:</td>
      <td><input type="text" name="marketprice" value=${product.price}/></td>
    </tr>
    <tr>
      <td>销售价格:</td>
      <td><input type="text" name="saleprice" value=${product.price}/></td>
    </tr>
    <tr>
      <td>商品图片</td>
      <td><input type="file" name="proimage"  value=${product.picture_url}/></td>
    </tr>
    <tr>
      <td>商品简介</td>
      <td><textarea name="prodesc" rows="10" cols="50">青花瓷（blue and white porcelain），又称白地青花瓷，常简称青花，是中国瓷器的主流品种之一。青花是运用天然钴料在白泥上进行绘画装饰，再罩以透明釉，然后在高温1300摄氏度上下一次烧成，使色料充分渗透于坯釉之中，呈现青翠欲滴的蓝色花纹，显得幽倩美观，明净素雅。青花是中国最具汉族民族特色的瓷器装饰，是釉下彩瓷的一种，也是中国陶瓷装饰中较早发明的方法之一。
</textarea></td>
    </tr>

  </table>
</form>
</body>
</html>
