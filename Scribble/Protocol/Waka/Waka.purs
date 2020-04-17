module Scribble.Protocol.Waka.Waka where

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

data Add = Add Int Int
instance showAdd :: Show Add where
  show add = "Add"
derive instance genericAdd :: Generic Add _
instance encodeJsonAdd :: EncodeJson Add where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonAdd :: DecodeJson Add where
  decodeJson = genericDecodeJsonWith jsonEncoding
data Connect = Connect
instance showConnect :: Show Connect where
  show connect = "Connect"
derive instance genericConnect :: Generic Connect _
instance encodeJsonConnect :: EncodeJson Connect where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonConnect :: DecodeJson Connect where
  decodeJson = genericDecodeJsonWith jsonEncoding

foreign import data Waka :: Protocol

class AnyMessageType (t :: Type)
instance showType :: Show t => AnyMessageType t
else instance addType :: AnyMessageType Add
else instance connectType :: AnyMessageType Connect

foreign import data Client :: Role

instance roleNameClient :: RoleName Client "Client"

foreign import data S9 :: Type
foreign import data S9Connected :: Type
foreign import data S11 :: Type
foreign import data S12 :: Type
foreign import data S13 :: Type
foreign import data S14 :: Type
foreign import data S10 :: Type

instance initialClient :: Initial Client S9
instance terminalClient :: Terminal Client S10
instance sendAfterterminalClientFail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Terminal"))) => Send Client S10 S10 b       -- Error Handling Instance
instance receiveAfterterminalClientFail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Terminal"))) => Receive Client S10 S10 b       -- Error Handling Instance
instance connectAfterterminalClientFail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Terminal"))) => Connect Client Client S10 S10       -- Error Handling Instance
instance disconnectAfterterminalClientFail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Terminal"))) => Disconnect Client Client S10 S10       -- Error Handling Instance
instance selectAfterterminalClientFail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Terminal"))) => Select Client S10 ()       -- Error Handling Instance
instance branchAfterterminalClientFail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Terminal"))) => Branch Client Client S10 ()       -- Error Handling Instance
instance connectS9 :: Connect Client Server S9 S9Connected
instance sendAfterconnectS9Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Connect"))) => Send Client S9 S9 b       -- Error Handling Instance
instance receiveAfterconnectS9Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Connect"))) => Receive Client S9 S9 b       -- Error Handling Instance
instance disconnectAfterconnectS9Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Connect"))) => Disconnect Client Client S9 S9       -- Error Handling Instance
instance selectAfterconnectS9Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Connect"))) => Select Client S9 ()       -- Error Handling Instance
instance branchAfterconnectS9Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Connect"))) => Branch Client Client S9 ()       -- Error Handling Instance
instance sendS9 :: Send Server S9Connected S11 Connect
instance receiveAftersendS9Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Send message of type Connect"))) => Receive Server S9Connected S9Connected b       -- Error Handling Instance
instance connectAftersendS9Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Send message of type Connect"))) => Connect Client Server S9Connected S9Connected       -- Error Handling Instance
instance disconnectAftersendS9Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Send message of type Connect"))) => Disconnect Client Server S9Connected S9Connected       -- Error Handling Instance
instance selectAftersendS9Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Send message of type Connect"))) => Select Server S9Connected ()       -- Error Handling Instance
instance branchAftersendS9Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Send message of type Connect"))) => Branch Client Server S9Connected ()       -- Error Handling Instance
instance sendS11 :: Send Server S11 S12 Add
instance receiveAftersendS11Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Send message of type Add"))) => Receive Server S11 S11 b       -- Error Handling Instance
instance connectAftersendS11Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Send message of type Add"))) => Connect Client Server S11 S11       -- Error Handling Instance
instance disconnectAftersendS11Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Send message of type Add"))) => Disconnect Client Server S11 S11       -- Error Handling Instance
instance selectAftersendS11Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Send message of type Add"))) => Select Server S11 ()       -- Error Handling Instance
instance branchAftersendS11Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Send message of type Add"))) => Branch Client Server S11 ()       -- Error Handling Instance
instance receiveS12 :: Receive Server S12 S13 Add
instance sendAfterreceiveS12Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Receive message of type Add"))) => Send Server S12 S12 b       -- Error Handling Instance
instance connectAfterreceiveS12Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Receive message of type Add"))) => Connect Client Server S12 S12       -- Error Handling Instance
instance disconnectAfterreceiveS12Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Receive message of type Add"))) => Disconnect Client Server S12 S12       -- Error Handling Instance
instance selectAfterreceiveS12Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Receive message of type Add"))) => Select Server S12 ()       -- Error Handling Instance
instance branchAfterreceiveS12Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Receive message of type Add"))) => Branch Client Server S12 ()       -- Error Handling Instance
instance receiveS13 :: Receive Server S13 S14 Add
instance sendAfterreceiveS13Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Receive message of type Add"))) => Send Server S13 S13 b       -- Error Handling Instance
instance connectAfterreceiveS13Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Receive message of type Add"))) => Connect Client Server S13 S13       -- Error Handling Instance
instance disconnectAfterreceiveS13Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Receive message of type Add"))) => Disconnect Client Server S13 S13       -- Error Handling Instance
instance selectAfterreceiveS13Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Receive message of type Add"))) => Select Server S13 ()       -- Error Handling Instance
instance branchAfterreceiveS13Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Receive message of type Add"))) => Branch Client Server S13 ()       -- Error Handling Instance
instance disconnectS14 :: Disconnect Client Server S14 S10
instance sendAfterdisconnectS14Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Disconnect"))) => Send Client S14 S14 b       -- Error Handling Instance
instance receiveAfterdisconnectS14Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Disconnect"))) => Receive Client S14 S14 b       -- Error Handling Instance
instance connectAfterdisconnectS14Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Disconnect"))) => Connect Client Client S14 S14       -- Error Handling Instance
instance selectAfterdisconnectS14Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Disconnect"))) => Select Client S14 ()       -- Error Handling Instance
instance branchAfterdisconnectS14Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Disconnect"))) => Branch Client Client S14 ()       -- Error Handling Instance

