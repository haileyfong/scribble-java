module Scribble.Protocol.Arithmetic.MathServer where

import Scribble.FSM
import Data.Void (Void)
import Data.Tuple (Tuple)

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
derive instance genericAdd :: Generic Add _
instance encodeJsonAdd :: EncodeJson Add where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonAdd :: DecodeJson Add where
  decodeJson = genericDecodeJsonWith jsonEncoding
data Connect = Connect
derive instance genericConnect :: Generic Connect _
instance encodeJsonConnect :: EncodeJson Connect where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonConnect :: DecodeJson Connect where
  decodeJson = genericDecodeJsonWith jsonEncoding
data Multiply = Multiply Int Int
derive instance genericMultiply :: Generic Multiply _
instance encodeJsonMultiply :: EncodeJson Multiply where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonMultiply :: DecodeJson Multiply where
  decodeJson = genericDecodeJsonWith jsonEncoding
data Quit = Quit
derive instance genericQuit :: Generic Quit _
instance encodeJsonQuit :: EncodeJson Quit where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonQuit :: DecodeJson Quit where
  decodeJson = genericDecodeJsonWith jsonEncoding
data Product = Product Int
derive instance genericProduct :: Generic Product _
instance encodeJsonProduct :: EncodeJson Product where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonProduct :: DecodeJson Product where
  decodeJson = genericDecodeJsonWith jsonEncoding
data Sum = Sum Int
derive instance genericSum :: Generic Sum _
instance encodeJsonSum :: EncodeJson Sum where
  encodeJson = genericEncodeJsonWith jsonEncoding
instance decodeJsonSum :: DecodeJson Sum where
  decodeJson = genericDecodeJsonWith jsonEncoding

foreign import data MathServer :: Protocol

foreign import data Client :: Role

instance roleNameClient :: RoleName Client "Client"

foreign import data S11 :: Type
foreign import data S11Connected :: Type
foreign import data S13 :: Type
foreign import data S13Add :: Type
foreign import data S13Multiply :: Type
foreign import data S13Quit :: Type
foreign import data S14 :: Type
foreign import data S15 :: Type
foreign import data S16 :: Type
foreign import data S12 :: Type

