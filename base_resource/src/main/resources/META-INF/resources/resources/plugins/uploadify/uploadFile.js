function initUploadFile(uploadId, divId, objectId, objectType, branchId) {

    var tempProjectName = m8u.projectName();
    $('#' + uploadId).uploadify({
        'formData': {
            'objectType': objectType,
            'objectId': objectId,
            'branchId': branchId
        },
        'fileSizeLimit': '100MB',
        'successTimeout': 10000,
        'buttonText': '上传图片',
        'buttonClass': 'some-class',
        'swf': tempProjectName + '/scripts/uploadify/uploadify.swf?m=' + Math.random(),
        'uploader': tempProjectName + '/ossUpload/fileUpload.do',
        'onUploadSuccess': function (file, data, response) {
            var jsonData = eval('(' + data + ')');

            var tagStr = '<div class="">';

            tagStr += "<img src=\"http://m80.oss-cn-hangzhou.aliyuncs.com/" + jsonData.url + "\" width=\"70%\">";
            tagStr += jsonData.name;
            tagStr += "<input type='hidden' name='fileUploadIds' value='" + jsonData.id + "'/>";
            tagStr += "(<a href=\"###\" onclick=\"deleteFileUploadRecord('" + jsonData.id + "', this)\" >删除</a>)";
            tagStr += "</div>";

            $("#" + divId).append(tagStr);
        }
    });
}

function deleteFileUploadRecord(recordId, button) {

    jQuery.ajax({
        type: "post",
        url: m8u.projectName() + "/basic/xmj.do",
        data: {
            qm: 'deleteFileUploadRecord',
            id: recordId
        },
        dataType: 'json',
        success: function (data) {
            $(button).parent("div").remove();
        }
    });
}