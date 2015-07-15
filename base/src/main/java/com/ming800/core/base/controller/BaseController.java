package com.ming800.core.base.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.does.model.Xentity;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.DateUtil;
import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.base.util.SystemValueUtil;
import com.ming800.core.base.util.ValueObjectUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import javax.servlet.http.HttpServletRequest;
import java.beans.PropertyEditorSupport;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-8
 * Time: 下午2:23
 * To change this template use File | Settings | File Templates.
 */
public class BaseController {


    @Autowired
    protected XdoManager xdoManager;
    @Autowired
    protected BaseManager baseManager;

    @Autowired
    protected ModuleManager moduleManager;

    @Autowired
    protected DoManager doManager;


    /**
     * Set up a custom property editor for converting form inputs to real objects
     *
     * @param request the current request
     * @param binder  the data binder
     */
    @InitBinder
    public void InitBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
        // 不要删除下行注释!!!   将来"yyyy-MM-dd"将配置到properties文件中
//        SimpleDateFormat dateFormat = new SimpleDateFormat(getText("date.format", request.getLocale()));
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        dateFormat.setLenient(false);
//        binder.registerCustomEditor(Date.class, null, new CustomDateEditor(dateFormat, true));

        binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                if (!StringUtils.hasText(text)) {
                    return;
                } else {
                    setValue(DateUtil.parseAllDate(text));
                }
            }
        });

        binder.registerCustomEditor(String.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
//                if (!StringUtils.hasText(text)) {
//                    return;
//                } else {
                setValue(SystemValueUtil.transformSpecialSymbol(text));
//                }
            }
        });

    }


    /**
     * 根据entityName 返回一个实例化对象并赋值
     * 如果id存在  则读取数据库中的对象 request中传入的属性值（非空，非空字符串）会覆盖数据库中获取的属性值
     *
     * @param entityName xml中配置的entity的name
     * @param request    页面传入的参数
     * @return
     * @throws Exception
     */
    public Object preProcessEntity(String entityName, HttpServletRequest request) throws Exception {
        String entityClassName = "";
        Xentity xentity = moduleManager.fetchXentity(entityName);
        if (xentity == null) {
            throw new Exception("不存在对象");
        } else {
            entityClassName = xentity.getModel();
        }
        Object object = Class.forName(entityClassName).newInstance();
        return this.preProcessObject(object, request);
    }

    /**
     * 根据entityName 为实例化对象赋值
     * 如果id存在  则读取数据库中的对象 request中传入的属性值（非空，非空字符串）会覆盖数据库中获取的属性值
     *
     * @param tempObject1 实例化对象
     * @param request     页面传入的参数
     * @return
     * @throws Exception
     */
    public Object preProcessObject(Object tempObject1, HttpServletRequest request) throws Exception {
        String type = "add";

        Class classObject1 = tempObject1.getClass();
        Object tempObject2 = classObject1.newInstance();

        /*判断对象id是否为空*/
        Object id = ReflectUtil.getFieldValue(tempObject1, "id");
        if (id != null) {
            type = "edit";
            tempObject2 = baseManager.getObject(tempObject1.getClass().getName(), id.toString());
        }

        tempObject2 = generateResult(tempObject1, classObject1, type, tempObject2, request);

        return tempObject2;
    }

    /*返回对象的保存*/
    public Object manulSaveOrUpdate(Object tempObject1) throws Exception {
        String type = "add";

        Class classObject1 = tempObject1.getClass();
        Object tempObject2 = classObject1.newInstance();

        /*判断对象id是否为空*/
        Object id = ReflectUtil.getFieldValue(tempObject1, "id");
        if (id != null) {
            type = "edit";
            tempObject2 = baseManager.getObject(tempObject1.getClass().getName(), id.toString());
        }

        tempObject2 = generateResult(tempObject1, classObject1, type, tempObject2);

        return tempObject2;
    }

    /*不返回对象的保存*/
    public void saveOrUpdateObject(Object tempObject1) throws Exception {
        Object tempObject2 = manulSaveOrUpdate(tempObject1);
        baseManager.saveOrUpdate(tempObject2.getClass().getName(), tempObject2);
    }


    public Object generateResult(Object tempObject1, Class classObject1, String type, Object tempObject2) throws Exception {
        return this.generateResult(tempObject1, classObject1, type, tempObject2, null);
    }

    public Object generateResult(Object tempObject1, Class classObject1, String type, Object tempObject2, HttpServletRequest request) throws Exception {

        Field[] field1s = classObject1.getDeclaredFields();
        for (Field field : field1s) {
            //不拷贝static成员和final成员
            if (Modifier.isStatic(field.getModifiers()) || Modifier.isFinal(field.getModifiers())) {
                continue;
            }
            field.setAccessible(true);

            Object objectValue = null;
            if (request != null) {        //request不为空时从request中取值
                objectValue = this.getFieldValue(field, request);
            } else {
                objectValue = field.get(tempObject1);
            }

//            boolean hasAnnotation = field.isAnnotationPresent(FieldValue.class);
//            if (hasAnnotation) {
//                FieldValue annotation = field.getAnnotation(FieldValue.class);
//                String annotationValue = annotation.value();
//                String annotationType = annotation.type();
//
//                if (annotationType.equals("save")) {
//                    /*判断数据字典的id是否为空字符串*/
//                    if (annotationValue.equals("DICTIONARY")) {
//
//                        if (objectValue != null) {
//                            String dictionaryId = ValueObjectUtil.getValueObject("id", objectValue);
//                            if (dictionaryId != null && dictionaryId.equals("")) {
//                                objectValue = null;
//                            }
//                        }
//
//                    } else if (type.equals("add") && objectValue == null) {
//                    /*只有当新建的时候 转换默认的值   MY_USER...*/
//                        objectValue = SystemValueUtil.getValue(annotationValue, "object");
//                    }
//                }
//
//            }

            /*判断传入的id是否为空字符串*/
            if (objectValue != null && objectValue.getClass().getName().startsWith("com.ming800")) {
                String dictionaryId = ValueObjectUtil.getValueObject("id", objectValue);
                if (dictionaryId != null && dictionaryId.equals("")) {
                    objectValue = null;
                }
            }

            /*修改的时候判断属性值是否和上次相等，相等的话，不进行修改，进入下一次循环*/
            if (type.equals("edit") && SystemValueUtil.isEqual(field.getName(), objectValue, tempObject2)) {
                continue;
            }
            field.set(tempObject2, objectValue);
        }

        /*如果tempObject1有父类，读取*/
        if (!classObject1.getSuperclass().getName().equals("java.lang.Object")) {
            tempObject2 = generateResult(tempObject1, classObject1.getSuperclass(), type, tempObject2, request);
        }

        return tempObject2;
    }

    /**
     * 从request中获取字段名对应的值
     *
     * @param field   字段
     * @param request
     * @return 字段值
     * @throws Exception
     */
    public Object getFieldValue(Field field, HttpServletRequest request) throws Exception {
        Object objectValue = null;
        if (field.getType().getName().startsWith("com.ming800")) {        //子表
//            if (field.getType().getName().startsWith("com.ming800")) {        //子表
            String fieldValue = request.getParameter(field.getName() + ".id");
            if (fieldValue != null && !fieldValue.equals("")) {
                Object tempObject = Class.forName(field.getType().getName()).newInstance();
                Field tempField = tempObject.getClass().getDeclaredField("id");
                tempField.setAccessible(true);
                tempField.set(tempObject, fieldValue);
                objectValue = tempObject;
            }
        } else {                //
            String fieldValue = request.getParameter(field.getName());
            if (fieldValue != null && !fieldValue.equals("")) {
                if (field.getType().equals(Integer.class)) {
                    objectValue = Integer.parseInt(fieldValue);
                } else if (field.getType().equals(Date.class)) {
                    objectValue = DateUtil.parseAllDate(fieldValue);
                } else if (field.getType().equals(Byte.class)) {
                    objectValue = Byte.parseByte(fieldValue);
                } else if (field.getType().equals(Float.class)) {
                    objectValue = Float.parseFloat(fieldValue);
                } else if (field.getType().equals(BigDecimal.class)) {
                    objectValue = new BigDecimal(fieldValue);
                } else {
                    objectValue = fieldValue;
                }
            }
        }
        return objectValue;
    }


    /**
     * 获得pageEntity对象，该对象代表了列表页面中分页的具体信息，具体查看com.ming800.core.taglib.PageEntity
     * @param request
     * @return
     */
    protected PageEntity getPageEntity(HttpServletRequest request) {
        String index = request.getParameter(PageEntity.PARAM_NAME_PAGEINDEX);
        String size = request.getParameter(PageEntity.PARAM_NAME_PAGERECORDS);
        PageEntity pageEntity = new PageEntity();
        pageEntity.setIndex(1);
        pageEntity.setSize(12);
        if (index != null && !index.equals("")) {
            pageEntity.setIndex(Integer.parseInt(index));
        }
        if (size != null && !size.equals("")) {
            pageEntity.setSize(Integer.parseInt(size));
        }
        return pageEntity;
    }

/*    protected String getVersionName() {
        return versionManager.fetchVersion().getName();
    }*/
}
