package demo.http.message.server;

import demo.http.Http;
import demo.http.message.HeaderField;

public class LastModified extends HeaderField
{
	private static final long serialVersionUID = 1L;

	public LastModified(String date)
	{
		super(Http.LASTM, date);
	}
}
