package org.scribble2.model.visit;

import java.util.Map;

import org.scribble2.model.ArgumentNode;
import org.scribble2.model.MessageSigNode;
import org.scribble2.model.ModelFactoryImpl;
import org.scribble2.model.ModelNode;
import org.scribble2.model.name.qualified.MessageSigNameNode;
import org.scribble2.model.name.simple.ParamNode;
import org.scribble2.model.name.simple.RoleNode;
import org.scribble2.sesstype.Argument;
import org.scribble2.sesstype.kind.Kind;
import org.scribble2.sesstype.kind.SigKind;
import org.scribble2.sesstype.name.Role;
import org.scribble2.util.ScribbleException;

public class Substitutor extends ModelVisitor
{
	private final Map<Role, RoleNode> rolemap;
	//private final Map<Argument, ArgumentNode> argmap;
	private final Map<Argument<? extends Kind>, ArgumentNode> argmap;

	public Substitutor(Job job, Map<Role, RoleNode> rolemap, Map<Argument<? extends Kind>, ArgumentNode> argmap)
	{
		super(job);
		this.rolemap = rolemap;
		this.argmap = argmap;
	}
	
	@Override
	//public ModelNode leave(ModelNode parent, ModelNode child, ModelVisitor nv, ModelNode visited) throws ScribbleException
	public ModelNode leave(ModelNode parent, ModelNode child, ModelNode visited) throws ScribbleException
	{
		//return visited.substituteNames((Substitutor) nv);
		return visited.substituteNames(this);
		//return visited.del().substituteNames((Substitutor) nv, visited);
	}

	public Role getRoleSubstitution(Role role)
	{
		return this.rolemap.get(role).toName();
	}

	/*public RoleNode getRoleSubstitution(Role role)
	{
		RoleNode rn = this.rolemap.get(role);
		return new RoleNode(rn.toName().toString());
	}*/

	//public ArgumentNode getArgumentSubstitution(Argument arg)
	public <K extends Kind> ArgumentNode getArgumentSubstitution(Argument<K> arg)
	{
		ArgumentNode an = (ArgumentNode) this.argmap.get(arg);
		if (an.isMessageSigNode())
		{
			MessageSigNode msn = (MessageSigNode) an;
			//return new MessageSigNode(msn.op, msn.payload);  // FIXME: use factory
			return (ArgumentNode) ModelFactoryImpl.FACTORY.MessageSignatureNode(msn.op, msn.payload);
		}
		else if (an.isMessageSigNameNode())
		{
			MessageSigNameNode msn = (MessageSigNameNode) an;
			return (MessageSigNameNode) ModelFactoryImpl.FACTORY.QualifiedNameNode(SigKind.KIND, msn.getElements());
		}
		/*else if (an.isPayloadTypeNode())
		{
			PayloadTypeNameNodes ptn = (PayloadTypeNameNodes) an;
			return new PayloadTypeNameNodes(ptn.getElements());
		}*/
		else if (an.isParameterNode())
		{
			//return Substitutor.copyParameterNode((ParameterNode<K>) an);
			ParamNode<K> pn = (ParamNode<K>) an;
			return ModelFactoryImpl.FACTORY.ParamNode(pn.kind, pn.identifier);
		}
		else
		{
			throw new RuntimeException("TODO: " + arg);
		}
	}

	/*private static <K extends Kind> ParameterNode<K> copyParameterNode(ParameterNode<K> an)
	{
		ParameterNode<K> pn = an;
		//return new ParameterNode(null, pn.toName().toString());//, pn.kind);
		//return (ParameterNode) ModelFactoryImpl.FACTORY.SimpleNameNode(ModelFactory.SIMPLE_NAME.PARAMETER, pn.identifier);
		return ModelFactoryImpl.FACTORY.ParameterNode(pn.kind, pn.identifier);
	}*/
}
