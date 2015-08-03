package com.ming800.core.taglib;



import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-7
 * Time: 下午4:33
 * To change this template use File | Settings | File Templates.
 */
public class DictionaryTag extends TagSupport {
    private String name;
    private String type;                //select radio
    private String entity;
    private String dataType;
    private String checkedValue;        //选中值
    private String defaultValue;        //默认值
    private String onclick;
    private String htmlTag;
    private String required;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public String getCheckedValue() {
        return checkedValue;
    }

    public void setCheckedValue(String checkedValue) {
        this.checkedValue = checkedValue;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public String getOnclick() {
        return onclick;
    }

    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRequired() {
        return required;
    }

    public void setRequired(String required) {
        this.required = required;
    }

    @Override
    public int doStartTag() {
   //     this.getHtmlTag();
        return SKIP_BODY;   //忽略对body的处理
    }

    @Override
    public int doEndTag() throws JspException {
        JspWriter out = pageContext.getOut();
        try {
            out.println(htmlTag); //页面中显示的内容
        } catch (IOException e) {
            throw new JspException(e);
        }
        return EVAL_PAGE; //继续处理页面内容
    }
  /*
    private void getHtmlTag() {
        if (type == null) {
            htmlTag = this.getSelectTag();
        } else {
            switch (type) {
                case "select":
                    htmlTag = this.getSelectTag();
                    break;
                case "radio":
                    htmlTag = this.getRadioTag();
                    break;
                default:
                    htmlTag = this.getSelectTag();
                    break;
            }
        }
    }

 public String getSelectTag() {
     //   DictionaryDataManager dictionaryDataManager = (DictionaryDataManager) ApplicationContextUtil.getApplicationContext().getBean("dictionaryDataManagerImpl");
     //   List<DictionaryData> dictionaryDataList = dictionaryDataManager.getDictionaryDataList(this.dataType);

        ModuleManager moduleManager = (ModuleManager) ApplicationContextUtil.getApplicationContext().getBean("moduleManagerImpl");
        if (moduleManager.fetchXentity(entity) == null) {
            try {
                throw new Exception("不存在的entity:" + entity);
            } catch (Exception e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
        }
     //   Dictionary dictionary = (Dictionary) moduleManager.fetchXentity(entity).getFieldMap().get(name);

  //      if (dictionary != null && (required == null || required.equals(""))) {
            required = dictionary.getRequired();
        }

        if (dictionaryDataList == null) {
            return "无查询数据";
        }
        StringBuilder htmlTagBuffer = new StringBuilder();
        htmlTagBuffer.append("<select name=\"").append(name).append("\"");
        if (onclick != null) {
            htmlTagBuffer.append(" onclick=").append(onclick);
        }

        if (required != null && required.equals("true")) {
            htmlTagBuffer.append(" class=\"selectValidate\"");
        }
        htmlTagBuffer.append(">");
        htmlTagBuffer.append("<option value=\"\">请选择</option>");
        for (int i = 0; i < dictionaryDataList.size(); i++) {
            DictionaryData dictionaryData = dictionaryDataList.get(i);
            htmlTagBuffer.append("<option value=\"")
                    .append(dictionaryData.getId())
                    .append("\"");
            if (checkedValue != null && checkedValue.equals(dictionaryData.getId())) {
                htmlTagBuffer.append("selected=\"selected\"");
            } else if (defaultValue != null && Integer.parseInt(defaultValue) == i + 1) {
                htmlTagBuffer.append("selected=\"selected\"");
            }
            htmlTagBuffer.append(">")
                    .append(dictionaryData.getData())
                    .append("</option>");
        }
        htmlTagBuffer.append("</select>");
        return htmlTagBuffer.toString();
    }

    public String getRadioTag() {
        DictionaryDataManager dictionaryDataManager = (DictionaryDataManager) ApplicationContextUtil.getApplicationContext().getBean("dictionaryDataManagerImpl");

        ModuleManager moduleManager = (ModuleManager) ApplicationContextUtil.getApplicationContext().getBean("moduleManagerImpl");
        Dictionary dictionary = (Dictionary) moduleManager.fetchXentity(entity).getFieldMap().get(name);

        if (dictionary != null && (required == null || required.equals(""))) {
            required = dictionary.getRequired();
        }

        List<DictionaryData> dictionaryDataList = dictionaryDataManager.getDictionaryDataList(this.dataType);
        if (dictionaryDataList == null) {
            return "无查询数据";
        }
        StringBuilder htmlTagBuffer = new StringBuilder();
        for (int i = 0; i < dictionaryDataList.size(); i++) {
            DictionaryData dictionaryData = dictionaryDataList.get(i);
            htmlTagBuffer.append("<input type=\"radio\" name=\"").append(name).append("\" value=\"").append(dictionaryData.getId()).append("\"");
            if (checkedValue != null && checkedValue.equals(dictionaryData.getId())) {
                htmlTagBuffer.append(" checked=\"checked\"");
            } else if (defaultValue != null && Integer.parseInt(defaultValue) == i + 1) {
                htmlTagBuffer.append(" checked=\"checked\"");
            }
            if (onclick != null) {
                htmlTagBuffer.append(" onclick=").append(onclick);
            }
            if (i == 0 && required != null && required.equals("true")) {
                htmlTagBuffer.append(" class=\"radioValidate\"");
            }
            htmlTagBuffer.append(" />").append(dictionaryData.getData()).append("&nbsp");
        }
        return htmlTagBuffer.toString();
    }*/
}
