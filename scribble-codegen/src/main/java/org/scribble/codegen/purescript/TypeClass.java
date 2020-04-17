package org.scribble.codegen.purescript;

public enum TypeClass {
    ROLENAME,
    SEND,
    RECEIVE,
    CONNECT,
    DISCONNECT,
    SELECT,
    BRANCH,
    ACCEPT,
    INITIAL,
    TERMINAL;

    @Override
    public String toString() {
        if (this.equals(ROLENAME)) {
            return "RoleName";
        }
        return this.name().substring(0, 1) + this.name().substring(1).toLowerCase();
    }
}

