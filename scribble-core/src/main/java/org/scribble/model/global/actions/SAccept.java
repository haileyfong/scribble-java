/**
 * Copyright 2008 The Scribble Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
package org.scribble.model.global.actions;

import org.scribble.type.Payload;
import org.scribble.type.name.MessageId;
import org.scribble.type.name.Role;

public class SAccept extends SAction
{
	public SAccept(Role subj, Role obj, MessageId<?> mid, Payload payload)
	//public GAccept(Role subj, Role obj)
	{
		super(subj, obj, mid, payload);
		//super(subj, obj, Op.EMPTY_OPERATOR, Payload.EMPTY_PAYLOAD);
	}
	
	@Override
	public boolean isAccept()
	{
		return true;
	}

	@Override
	public int hashCode()
	{
		int hash = 967;
		hash = 31 * hash + super.hashCode();
		return hash;
	}

	@Override
	public boolean equals(Object o)
	{
		if (this == o)
		{
			return true;
		}
		if (!(o instanceof SAccept))
		{
			return false;
		}
		return ((SAccept) o).canEqual(this) && super.equals(o);
	}

	public boolean canEqual(Object o)
	{
		return o instanceof SAccept;
	}

	@Override
	protected String getCommSymbol()
	{
		//return "??";
		return "<<-";
	}
}
