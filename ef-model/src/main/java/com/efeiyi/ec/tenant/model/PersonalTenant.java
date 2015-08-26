package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.organization.model.BigUser;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 上午11:06
 * To change this template use File | Settings | File Templates.
 *
 *
 * 个人
 */
@Entity
@Table(name = "tenant_personal")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class PersonalTenant extends Tenant implements Serializable {


}
