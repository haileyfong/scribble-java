package org.scribble2.parser.ast;

import org.antlr.runtime.tree.CommonTree;
import org.scribble2.model.ModelFactory;
import org.scribble2.model.ModelFactoryImpl;
import org.scribble2.model.name.qualified.MessageSignatureNameNode;
import org.scribble2.model.name.qualified.ModuleNameNode;
import org.scribble2.model.name.qualified.PayloadTypeNameNode;
import org.scribble2.model.name.qualified.ProtocolNameNode;

public class AntlrQualifiedName
{
	protected static String[] getElements(CommonTree ct)
	{
		int count = ct.getChildCount();
		String[] names = new String[count];
		for (int i = 0; i < count; i++)
		{
			names[i] = AntlrSimpleName.getName((CommonTree) ct.getChild(i));
		}
		return names;
	}
	
	public static ModuleNameNode toModuleNameNodes(CommonTree ct)
	{
		//return new ModuleNameNode(getElements(ct));
		return (ModuleNameNode) ModelFactoryImpl.FACTORY.QualifiedNameNode(ModelFactory.QUALIFIED_NAME.MODULE, getElements(ct));
	}

	public static PayloadTypeNameNode toPayloadTypeNameNodes(CommonTree ct)
	{
		//return new PayloadTypeNameNode(getElements(ct));
		return (PayloadTypeNameNode) ModelFactoryImpl.FACTORY.QualifiedNameNode(ModelFactory.QUALIFIED_NAME.PAYLOADTYPE, getElements(ct));
	}

	public static MessageSignatureNameNode toMessageSignatureNameNodes(CommonTree ct)
	{
		//return new MessageSignatureNameNode(getElements(ct));
		return (MessageSignatureNameNode) ModelFactoryImpl.FACTORY.QualifiedNameNode(ModelFactory.QUALIFIED_NAME.MESSAGESIGNATURE, getElements(ct));
	}

	public static ProtocolNameNode toProtocolNameNodes(CommonTree ct)
	{
		return new ProtocolNameNode(getElements(ct));
	}
}
