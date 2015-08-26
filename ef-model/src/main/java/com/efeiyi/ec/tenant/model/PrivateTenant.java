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
 * 个体
 */
//
@Entity
@Table(name = "tenant_private")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class PrivateTenant extends Tenant implements Serializable {



}
