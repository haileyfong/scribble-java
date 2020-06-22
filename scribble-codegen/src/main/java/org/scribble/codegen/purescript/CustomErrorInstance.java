package org.scribble.codegen.purescript;

public class CustomErrorInstance {
    private DataType state;

    public CustomErrorInstance(DataType s){
        this.state = s;
    }

    public String generateInstance(TypeClassInstance instance, int i) {
        StringBuilder sb = new StringBuilder();
        sb.append("instance "
                + instance.getInstanceName()
                + "Fail"
                + i
                + " :: "
                + "Fail (Text"
                + " \""
                + generateErrorMsg(instance)
                + "\")"
                + " => "
                + instance.getTypeclass()
                + " "
        );

        TypeClassInstance instanceCopy = instance.subParams(1, state.name);
        for (String parameter : instanceCopy.getParameters()) {
            sb.append(" " + parameter);
        }
        sb.append("\n");
        return sb.toString();
    }

    private String generateErrorMsg(TypeClassInstance instance) {
        switch (instance.getTypeclass()) {
            case SEND:
            case RECEIVE:
                return genSendRecvErrorMsg(instance);
            default:
                return "Invalid state access occured";
        }
    }

    private String genSendRecvErrorMsg(TypeClassInstance instance) {
        StringBuilder sb = new StringBuilder();
        String direction = instance.getTypeclass() == TypeClass.SEND ? "to" : "from";
        sb.append(typeClassToString(instance)
                + " "
                + direction
                + " "
                + instance.getToRole()
                +  " from "
                + this.state.name
                + " to "
                + instance.getSuccState()
                + " is invalid"
        );
        return sb.toString();

    }

    private String typeClassToString(TypeClassInstance instance) {
        switch (instance.getTypeclass()) {
            case SEND:
                return "Sending";
            case RECEIVE:
                return "Receiving";
            case CONNECT:
                return "Connecting";
            case DISCONNECT:
                return "Disconnecting";
            default:
                return "";
        }
    }

}
