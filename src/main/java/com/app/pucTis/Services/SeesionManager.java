package com.app.pucTis.Services;

import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Teacher;

public class SeesionManager {
    private static final ThreadLocal<Administrator> authenticatedAdministrator = new ThreadLocal<>();
    private  static final  ThreadLocal<Teacher> authenticatedTeacher = new ThreadLocal<>();
    private  static final  ThreadLocal<Parents> authenticatedParents = new ThreadLocal<>();

    public static void setAuthenticatedAdministrator(Administrator administrator){
        authenticatedAdministrator.set(administrator);
    }

    public static Administrator getAuthenticatedAdministrator(){
        return authenticatedAdministrator.get();
    }
    public static void clearAuthenticatedAdministrator(){
        authenticatedAdministrator.remove();
    }
    public static void setAuthenticatedTeacher(Teacher teacher){
        authenticatedTeacher.set(teacher);
    }

    public static Teacher getAuthenticatedTeacher(){
        return authenticatedTeacher.get();
    }

    public static void clearAuthenticatedTeacher(){
        authenticatedTeacher.remove();
    }

    public static void setAuthenticatedParents(Parents parents){
        authenticatedParents.set(parents);
    }

    public static Parents getAuthenticatedParents(){
        return authenticatedParents.get();
    }

    public static void clearAuthenticatedParents() {authenticatedParents.remove();}
}
