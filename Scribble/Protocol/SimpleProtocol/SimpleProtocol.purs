module Scribble.Protocol.SimpleProtocol.SimpleProtocol where

import Scribble.FSM
import Prim.TypeError (class Fail, Text, Above, Quote, Beside)
import Data.Void (Void)
import Data.Tuple (Tuple)
import Prelude

-- From purescript-argonaut-codecs
import Data.Argonaut.Decode (class DecodeJson)
import Data.Argonaut.Encode (class EncodeJson)
import Data.Argonaut.Core (Json) -- From purescript-argonaut-core
import Data.Generic.Rep (class Generic) -- From purescript-generics-rep
-- From purescript-argonaut-generic
import Data.Argonaut.Decode.Generic.Rep (genericDecodeJsonWith)
import Data.Argonaut.Encode.Generic.Rep (genericEncodeJsonWith)
import Data.Argonaut.Types.Generic.Rep (Encoding)


jsonEncoding :: Encoding
jsonEncoding =
  { tagKey: "tag"
  , valuesKey: "values"
  , unwrapSingleArguments: true
  }

data Response = Response String
instance showResponse :: Show Response where
  show response = "Response"
derive instance genericResponse :: Generic Response _
instance encodeJsonResponse :: EncodeJson Response where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonResponse :: DecodeJson Response where
  decodeJson = genericDecodeJsonWith jsonEncoding
data Message = Message String
instance showMessage :: Show Message where
  show message = "Message"
derive instance genericMessage :: Generic Message _
instance encodeJsonMessage :: EncodeJson Message where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonMessage :: DecodeJson Message where
  decodeJson = genericDecodeJsonWith jsonEncoding
data Connect = Connect
instance showConnect :: Show Connect where
  show connect = "Connect"
derive instance genericConnect :: Generic Connect _
instance encodeJsonConnect :: EncodeJson Connect where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonConnect :: DecodeJson Connect where
  decodeJson = genericDecodeJsonWith jsonEncoding

foreign import data SimpleProtocol :: Protocol

class AnyMessageType (t :: Type)
instance showType :: Show t => AnyMessageType t
else instance responseType :: AnyMessageType Response
else instance messageType :: AnyMessageType Message
else instance connectType :: AnyMessageType Connect

foreign import data Client :: Role

instance roleNameClient :: RoleName Client "Client"

foreign import data S8 :: Type
foreign import data S8Connected :: Type
foreign import data S10 :: Type
foreign import data S11 :: Type
foreign import data S12 :: Type
foreign import data S9 :: Type

instance initialClient :: Initial Client S8
instance terminalClient :: Terminal Client S9
instance sendAfterterminalClientFail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Terminal"))) => Send Client S9 S9 b       -- Error Handling Instance
instance receiveAfterterminalClientFail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Terminal"))) => Receive Client S9 S9 b       -- Error Handling Instance
instance connectAfterterminalClientFail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Terminal"))) => Connect Client Client S9 S9       -- Error Handling Instance
instance disconnectAfterterminalClientFail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Terminal"))) => Disconnect Client Client S9 S9       -- Error Handling Instance
instance selectAfterterminalClientFail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Terminal"))) => Select Client S9 ()       -- Error Handling Instance
instance branchAfterterminalClientFail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Terminal"))) => Branch Client Client S9 ()       -- Error Handling Instance
instance connectS8 :: Connect Client Server S8 S8Connected
instance sendAfterconnectS8Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Connect"))) => Send Client S8 S8 b       -- Error Handling Instance
instance receiveAfterconnectS8Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Connect"))) => Receive Client S8 S8 b       -- Error Handling Instance
instance disconnectAfterconnectS8Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Connect"))) => Disconnect Client Client S8 S8       -- Error Handling Instance
instance selectAfterconnectS8Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Connect"))) => Select Client S8 ()       -- Error Handling Instance
instance branchAfterconnectS8Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Connect"))) => Branch Client Client S8 ()       -- Error Handling Instance
instance sendS8 :: Send Server S8Connected S10 Connect
instance receiveAftersendS8Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Send message of type Connect"))) => Receive Server S8Connected S8Connected b       -- Error Handling Instance
instance connectAftersendS8Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Send message of type Connect"))) => Connect Client Server S8Connected S8Connected       -- Error Handling Instance
instance disconnectAftersendS8Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Send message of type Connect"))) => Disconnect Client Server S8Connected S8Connected       -- Error Handling Instance
instance selectAftersendS8Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Send message of type Connect"))) => Select Server S8Connected ()       -- Error Handling Instance
instance branchAftersendS8Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Send message of type Connect"))) => Branch Client Server S8Connected ()       -- Error Handling Instance
instance sendS10 :: Send Server S10 S11 Message
instance receiveAftersendS10Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Send message of type Message"))) => Receive Server S10 S10 b       -- Error Handling Instance
instance connectAftersendS10Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Send message of type Message"))) => Connect Client Server S10 S10       -- Error Handling Instance
instance disconnectAftersendS10Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Send message of type Message"))) => Disconnect Client Server S10 S10       -- Error Handling Instance
instance selectAftersendS10Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Send message of type Message"))) => Select Server S10 ()       -- Error Handling Instance
instance branchAftersendS10Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Send message of type Message"))) => Branch Client Server S10 ()       -- Error Handling Instance
instance receiveS11 :: Receive Server S11 S12 Response
instance sendAfterreceiveS11Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Receive message of type Response"))) => Send Server S11 S11 b       -- Error Handling Instance
instance connectAfterreceiveS11Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Receive message of type Response"))) => Connect Client Server S11 S11       -- Error Handling Instance
instance disconnectAfterreceiveS11Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Receive message of type Response"))) => Disconnect Client Server S11 S11       -- Error Handling Instance
instance selectAfterreceiveS11Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Receive message of type Response"))) => Select Server S11 ()       -- Error Handling Instance
instance branchAfterreceiveS11Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Receive message of type Response"))) => Branch Client Server S11 ()       -- Error Handling Instance
instance disconnectS12 :: Disconnect Client Server S12 S9
instance sendAfterdisconnectS12Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Disconnect"))) => Send Client S12 S12 b       -- Error Handling Instance
instance receiveAfterdisconnectS12Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Disconnect"))) => Receive Client S12 S12 b       -- Error Handling Instance
instance connectAfterdisconnectS12Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Disconnect"))) => Connect Client Client S12 S12       -- Error Handling Instance
instance selectAfterdisconnectS12Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Disconnect"))) => Select Client S12 ()       -- Error Handling Instance
instance branchAfterdisconnectS12Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Disconnect"))) => Branch Client Client S12 ()       -- Error Handling Instance

