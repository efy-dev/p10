<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="am-modal am-modal-confirm" tabindex="-1" id="my-confirm">
    <div class="am-modal-dialog">
        <%--<div class="am-modal-hd">删除确认</div>--%>
        <div class="am-modal-bd">
            <div id="DValue" style="display:none">确定要删除吗？</div>
            <div id="AValue" style="display:none">确定要激活标签吗？</div>
            <div id="CValue" style="display:none">确定要作废标签吗？</div>
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            <span class="am-modal-btn" data-am-modal-confirm>确定</span>
        </div>
    </div>
</div>
