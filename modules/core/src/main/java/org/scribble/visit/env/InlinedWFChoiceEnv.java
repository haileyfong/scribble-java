package org.scribble.visit.env;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

import org.scribble.sesstype.Message;
import org.scribble.sesstype.MessageSig;
import org.scribble.sesstype.Payload;
import org.scribble.sesstype.name.MessageId;
import org.scribble.sesstype.name.Op;
import org.scribble.sesstype.name.Role;
import org.scribble.util.MessageIdMap;
import org.scribble.visit.InlinedProtocolVisitor;

public class InlinedWFChoiceEnv extends Env
{
	private static final Role DUMMY_ROLE = new Role("__ROLE");
	private static final Op ROOT_OPERATOR = new Op("__ROOT");
	private static final Op SUBJECT_OPERATOR = new Op("__SUBJECT");

	private static final MessageSig ROOT_MESSAGESIGNATURE = new MessageSig(ROOT_OPERATOR, Payload.EMPTY_PAYLOAD);
	private static final MessageSig SUBJECT_MESSAGESIGNATURE = new MessageSig(SUBJECT_OPERATOR, Payload.EMPTY_PAYLOAD);
	
	// dest -> src -> msg
	private MessageIdMap initial;  // message transfers recorded here in block envs
	private MessageIdMap initialInterrupts;  //  interrupts recorded here in interruptible env
	
	public InlinedWFChoiceEnv()
	{
		this(new MessageIdMap(), new MessageIdMap());
	}
	
	protected InlinedWFChoiceEnv(MessageIdMap initial, MessageIdMap initialInterrupts)
	{
		this.initial = new MessageIdMap(initial);
		this.initialInterrupts = new MessageIdMap(initialInterrupts);
	}

	@Override
	protected InlinedWFChoiceEnv copy()
	{
		return new InlinedWFChoiceEnv(this.initial, this.initialInterrupts);
	}
	
	public InlinedWFChoiceEnv clear()
	{
		InlinedWFChoiceEnv copy = copy();
		copy.initial.clear();
		copy.initialInterrupts.clear();
		return copy;
	}

	@Override
	public InlinedWFChoiceEnv enterContext()
	{
		return new InlinedWFChoiceEnv(this.initial, this.initialInterrupts);
	}
	
	@Override
	public InlinedWFChoiceEnv mergeContext(Env child)
	{
		return mergeContexts(Arrays.asList(child));
	}

	@Override
	public InlinedWFChoiceEnv mergeContexts(List<? extends Env> children)
	{
		InlinedWFChoiceEnv copy = copy();
		for (InlinedWFChoiceEnv child : castList(children))
		{
			merge(this, copy.initial, child.initial);
			merge(this, copy.initialInterrupts, child.initialInterrupts);
		}
		return copy;
	}

	private static void merge(InlinedWFChoiceEnv parent, MessageIdMap foo, MessageIdMap child)
	{
		for (Role dest : child.getLeftKeys())
		{
			for (Role src : child.getRightKeys(dest))
			{
				if (!parent.isEnabled(dest))
				{
					foo.putMessages(dest, src, child.getMessages(dest, src));
				}
			}
		}
	}
	
	public InlinedWFChoiceEnv enableRoleForRootProtocolDecl(Role role)
	{
		return addMessage(InlinedWFChoiceEnv.DUMMY_ROLE, role, InlinedWFChoiceEnv.ROOT_MESSAGESIGNATURE);
	}

	public InlinedWFChoiceEnv enableChoiceSubject(Role role)
	{
		return addMessage(InlinedWFChoiceEnv.DUMMY_ROLE, role, InlinedWFChoiceEnv.SUBJECT_MESSAGESIGNATURE);
	}

	// The "main" public routine
	// FIXME: subprotocol aspect not needed now
	public InlinedWFChoiceEnv addMessageForSubprotocol(InlinedProtocolVisitor<InlinedWFChoiceEnv> spv, Role src, Role dest, Message msg)
	{
		InlinedWFChoiceEnv copy = copy();
		addMessages(copy.initial, src, dest, Arrays.asList(msg.getId()));
		return copy;
	}

	// Rename: more like enable-if-not-already
	private InlinedWFChoiceEnv addMessage(Role src, Role dest, Message msg)
	{
		InlinedWFChoiceEnv copy = copy();
		addMessages(copy.initial, src, dest, Arrays.asList(msg.getId()));
		return copy;
	}

	// FIXME: List/Set argument
	// Means: record message as initial enabling message if dest not already enabled
	private static void addMessages(MessageIdMap map, Role src, Role dest, List<MessageId<?>> msgs)
	{
		if (!map.containsLeftKey(dest))  // FIXME: factor out isEnabled
		{
			map.putMessages(dest, src, new HashSet<>(msgs));
		}
	}

	public InlinedWFChoiceEnv addInterrupt(Role src, Role dest, Message msg)
	{
		InlinedWFChoiceEnv copy = copy();
		if (!copy.initial.containsLeftKey(dest))
		{
			copy.initialInterrupts.putMessage(dest, src, msg.getId());
		}
		return copy;
	}
	
	public boolean isEnabled(Role role)
	{
		return this.initial.containsLeftKey(role);
	}

	public MessageIdMap getEnabled()
	{
		MessageIdMap tmp = new MessageIdMap(this.initial);
		tmp.merge(this.initialInterrupts);
		return tmp;
	}
	
	// FIXME: move to basic name checking pass (not WF choice)
	public boolean isRoleBound(Role role)
	{
		return this.initial.containsLeftKey(role);  // FIXME: this.initial only contains enabled, not declared
	}

	@Override
	public String toString()
	{
		return "initial=" + this.initial.toString() + ", initialInterrupts=" + this.initialInterrupts.toString();
	}
	
	private static List<InlinedWFChoiceEnv> castList(List<? extends Env> envs)
	{
		return envs.stream().map((e) -> (InlinedWFChoiceEnv) e).collect(Collectors.toList());
	}
}