foreign import data Server :: Role

instance roleNameServer :: RoleName Server "Server"

foreign import data S19 :: Type
foreign import data S21 :: Type
foreign import data S22 :: Type
foreign import data S23 :: Type
foreign import data S20 :: Type

instance initialServer :: Initial Server S19
instance terminalServer :: Terminal Server S20
instance sendAfterterminalServerFail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Terminal"))) => Send Server S20 S20 b       -- Error Handling Instance
instance receiveAfterterminalServerFail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Terminal"))) => Receive Server S20 S20 b       -- Error Handling Instance
instance connectAfterterminalServerFail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Terminal"))) => Connect Server Server S20 S20       -- Error Handling Instance
instance disconnectAfterterminalServerFail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Terminal"))) => Disconnect Server Server S20 S20       -- Error Handling Instance
instance selectAfterterminalServerFail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Terminal"))) => Select Server S20 ()       -- Error Handling Instance
instance branchAfterterminalServerFail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Terminal"))) => Branch Server Server S20 ()       -- Error Handling Instance
instance acceptS19 :: Accept Server Client S19 S21
instance sendAfteracceptS19Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Accept"))) => Send Server S19 S19 b       -- Error Handling Instance
instance receiveAfteracceptS19Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Accept"))) => Receive Server S19 S19 b       -- Error Handling Instance
instance connectAfteracceptS19Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Accept"))) => Connect Server Server S19 S19       -- Error Handling Instance
instance disconnectAfteracceptS19Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Accept"))) => Disconnect Server Server S19 S19       -- Error Handling Instance
instance selectAfteracceptS19Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Accept"))) => Select Server S19 ()       -- Error Handling Instance
instance branchAfteracceptS19Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Accept"))) => Branch Server Server S19 ()       -- Error Handling Instance
instance receiveS21 :: Receive Client S21 S22 Message
instance sendAfterreceiveS21Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Receive message of type Message"))) => Send Client S21 S21 b       -- Error Handling Instance
instance connectAfterreceiveS21Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Receive message of type Message"))) => Connect Server Client S21 S21       -- Error Handling Instance
instance disconnectAfterreceiveS21Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Receive message of type Message"))) => Disconnect Server Client S21 S21       -- Error Handling Instance
instance selectAfterreceiveS21Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Receive message of type Message"))) => Select Client S21 ()       -- Error Handling Instance
instance branchAfterreceiveS21Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Receive message of type Message"))) => Branch Server Client S21 ()       -- Error Handling Instance
instance sendS22 :: Send Client S22 S23 Response
instance receiveAftersendS22Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Send message of type Response"))) => Receive Client S22 S22 b       -- Error Handling Instance
instance connectAftersendS22Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Send message of type Response"))) => Connect Server Client S22 S22       -- Error Handling Instance
instance disconnectAftersendS22Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Send message of type Response"))) => Disconnect Server Client S22 S22       -- Error Handling Instance
instance selectAftersendS22Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Send message of type Response"))) => Select Client S22 ()       -- Error Handling Instance
instance branchAftersendS22Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Send message of type Response"))) => Branch Server Client S22 ()       -- Error Handling Instance
instance disconnectS23 :: Disconnect Server Client S23 S20
instance sendAfterdisconnectS23Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Disconnect"))) => Send Server S23 S23 b       -- Error Handling Instance
instance receiveAfterdisconnectS23Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Disconnect"))) => Receive Server S23 S23 b       -- Error Handling Instance
instance connectAfterdisconnectS23Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Disconnect"))) => Connect Server Server S23 S23       -- Error Handling Instance
instance selectAfterdisconnectS23Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Disconnect"))) => Select Server S23 ()       -- Error Handling Instance
instance branchAfterdisconnectS23Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Disconnect"))) => Branch Server Server S23 ()       -- Error Handling Instance

