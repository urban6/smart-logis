package kr.co.shovvel.dm.xmlParser;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
 // D:\\xml_sample\\GetBein_Dgm_Detail.xml
public class XmlParser {
 
	public static void main(String[] args) {

        try {
            // DOM Document 객체를 생성하는 단계
            DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
            DocumentBuilder parser = f.newDocumentBuilder();

            // XML 파일 파싱하는 단계
            Document xmlDoc = null;
            String url = "D:\\xml_sample\\GetBein_Dgm_Detail.xml";
            xmlDoc = parser.parse(url);
            
            // 루트 엘리먼트 접근
            Element root = xmlDoc.getDocumentElement();
            
            // 반복문 지정
            int length = root.getElementsByTagName("Table").getLength();
            for(int i=0; i<length; i++) {
                Node bNode = root.getElementsByTagName("Table").item(i);
                
                String kind = ((Element)bNode).getAttribute("diffgr:id");
                System.out.println(kind);
                
                Node tNode = ((Element)bNode).getElementsByTagName("RMNO").item(0);
                System.out.println(((Element)tNode).getTagName() + " : " + tNode.getTextContent());
                Node aNode = ((Element)bNode).getElementsByTagName("EXRM_NO").item(0);
                System.out.println(((Element)aNode).getTagName() + " : " + aNode.getTextContent());
                Node pNode = ((Element)bNode).getElementsByTagName("END_TM").item(0);
                //System.out.println(((Element)pNode).getTagName() + " : " + pNode.getTextContent());
            }
            
//            NodeList domList = xmlDoc.getDocumentElement().getChildNodes();
//            for(int i=0; i<domList.getLength(); i++) {
//                Node node = domList.item(i);
//                System.out.println(node.getNodeName());
//                System.out.println(node.getTextContent());
//            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            System.out.println(e.toString());
        }
    }
 
}