package com.ming800.core.base.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Collection;

/**
 * Created by Administrator on 2015/7/16.
 */
public interface BaseUser{


    String getId();

    BaseTenant getBigTenant();


}