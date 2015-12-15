package com.efeiyi.ec.system.professional.service;

import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.Subject;
import com.efeiyi.ec.system.product.model.ProductModelBean;

/**
 * Created by Administrator on 2015/8/17.
 */
public interface ProfessionalManager {
   String saveProfessional(Professional professional) throws Exception;
    boolean checkUsername(String username);
}
