package com.efeiyi.association.util;

import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.DocumentAttachment;
import org.htmlparser.Node;
import org.htmlparser.NodeFilter;
import org.htmlparser.Parser;
import org.htmlparser.filters.TagNameFilter;
import org.htmlparser.tags.ImageTag;
import org.htmlparser.util.NodeList;

import java.util.ArrayList;

/**
 * Created by Administrator on 2015/10/13.
 */
public class SavePicsOfDocUtil {
    /**
     * 滤出正文中的图片地址，保存到与document关联的DocumentAttachment中
     * @param document
     * @throws Exception
     */
    public static void savePicsOfDoc(Document document) throws Exception{
        if (document.getDocumentContent().getContent() != null) {
            Parser parser = new Parser(document.getDocumentContent().getContent());
            NodeFilter filter = new TagNameFilter("img");
            NodeList nodes = parser.extractAllNodesThatMatch(filter);

            if (nodes != null) {
                Node eachNode = null;
                ImageTag imageTag = null;
                String srcPath = null;
                DocumentAttachment documentAttachment = null;
                document.setDocumentAttachmentList(new ArrayList<DocumentAttachment>());

                //遍历所有的img节点
                for (int i = 0; i < nodes.size(); i++) {
                    eachNode = (Node) nodes.elementAt(i);
                    if (eachNode instanceof ImageTag) {
                        imageTag = (ImageTag) eachNode;

                        //获得html文本的原来的src属性
                        srcPath = imageTag.getAttribute("src");
                        documentAttachment = new DocumentAttachment();
                        documentAttachment.setPath(srcPath);
                        documentAttachment.setDocument(document);
                        document.getDocumentAttachmentList().add(documentAttachment);
                    }
                }
            }
        }
    }
}
