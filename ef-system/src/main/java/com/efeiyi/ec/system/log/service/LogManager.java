package com.efeiyi.ec.system.log.service;

import java.text.ParseException;

public interface LogManager {
    void saveLog(String targetName,String operation) throws ParseException;
}
