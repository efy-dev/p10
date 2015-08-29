package com.ming800.core.base.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/7/16.
 */
public interface BaseTenant {

    String getId();

}
