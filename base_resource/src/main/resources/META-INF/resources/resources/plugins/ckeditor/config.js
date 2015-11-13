/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */
var curWwwPath=window.document.location.href;
//获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
var pathName=window.document.location.pathname;
var pos=curWwwPath.indexOf(pathName);
//获取主机地址，如： http://localhost:8083
var localhostPaht=curWwwPath.substring(0,pos);
//获取带"/"的项目名，如：/uimcardprj
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
    // 去 p
    //config.enterMode = CKEDITOR.ENTER_BR;
    //config.shiftEnterMode = CKEDITOR.ENTER_P;
    config.filebrowserImageUploadUrl = localhostPaht+projectName+"/UploadDOC/UploadDocument.do";
    config.extraPlugins += (config.extraPlugins ? ',lineheight' : 'lineheight');
};

CKEDITOR.config.toolbar_Full =
    [
        { name: 'document',        items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
        { name: 'clipboard',    items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
        { name: 'editing',        items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
        { name: 'forms',        items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
        '/',
        { name: 'basicstyles',    items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
        { name: 'paragraph',    items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
        { name: 'links',        items : [ 'Link','Unlink','Anchor' ] },
        { name: 'insert',        items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
        '/',
        { name: 'styles',        items : [ 'Styles','Format','Font','FontSize','LineHeight' ] },
        { name: 'colors',        items : [ 'TextColor','BGColor' ] },
        { name: 'tools',        items : [ 'Maximize', 'ShowBlocks','-','About' ] }
    ];