package org.scribble.sesstype.name;

import org.scribble.sesstype.kind.Local;


public class LProtocolName extends ProtocolName<Local>
{
	private static final long serialVersionUID = 1L;

	public LProtocolName(ModuleName modname, ProtocolName<Local> membname)
	{
		super(Local.KIND, modname, membname);
	}
	
	public LProtocolName(String membname)
	{
		super(Local.KIND, membname);
	}

	@Override
	public LProtocolName getSimpleName()
	{
		return new LProtocolName(getLastElement());
	}
	
	@Override
	public boolean equals(Object o)
	{
		if (this == o)
		{
			return true;
		}
		if (!(o instanceof LProtocolName))
		{
			return false;
		}
		LProtocolName n = (LProtocolName) o;
		return n.canEqual(this) && super.equals(o);
	}
	
	public boolean canEqual(Object o)
	{
		return o instanceof LProtocolName;
	}

	@Override
	public int hashCode()
	{
		int hash = 2789;
		hash = 31 * super.hashCode();
		return hash;
	}
}
