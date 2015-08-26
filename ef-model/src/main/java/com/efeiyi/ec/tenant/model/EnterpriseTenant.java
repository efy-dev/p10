package com.efeiyi.ec.tenant.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 上午11:06
 * To change this template use File | Settings | File Templates.
 *
 *
 * 企业商家
 */

@Entity
@DiscriminatorValue(value="11")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class EnterpriseTenant extends Tenant implements Serializable {


}
