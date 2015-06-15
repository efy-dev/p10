package com.ming800.core.does.model;

import java.lang.annotation.*;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-24
 * Time: 下午2:42
 * To change this template use File | Settings | File Templates.
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
public @interface FieldNote {

    public String name();

    public String dname();

    public String input() default "no input";

}
