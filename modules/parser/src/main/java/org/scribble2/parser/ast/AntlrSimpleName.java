package org.scribble2.parser.ast;

import org.antlr.runtime.tree.CommonTree;
import org.scribble2.model.ModelFactory;
import org.scribble2.model.ModelFactoryImpl;
import org.scribble2.model.name.simple.AmbiguousNameNode;
import org.scribble2.model.name.simple.OperatorNode;
import org.scribble2.model.name.simple.ParameterNode;
import org.scribble2.model.name.simple.RecursionVarNode;
import org.scribble2.model.name.simple.RoleNode;
import org.scribble2.model.name.simple.ScopeNode;
import org.scribble2.model.name.simple.SimpleMessageSignatureNameNode;
import org.scribble2.model.name.simple.SimplePayloadTypeNode;
import org.scribble2.model.name.simple.SimpleProtocolNameNode;
import org.scribble2.parser.ast.global.AntlrGlobalInterruptible;

public class AntlrSimpleName
{
	protected static String getName(CommonTree ct)
	{
		return ct.getText();
	}
	
	public static SimpleProtocolNameNode toSimpleProtocolNameNode(CommonTree ct)
	{
		//return new SimpleProtocolNameNode(AntlrSimpleName.getName(ct));
		return (SimpleProtocolNameNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.PROTOCOL, AntlrSimpleName.getName(ct));
	}

	public static SimplePayloadTypeNode toSimplePayloadTypeNode(CommonTree ct)
	{
		//return new SimplePayloadTypeNode(AntlrSimpleName.getName(ct));
		//return (SimplePayloadTypeNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.PAYLOADTYPE, AntlrSimpleName.getName(ct));
		throw new RuntimeException("TODO: " + ct);
	}

	public static SimpleMessageSignatureNameNode toSimpleMessageSignatureNameNode(CommonTree ct)
	{
		//return new SimpleMessageSignatureNameNode(AntlrSimpleName.getName(ct));
		//return (SimpleMessageSignatureNameNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.MESSAGESIGNATURE, AntlrSimpleName.getName(ct));
		throw new RuntimeException("TODO: " + ct);
	}

	public static RoleNode toRoleNode(CommonTree ct)
	{
		//return new RoleNode(getName(ct));
		return (RoleNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.ROLE, AntlrSimpleName.getName(ct));
	}

	/*public static ParameterNode toParameterNode(CommonTree ct)
	{
		return toParameterNode(ct, Kind.AMBIGUOUS);
	}*/

	//public static ParameterNode toParameterNode(CommonTree ct, Kind kind)
	public static ParameterNode toParameterNode(CommonTree ct)
	{
		//return new ParameterNode(getName(ct), kind);
		//return new ParameterNode(getName(ct));
		return (ParameterNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.PARAMETER, AntlrSimpleName.getName(ct));
	}
	
	public static AmbiguousNameNode toAmbiguousNameNode(CommonTree ct)
	{
		//return new AmbiguousNameNode(getName(ct));
		return (AmbiguousNameNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.AMBIG, AntlrSimpleName.getName(ct));
	}

	public static OperatorNode toOperatorNode(CommonTree ct)
	{
		String op = getName(ct);
		if (op.equals(AntlrMessageSignature.ANTLR_EMPTY_OPERATOR))
		{
			//return new OperatorNode(OperatorNode.EMPTY_OPERATOR_IDENTIFIER);
			return (OperatorNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.OPERATOR, OperatorNode.EMPTY_OPERATOR_IDENTIFIER);
		}
		//return new OperatorNode(op);
		return (OperatorNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.OPERATOR, AntlrSimpleName.getName(ct));
	}
	
	public static ScopeNode toScopeNode(CommonTree ct)
	{
		String scope = getName(ct);
		if (scope.equals(AntlrGlobalInterruptible.NO_SCOPE))
		{
			return null;
		}
		//return new ScopeNode(scope);
		throw new RuntimeException("TODO: " + ct);
	}
	
	public static RecursionVarNode toRecursionVarNode(CommonTree ct)
	{
		//return new RecursionVarNode(getName(ct));
		return (RecursionVarNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.RECURSIONVAR, AntlrSimpleName.getName(ct));
	}
}
