package com.ming800.core.p.model;

import java.io.Serializable;
import java.util.Properties;

import org.hibernate.HibernateException;
import org.hibernate.MappingException;
import org.hibernate.dialect.Dialect;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.id.*;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-4-3
 * Time: 上午9:16
 * To change this template use File | Settings | File Templates.
 */
public class M8idGenerator implements IdentifierGenerator, Configurable {


    private static String serial;
/*    private static final Log log = LogFactory.getLog(M8idGenerator.class);

    private long next;

    private String sql;
    private String table;
    private String column;
    private String schema;*/


    public Serializable generate(SessionImplementor session,
                                 Object object) throws HibernateException {


        // String branchId = getMyBranchSerial();
        //if (branchId == null) {
        //branchId = AuthorizationUtil.getMyBranch().getName().substring(0, 2);
        //}
        //branchId = Integer.toString(Integer.parseInt(branchId), 36);

        String dateId = Long.toString(System.currentTimeMillis(), 36);


        Double numIds = Math.random();
        String numIds2 = numIds.toString();
        numIds2 = numIds2.substring(numIds2.indexOf(".")+1,numIds2.length()-1);
        if (numIds2.length()<=17){
            numIds2 = fillWithZero(numIds2,17);
        }
        String numIds3 = numIds2.substring(1, 15);
        String numId = Long.toString(Long.parseLong(numIds3), 36);

        StringBuilder stringBuilder = new StringBuilder(16);

        stringBuilder
                //.append(fillWithZero(branchId, 4))
                .append(fillWithZero(dateId, 8))
                .append(fillWithZero(numId, 8));

        return stringBuilder.toString();

    }

    public void configure(org.hibernate.type.Type type, Properties params,
                          Dialect d) throws MappingException {

/*        table = params.getProperty("table");
        if (table == null)
            table = params.getProperty(PersistentIdentifierGenerator.TABLE);
        column = params.getProperty("column");
        if (column == null)
            column = params.getProperty(PersistentIdentifierGenerator.PK);
        schema = params.getProperty(PersistentIdentifierGenerator.SCHEMA);*/

    }

    private String fillWithZero(String str, Integer length) {

        StringBuilder stringBuilder = new StringBuilder(length);

        stringBuilder.append(str);
        if (str.length() > length) {
            stringBuilder.deleteCharAt(length);
        } else if (str.length() < length) {
            int tempLength = length - str.length();
            for (int i = 0; i < tempLength; i++) {
                stringBuilder.insert(0, "0");
            }
        }

        return stringBuilder.toString();
    }


    public static String getSerial() {
        return serial;
    }

    public static void setSerial(String serial) {
        M8idGenerator.serial = serial;
    }

}