instance initialClient :: Initial Client S11
instance terminalClient :: Terminal Client S12
instance connectS11 :: Connect Client Server S11 S11Connected
instance sendS11 :: Send Server S11Connected S13 Connect
else instance sendS11Fail1 :: Fail (Text "Sending to Server from S11 to S13 is invalid") => Send  Server S11 S13 Connect
else instance sendS11Fail2 :: Fail (Text "Sending to Server from S13 to S13 is invalid") => Send  Server S13 S13 Connect
else instance sendS11Fail3 :: Fail (Text "Sending to Server from S13Add to S13 is invalid") => Send  Server S13Add S13 Connect
else instance sendS11Fail4 :: Fail (Text "Sending to Server from S13Multiply to S13 is invalid") => Send  Server S13Multiply S13 Connect
else instance sendS11Fail5 :: Fail (Text "Sending to Server from S13Quit to S13 is invalid") => Send  Server S13Quit S13 Connect
else instance sendS11Fail6 :: Fail (Text "Sending to Server from S14 to S13 is invalid") => Send  Server S14 S13 Connect
else instance sendS11Fail7 :: Fail (Text "Sending to Server from S15 to S13 is invalid") => Send  Server S15 S13 Connect
else instance sendS11Fail8 :: Fail (Text "Sending to Server from S16 to S13 is invalid") => Send  Server S16 S13 Connect
else instance sendS11Fail9 :: Fail (Text "Sending to Server from S12 to S13 is invalid") => Send  Server S12 S13 Connect
instance sendS13Add :: Send Server S13Add S14 Add
else instance sendS13AddFail1 :: Fail (Text "Sending to Server from S11 to S14 is invalid") => Send  Server S11 S14 Add
else instance sendS13AddFail2 :: Fail (Text "Sending to Server from S11Connected to S14 is invalid") => Send  Server S11Connected S14 Add
else instance sendS13AddFail3 :: Fail (Text "Sending to Server from S13 to S14 is invalid") => Send  Server S13 S14 Add
else instance sendS13AddFail4 :: Fail (Text "Sending to Server from S13Multiply to S14 is invalid") => Send  Server S13Multiply S14 Add
else instance sendS13AddFail5 :: Fail (Text "Sending to Server from S13Quit to S14 is invalid") => Send  Server S13Quit S14 Add
else instance sendS13AddFail6 :: Fail (Text "Sending to Server from S14 to S14 is invalid") => Send  Server S14 S14 Add
else instance sendS13AddFail7 :: Fail (Text "Sending to Server from S15 to S14 is invalid") => Send  Server S15 S14 Add
else instance sendS13AddFail8 :: Fail (Text "Sending to Server from S16 to S14 is invalid") => Send  Server S16 S14 Add
else instance sendS13AddFail9 :: Fail (Text "Sending to Server from S12 to S14 is invalid") => Send  Server S12 S14 Add
instance sendS13Multiply :: Send Server S13Multiply S15 Multiply
else instance sendS13MultiplyFail1 :: Fail (Text "Sending to Server from S11 to S15 is invalid") => Send  Server S11 S15 Multiply
else instance sendS13MultiplyFail2 :: Fail (Text "Sending to Server from S11Connected to S15 is invalid") => Send  Server S11Connected S15 Multiply
else instance sendS13MultiplyFail3 :: Fail (Text "Sending to Server from S13 to S15 is invalid") => Send  Server S13 S15 Multiply
else instance sendS13MultiplyFail4 :: Fail (Text "Sending to Server from S13Add to S15 is invalid") => Send  Server S13Add S15 Multiply
else instance sendS13MultiplyFail5 :: Fail (Text "Sending to Server from S13Quit to S15 is invalid") => Send  Server S13Quit S15 Multiply
else instance sendS13MultiplyFail6 :: Fail (Text "Sending to Server from S14 to S15 is invalid") => Send  Server S14 S15 Multiply
else instance sendS13MultiplyFail7 :: Fail (Text "Sending to Server from S15 to S15 is invalid") => Send  Server S15 S15 Multiply
else instance sendS13MultiplyFail8 :: Fail (Text "Sending to Server from S16 to S15 is invalid") => Send  Server S16 S15 Multiply
else instance sendS13MultiplyFail9 :: Fail (Text "Sending to Server from S12 to S15 is invalid") => Send  Server S12 S15 Multiply
instance sendS13Quit :: Send Server S13Quit S16 Quit
else instance sendS13QuitFail1 :: Fail (Text "Sending to Server from S11 to S16 is invalid") => Send  Server S11 S16 Quit
else instance sendS13QuitFail2 :: Fail (Text "Sending to Server from S11Connected to S16 is invalid") => Send  Server S11Connected S16 Quit
else instance sendS13QuitFail3 :: Fail (Text "Sending to Server from S13 to S16 is invalid") => Send  Server S13 S16 Quit
else instance sendS13QuitFail4 :: Fail (Text "Sending to Server from S13Add to S16 is invalid") => Send  Server S13Add S16 Quit
else instance sendS13QuitFail5 :: Fail (Text "Sending to Server from S13Multiply to S16 is invalid") => Send  Server S13Multiply S16 Quit
else instance sendS13QuitFail6 :: Fail (Text "Sending to Server from S14 to S16 is invalid") => Send  Server S14 S16 Quit
else instance sendS13QuitFail7 :: Fail (Text "Sending to Server from S15 to S16 is invalid") => Send  Server S15 S16 Quit
else instance sendS13QuitFail8 :: Fail (Text "Sending to Server from S16 to S16 is invalid") => Send  Server S16 S16 Quit
else instance sendS13QuitFail9 :: Fail (Text "Sending to Server from S12 to S16 is invalid") => Send  Server S12 S16 Quit
instance selectS13 :: Select Server S13 ("multiply" :: S13Multiply, "quit" :: S13Quit, "add" :: S13Add)
instance receiveS14 :: Receive Server S14 S13 Sum
else instance receiveS14Fail1 :: Fail (Text "Receiving from Server from S11 to S13 is invalid") => Receive  Server S11 S13 Sum
else instance receiveS14Fail2 :: Fail (Text "Receiving from Server from S11Connected to S13 is invalid") => Receive  Server S11Connected S13 Sum
else instance receiveS14Fail3 :: Fail (Text "Receiving from Server from S13 to S13 is invalid") => Receive  Server S13 S13 Sum
else instance receiveS14Fail4 :: Fail (Text "Receiving from Server from S13Add to S13 is invalid") => Receive  Server S13Add S13 Sum
else instance receiveS14Fail5 :: Fail (Text "Receiving from Server from S13Multiply to S13 is invalid") => Receive  Server S13Multiply S13 Sum
else instance receiveS14Fail6 :: Fail (Text "Receiving from Server from S13Quit to S13 is invalid") => Receive  Server S13Quit S13 Sum
else instance receiveS14Fail7 :: Fail (Text "Receiving from Server from S15 to S13 is invalid") => Receive  Server S15 S13 Sum
else instance receiveS14Fail8 :: Fail (Text "Receiving from Server from S16 to S13 is invalid") => Receive  Server S16 S13 Sum
else instance receiveS14Fail9 :: Fail (Text "Receiving from Server from S12 to S13 is invalid") => Receive  Server S12 S13 Sum
instance receiveS15 :: Receive Server S15 S13 Product
else instance receiveS15Fail1 :: Fail (Text "Receiving from Server from S11 to S13 is invalid") => Receive  Server S11 S13 Product
else instance receiveS15Fail2 :: Fail (Text "Receiving from Server from S11Connected to S13 is invalid") => Receive  Server S11Connected S13 Product
else instance receiveS15Fail3 :: Fail (Text "Receiving from Server from S13 to S13 is invalid") => Receive  Server S13 S13 Product
else instance receiveS15Fail4 :: Fail (Text "Receiving from Server from S13Add to S13 is invalid") => Receive  Server S13Add S13 Product
else instance receiveS15Fail5 :: Fail (Text "Receiving from Server from S13Multiply to S13 is invalid") => Receive  Server S13Multiply S13 Product
else instance receiveS15Fail6 :: Fail (Text "Receiving from Server from S13Quit to S13 is invalid") => Receive  Server S13Quit S13 Product
else instance receiveS15Fail7 :: Fail (Text "Receiving from Server from S14 to S13 is invalid") => Receive  Server S14 S13 Product
else instance receiveS15Fail8 :: Fail (Text "Receiving from Server from S16 to S13 is invalid") => Receive  Server S16 S13 Product
else instance receiveS15Fail9 :: Fail (Text "Receiving from Server from S12 to S13 is invalid") => Receive  Server S12 S13 Product
instance disconnectS16 :: Disconnect Client Server S16 S12