foreign import data Server :: Role

instance roleNameServer :: RoleName Server "Server"

foreign import data S22 :: Type
foreign import data S24 :: Type
foreign import data S25 :: Type
foreign import data S26 :: Type
foreign import data S27 :: Type
foreign import data S23 :: Type

instance initialServer :: Initial Server S22
instance terminalServer :: Terminal Server S23
instance sendAfterterminalServerFail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Terminal"))) => Send Server S23 S23 b       -- Error Handling Instance
instance receiveAfterterminalServerFail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Terminal"))) => Receive Server S23 S23 b       -- Error Handling Instance
instance connectAfterterminalServerFail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Terminal"))) => Connect Server Server S23 S23       -- Error Handling Instance
instance disconnectAfterterminalServerFail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Terminal"))) => Disconnect Server Server S23 S23       -- Error Handling Instance
instance selectAfterterminalServerFail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Terminal"))) => Select Server S23 ()       -- Error Handling Instance
instance branchAfterterminalServerFail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Terminal"))) => Branch Server Server S23 ()       -- Error Handling Instance
instance acceptS22 :: Accept Server Client S22 S24
instance sendAfteracceptS22Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Accept"))) => Send Server S22 S22 b       -- Error Handling Instance
instance receiveAfteracceptS22Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Accept"))) => Receive Server S22 S22 b       -- Error Handling Instance
instance connectAfteracceptS22Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Accept"))) => Connect Server Server S22 S22       -- Error Handling Instance
instance disconnectAfteracceptS22Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Accept"))) => Disconnect Server Server S22 S22       -- Error Handling Instance
instance selectAfteracceptS22Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Accept"))) => Select Server S22 ()       -- Error Handling Instance
instance branchAfteracceptS22Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Accept"))) => Branch Server Server S22 ()       -- Error Handling Instance
instance receiveS24 :: Receive Client S24 S25 Add
instance sendAfterreceiveS24Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Receive message of type Add"))) => Send Client S24 S24 b       -- Error Handling Instance
instance connectAfterreceiveS24Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Receive message of type Add"))) => Connect Server Client S24 S24       -- Error Handling Instance
instance disconnectAfterreceiveS24Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Receive message of type Add"))) => Disconnect Server Client S24 S24       -- Error Handling Instance
instance selectAfterreceiveS24Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Receive message of type Add"))) => Select Client S24 ()       -- Error Handling Instance
instance branchAfterreceiveS24Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Receive message of type Add"))) => Branch Server Client S24 ()       -- Error Handling Instance
instance sendS25 :: Send Client S25 S26 Add
instance receiveAftersendS25Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Send message of type Add"))) => Receive Client S25 S25 b       -- Error Handling Instance
instance connectAftersendS25Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Send message of type Add"))) => Connect Server Client S25 S25       -- Error Handling Instance
instance disconnectAftersendS25Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Send message of type Add"))) => Disconnect Server Client S25 S25       -- Error Handling Instance
instance selectAftersendS25Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Send message of type Add"))) => Select Client S25 ()       -- Error Handling Instance
instance branchAftersendS25Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Send message of type Add"))) => Branch Server Client S25 ()       -- Error Handling Instance
instance sendS26 :: Send Client S26 S27 Add
instance receiveAftersendS26Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Send message of type Add"))) => Receive Client S26 S26 b       -- Error Handling Instance
instance connectAftersendS26Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Send message of type Add"))) => Connect Server Client S26 S26       -- Error Handling Instance
instance disconnectAftersendS26Fail :: (Fail (Above (Text "Actual: Disconnect") (Text "Expected: Send message of type Add"))) => Disconnect Server Client S26 S26       -- Error Handling Instance
instance selectAftersendS26Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Send message of type Add"))) => Select Client S26 ()       -- Error Handling Instance
instance branchAftersendS26Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Send message of type Add"))) => Branch Server Client S26 ()       -- Error Handling Instance
instance disconnectS27 :: Disconnect Server Client S27 S23
instance sendAfterdisconnectS27Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Send message of type ") (Quote b))(Text "Expected: Disconnect"))) => Send Server S27 S27 b       -- Error Handling Instance
instance receiveAfterdisconnectS27Fail :: (AnyMessageType b, Fail (Above (Beside (Text "Actual: Receive message of type ") (Quote b))(Text "Expected: Disconnect"))) => Receive Server S27 S27 b       -- Error Handling Instance
instance connectAfterdisconnectS27Fail :: (Fail (Above (Text "Actual: Connect") (Text "Expected: Disconnect"))) => Connect Server Server S27 S27       -- Error Handling Instance
instance selectAfterdisconnectS27Fail :: (Fail (Above (Text "Actual: Select") (Text "Expected: Disconnect"))) => Select Server S27 ()       -- Error Handling Instance
instance branchAfterdisconnectS27Fail :: (Fail (Above (Text "Actual: Branch") (Text "Expected: Disconnect"))) => Branch Server Server S27 ()       -- Error Handling Instance

