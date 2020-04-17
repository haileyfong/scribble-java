package org.scribble.codegen.purescript;

import java.util.List;

public class CustomErrorInstanceFactory {
    private List<TypeClass> tclist;
    private TypeClassInstance instance;
    private TypeClassInstance nextInstance;
    private String role;
    public CustomErrorInstanceFactory (List<TypeClass> tclist, TypeClassInstance instance, String role) {
        this.tclist = tclist;
        this.instance = instance;
        this.role = role;
//        this.nextInstance = nextInstance;
    }

    public String generate() {
        StringBuilder sb = new StringBuilder();
        for (TypeClass t : this.tclist) {
            sb.append("instance "
                    + t.name().toLowerCase() + "After" + instance.getInstanceName() + "Fail"
                    + " :: "
                    + "(" + generateConstraints(t) + ")"
                    + " => "
                    + generateInstance(t)
                    + "       -- Error Handling Instance"
                    );
            sb.append("\n");
        }
        return sb.toString();
    }

    private String generateConstraints(TypeClass t) {
        StringBuilder sb = new StringBuilder();
        if (t.equals(TypeClass.SEND) || t.equals(TypeClass.RECEIVE)) {
            sb.append("AnyMessageType b, ");
        }
        sb.append(generateFailConstraint(t));
        return sb.toString();

    }

    private String generateFailConstraint(TypeClass t) {
        StringBuilder sb = new StringBuilder();
        sb.append("Fail (Above ");

        //Error Message
        switch(t) {
            case SEND:
            case RECEIVE:
                sb.append("(Beside (Text \"Actual: " + t.toString() + " message of type \") (Quote b))");
                break;
            default:
                sb.append("(Text \"Actual: " + t.toString() + "\") ");
                break;

        }

        sb.append("(Text \"Expected: " + instance.getTypeclass().toString());
        switch(instance.getTypeclass()) {
            case SEND:
            case RECEIVE:
                sb.append(" message of type " + instance.getParameters()[3]);
                break;
        }

        sb.append("\"))");
        return sb.toString();
    }

    private String generateInstance(TypeClass t) {
        StringBuilder sb = new StringBuilder();
        sb.append(t.toString() + " ");
        switch (t) {
            case SEND:
            case RECEIVE:
                String currS = instance.getCurrState();
                sb.append(instance.getToRole() + " " + currS + " " + currS + " b");
                break;
            case CONNECT:
            case DISCONNECT:
                currS = instance.getCurrState();
                sb.append(role + " " + instance.getToRole() + " " + currS + " " + currS);
                break;
            case BRANCH:
                sb.append(role + " ");
            case SELECT:
                sb.append(instance.getToRole() + " " + instance.getCurrState() + " " + "()");
                break;
        }
        return sb.toString();
    }
}
