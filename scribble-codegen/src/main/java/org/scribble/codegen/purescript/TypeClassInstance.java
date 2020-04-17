package org.scribble.codegen.purescript;

public class TypeClassInstance {
    private final String instance;
    private final TypeClass typeclass;
    private final String[] parameters;

    public TypeClassInstance(String instance, TypeClass typeclass, String[] parameters) {
        this.instance = instance;
        this.typeclass = typeclass;
        this.parameters = parameters;
    }

    public String generateInstance() {
        StringBuilder sb = new StringBuilder();
        sb.append("instance " + instance + " :: " + typeclass);
        for (String parameter : parameters) {
            sb.append(" " + parameter);
        }
        sb.append("\n");
        return sb.toString();
    }

    public String getInstanceName() {
        return instance;
    }

    public TypeClass getTypeclass() {
        return typeclass;
    }

    public String[] getParameters() {
        return parameters;
    }

    public String getToRole() {
        return parameters[0];
    }

    public TypeClassInstance subParams(int index, String replacement) {
        TypeClassInstance copy = this;
        copy.parameters[index] = replacement;
        return copy;
    }

    public String getCurrState() {
        switch(typeclass) {
            case CONNECT:
            case DISCONNECT:
            case ACCEPT:
                return parameters[2];
            default:
                return parameters[1];
        }
    }

    public String getSuccState() {
        switch(typeclass) {
            case CONNECT:
            case DISCONNECT:
                return parameters[3];
            case SEND:
            case RECEIVE:
                return parameters[2];
            default:
                return "";
        }
    }
}