foreign import data Server :: Role

instance roleNameServer :: RoleName Server "Server"

foreign import data S26 :: Type
foreign import data S28 :: Type
foreign import data S28Add :: Type
foreign import data S28Multiply :: Type
foreign import data S28Quit :: Type
foreign import data S29 :: Type
foreign import data S30 :: Type
foreign import data S31 :: Type
foreign import data S27 :: Type

instance initialServer :: Initial Server S26
instance terminalServer :: Terminal Server S27
instance acceptS26 :: Accept Server Client S26 S28
instance receiveS28Add :: Receive Client S28Add S29 Add
else instance receiveS28AddFail1 :: Fail (Text "Receiving from Client from S26 to S29 is invalid") => Receive  Client S26 S29 Add
else instance receiveS28AddFail2 :: Fail (Text "Receiving from Client from S28 to S29 is invalid") => Receive  Client S28 S29 Add
else instance receiveS28AddFail3 :: Fail (Text "Receiving from Client from S28Multiply to S29 is invalid") => Receive  Client S28Multiply S29 Add
else instance receiveS28AddFail4 :: Fail (Text "Receiving from Client from S28Quit to S29 is invalid") => Receive  Client S28Quit S29 Add
else instance receiveS28AddFail5 :: Fail (Text "Receiving from Client from S29 to S29 is invalid") => Receive  Client S29 S29 Add
else instance receiveS28AddFail6 :: Fail (Text "Receiving from Client from S30 to S29 is invalid") => Receive  Client S30 S29 Add
else instance receiveS28AddFail7 :: Fail (Text "Receiving from Client from S31 to S29 is invalid") => Receive  Client S31 S29 Add
else instance receiveS28AddFail8 :: Fail (Text "Receiving from Client from S27 to S29 is invalid") => Receive  Client S27 S29 Add
instance receiveS28Multiply :: Receive Client S28Multiply S30 Multiply
else instance receiveS28MultiplyFail1 :: Fail (Text "Receiving from Client from S26 to S30 is invalid") => Receive  Client S26 S30 Multiply
else instance receiveS28MultiplyFail2 :: Fail (Text "Receiving from Client from S28 to S30 is invalid") => Receive  Client S28 S30 Multiply
else instance receiveS28MultiplyFail3 :: Fail (Text "Receiving from Client from S28Add to S30 is invalid") => Receive  Client S28Add S30 Multiply
else instance receiveS28MultiplyFail4 :: Fail (Text "Receiving from Client from S28Quit to S30 is invalid") => Receive  Client S28Quit S30 Multiply
else instance receiveS28MultiplyFail5 :: Fail (Text "Receiving from Client from S29 to S30 is invalid") => Receive  Client S29 S30 Multiply
else instance receiveS28MultiplyFail6 :: Fail (Text "Receiving from Client from S30 to S30 is invalid") => Receive  Client S30 S30 Multiply
else instance receiveS28MultiplyFail7 :: Fail (Text "Receiving from Client from S31 to S30 is invalid") => Receive  Client S31 S30 Multiply
else instance receiveS28MultiplyFail8 :: Fail (Text "Receiving from Client from S27 to S30 is invalid") => Receive  Client S27 S30 Multiply
instance receiveS28Quit :: Receive Client S28Quit S31 Quit
else instance receiveS28QuitFail1 :: Fail (Text "Receiving from Client from S26 to S31 is invalid") => Receive  Client S26 S31 Quit
else instance receiveS28QuitFail2 :: Fail (Text "Receiving from Client from S28 to S31 is invalid") => Receive  Client S28 S31 Quit
else instance receiveS28QuitFail3 :: Fail (Text "Receiving from Client from S28Add to S31 is invalid") => Receive  Client S28Add S31 Quit
else instance receiveS28QuitFail4 :: Fail (Text "Receiving from Client from S28Multiply to S31 is invalid") => Receive  Client S28Multiply S31 Quit
else instance receiveS28QuitFail5 :: Fail (Text "Receiving from Client from S29 to S31 is invalid") => Receive  Client S29 S31 Quit
else instance receiveS28QuitFail6 :: Fail (Text "Receiving from Client from S30 to S31 is invalid") => Receive  Client S30 S31 Quit
else instance receiveS28QuitFail7 :: Fail (Text "Receiving from Client from S31 to S31 is invalid") => Receive  Client S31 S31 Quit
else instance receiveS28QuitFail8 :: Fail (Text "Receiving from Client from S27 to S31 is invalid") => Receive  Client S27 S31 Quit
instance branchS28 :: Branch Server Client S28 ("multiply" :: S28Multiply, "quit" :: S28Quit, "add" :: S28Add)
instance sendS29 :: Send Client S29 S28 Sum
else instance sendS29Fail1 :: Fail (Text "Sending to Client from S26 to S28 is invalid") => Send  Client S26 S28 Sum
else instance sendS29Fail2 :: Fail (Text "Sending to Client from S28 to S28 is invalid") => Send  Client S28 S28 Sum
else instance sendS29Fail3 :: Fail (Text "Sending to Client from S28Add to S28 is invalid") => Send  Client S28Add S28 Sum
else instance sendS29Fail4 :: Fail (Text "Sending to Client from S28Multiply to S28 is invalid") => Send  Client S28Multiply S28 Sum
else instance sendS29Fail5 :: Fail (Text "Sending to Client from S28Quit to S28 is invalid") => Send  Client S28Quit S28 Sum
else instance sendS29Fail6 :: Fail (Text "Sending to Client from S30 to S28 is invalid") => Send  Client S30 S28 Sum
else instance sendS29Fail7 :: Fail (Text "Sending to Client from S31 to S28 is invalid") => Send  Client S31 S28 Sum
else instance sendS29Fail8 :: Fail (Text "Sending to Client from S27 to S28 is invalid") => Send  Client S27 S28 Sum
instance sendS30 :: Send Client S30 S28 Product
else instance sendS30Fail1 :: Fail (Text "Sending to Client from S26 to S28 is invalid") => Send  Client S26 S28 Product
else instance sendS30Fail2 :: Fail (Text "Sending to Client from S28 to S28 is invalid") => Send  Client S28 S28 Product
else instance sendS30Fail3 :: Fail (Text "Sending to Client from S28Add to S28 is invalid") => Send  Client S28Add S28 Product
else instance sendS30Fail4 :: Fail (Text "Sending to Client from S28Multiply to S28 is invalid") => Send  Client S28Multiply S28 Product
else instance sendS30Fail5 :: Fail (Text "Sending to Client from S28Quit to S28 is invalid") => Send  Client S28Quit S28 Product
else instance sendS30Fail6 :: Fail (Text "Sending to Client from S29 to S28 is invalid") => Send  Client S29 S28 Product
else instance sendS30Fail7 :: Fail (Text "Sending to Client from S31 to S28 is invalid") => Send  Client S31 S28 Product
else instance sendS30Fail8 :: Fail (Text "Sending to Client from S27 to S28 is invalid") => Send  Client S27 S28 Product
instance disconnectS31 :: Disconnect Server Client S31 S27

