package org.scribble2.model.del;

import org.scribble2.model.ModelNode;
import org.scribble2.model.visit.NameDisambiguator;
import org.scribble2.util.ScribbleException;

public class ProtocolDeclDelegate extends ModelDelegateBase
{
	@Override
	public NameDisambiguator enterDisambiguation(ModelNode n, NameDisambiguator disamb) throws ScribbleException
	{
		// Could do in protocolheader enter/leave
		disamb.reset();
		return disamb;
	}
}
