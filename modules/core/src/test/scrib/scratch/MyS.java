package scratch;

import java.io.IOException;

import org.scribble.main.ScribbleRuntimeException;
import org.scribble.net.Buf;
import org.scribble.net.ObjectStreamFormatter;
import org.scribble.net.scribsock.ScribServerSocket;
import org.scribble.net.scribsock.SocketChannelServer;
import org.scribble.net.session.SessionEndpoint;

import scratch.Scratch1.Proto1.Proto1;
import scratch.Scratch1.Proto1.channels.S.EndSocket;
import scratch.Scratch1.Proto1.channels.S.Proto1_S_1;
import scratch.Scratch1.Proto1.channels.S.Proto1_S_2_Handler;
import scratch.Scratch1.Proto1.channels.S.Proto1_S_3;
import scratch.Scratch1.Proto1.channels.S.ioifaces.Branch_S_C_2_Int__C_4;
import scratch.Scratch1.Proto1.channels.S.ioifaces.Handle_S_C_2_Int__C_4;
import scratch.Scratch1.Proto1.channels.S.ioifaces.Receive_S_C_1;
import scratch.Scratch1.Proto1.channels.S.ioifaces.Select_S_C_3_Int;
import scratch.Scratch1.Proto1.channels.S.ioifaces.Succ_In_C_2_Int;
import scratch.Scratch1.Proto1.channels.S.ioifaces.Succ_In_C_4;
import scratch.Scratch1.Proto1.ops._2;
import scratch.Scratch1.Proto1.ops._4;
import scratch.Scratch1.Proto1.roles.S;

public class MyS
{
	public static void main(String[] args) throws IOException, ScribbleRuntimeException
	{
		try (ScribServerSocket ss = new SocketChannelServer(8888))
		{
			//Buf<Integer> i1 = new Buf<>();
			//Buf<Integer> i2 = new Buf<>();

			while (true)
			{
				Proto1 foo = new Proto1();
				//SessionEndpoint<S> se = foo.project(Proto1.S, new ObjectStreamFormatter(), ss);
				try (SessionEndpoint<Proto1, S> se = new SessionEndpoint<>(foo, Proto1.S, new ObjectStreamFormatter()))
				{
					se.accept(ss, Proto1.C);

					new Proto1_S_1(se).async(Proto1.C, Proto1._1)
						.branch(Proto1.C, new Handler());
						//.handle(Proto1.C, new Handler2());
						//.branch(Proto1.C, new Handler3<Proto1_S_3, EndSocket>());
				}
				catch (Exception e)//ScribbleRuntimeException | IOException | ExecutionException | InterruptedException | ClassNotFoundException e)
				{
					e.printStackTrace();
				}
			}
		}
	}
}

class Handler implements
	//Proto1_S_2_Handler
	Proto1_S_2_Handler
{
	@Override
	public void receive(EndSocket schan, _4 op) throws ScribbleRuntimeException, IOException
	{
		System.out.println("Done");
		schan.end();
	}

	@Override
	public void receive(Proto1_S_3 schan, _2 op, Buf<? super Integer> b) throws ScribbleRuntimeException, IOException
	{
		System.out.println("Redo: " + b.val);
		try
		{
			schan.send(Proto1.C, Proto1._3, 456).async(Proto1.C, Proto1._1)
				.branch(Proto1.C, this);
				//.handle(Proto1.C, this);  // "this" handler is not generic enough
		}
		catch (ClassNotFoundException e)
		{
			throw new IOException(e);
		}
	}
}

//class Handler2<Succ extends Succ_In_C_2_Int> implements Handle_S_C_2_Int__C_4<Succ>
class Handler2 implements Handle_S_C_2_Int__C_4<Succ_In_C_2_Int, Succ_In_C_4>
{
	@Override
	//public void receive(Proto1_S_3 schan, _2 op, Buf<? super Integer> b) throws ScribbleRuntimeException, IOException, ClassNotFoundException
	//public void receive(Select_S_C_3_Int<Succ> schan, _2 op, Buf<? super Integer> b) throws ScribbleRuntimeException, IOException, ClassNotFoundException
	public void receive(Succ_In_C_2_Int schan, _2 op, Buf<? super Integer> b) throws ScribbleRuntimeException, IOException, ClassNotFoundException
	{
		System.out.println("Redo: " + b.val);
		schan.to(Select_S_C_3_Int.cast).send(Proto1.C, Proto1._3, 356).to(Receive_S_C_1.cast).async(Proto1.C, Proto1._1).to(Branch_S_C_2_Int__C_4.cast).handle(Proto1.C, this);
	}

	@Override
	public void receive(Succ_In_C_4 schan, _4 op) throws ScribbleRuntimeException, IOException
	{
		System.out.println("Done");
	}
}

class Handler3<Succ1 extends Succ_In_C_2_Int, Succ2 extends Succ_In_C_4> implements Handle_S_C_2_Int__C_4<Succ1, Succ2>
{
	@Override
	public void receive(Succ1 schan, _2 op, Buf<? super Integer> b) throws ScribbleRuntimeException, IOException, ClassNotFoundException
	{
		System.out.println("Redo: " + b.val);
		((Branch_S_C_2_Int__C_4<Succ1, Succ2>) schan.to(Select_S_C_3_Int.cast).send(Proto1.C, Proto1._3, 356).to(Receive_S_C_1.cast).async(Proto1.C, Proto1._1)).branch(Proto1.C, this);
		//schan.to(Select_S_C_3_Int.cast).send(Proto1.C, Proto1._3, 356).to(Receive_S_C_1.cast).async(Proto1.C, Proto1._1).to(Branch_S_C_2_Int__C_4.cast).branch(Proto1.C, this);
	}

	@Override
	public void receive(Succ2 schan, _4 op) throws ScribbleRuntimeException, IOException
	{
		System.out.println("Done");
	}
}
