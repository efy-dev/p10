package com.ming800.core.does.model;

import java.lang.annotation.*;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-12-21
 * Time: 上午10:05
 * To change this template use File | Settings | File Templates.
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
public @interface FieldValue {

    String value();

    String type() default "save";
}
