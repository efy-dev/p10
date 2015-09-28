package com.efeiyi.util;

import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;

@WebService(name="MsgService",targetNamespace = "http://service.webservice.felix.com/")
public interface MsgService {
	@WebResult(name="verify")
	public String chkVerify(
			@WebParam(name = "chk") String chk,
			@WebParam(name = "apoid") int apoid,
			@WebParam(name = "ip") String ip
	);
	
}
