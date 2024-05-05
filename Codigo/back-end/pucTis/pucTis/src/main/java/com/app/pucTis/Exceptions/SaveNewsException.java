package com.app.pucTis.Exceptions;

public class SaveNewsException extends RuntimeException {

    public SaveNewsException(String message) {
        super(message);
    }

    public SaveNewsException(String message, Throwable cause) {
        super(message, cause);
    }
}
