package com.efeiyi.association;


import com.ming800.core.util.JsonUtil;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import javax.xml.namespace.QName;
import javax.xml.soap.*;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.ws.Dispatch;
import javax.xml.ws.Service;
import java.io.IOException;
import java.net.URL;
import java.util.Map;

public class OrganizationConst {

    public static String imgBasePath = "http://xiehui.efeiyi.com/";

    public static void main(String[] args) throws Exception {
        // ==================================================
        SOAPConnectionFactory soapConnFactory = SOAPConnectionFactory
                .newInstance();
        SOAPConnection connection = soapConnFactory.createConnection();

        //  创建消息对象
        // ===========================================
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage message = messageFactory.createMessage();
//          message.setProperty(SOAPMessage.CHARACTER_SET_ENCODING, "gb2312");

        // 创建soap消息主体==========================================
        SOAPPart soapPart = message.getSOAPPart();// 创建soap部分
        SOAPEnvelope envelope = soapPart.getEnvelope();
        SOAPBody body = envelope.getBody();
        //  根据要传给mule的参数，创建消息body内容。具体参数的配置可以参照应用集成接口技术规范1.1版本
        // =====================================
//        SOAPElement bodyElement = body.addChildElement(envelope.createName(
//                "process", "Request", "http://esb.service.com/"));
        body.addChildElement("chk").addTextNode("11111");
        body.addChildElement("apoid").addTextNode("22222");
        // 打印客户端发出的soap报文，做验证测试
        System.out.println(" REQUEST: ");
        message.writeTo(System.out);
        System.out.println(" ");
            /*
             * 实际的消息是使用 call()方法发送的，该方法接收消息本身和目的地作为参数，并返回第二个 SOAPMessage 作为响应。
             * call方法的message对象为发送的soap报文，url为mule配置的inbound端口地址。
             */
        URL url = new URL("http://www.nfc315.com:8080/nfcWebservice/services/msgService?wsdl");
        System.out.println(url);
        // 响应消息
        // ===========================================================================
        SOAPMessage reply = connection.call(message, url);
        //reply.setProperty(SOAPMessage.CHARACTER_SET_ENCODING, "gb2312");
        // 打印服务端返回的soap报文供测试
        System.out.println("RESPONSE:");
        // ==================创建soap消息转换对象
        TransformerFactory transformerFactory = TransformerFactory
                .newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        // Extract the content of the reply======================提取消息内容
        Source sourceContent = reply.getSOAPPart().getContent();
        // Set the output for the transformation
        StreamResult result = new StreamResult(System.out);
        transformer.transform(sourceContent, result);
        // Close the connection 关闭连接 ==============
        System.out.println("");
        connection.close();
            /*
             * 模拟客户端A，异常处理测试
             */
        SOAPBody ycBody = reply.getSOAPBody();
        org.w3c.dom.Node ycResp = ycBody.getFirstChild();
        System.out.print("returnValue:" + ycResp.getTextContent());

    }
}
