package com.onbirthday.decorator;

import java.util.*;
import java.io.*;
import java.text.*;
import org.displaytag.decorator.TableDecorator;
import org.apache.commons.beanutils.*;


public class DisplayWrapper extends TableDecorator{

	Object id;

	public DisplayWrapper(){
        super();
    }

    // for pending tips //
    public String getAdmin1(){

        try{
        	DynaBean object = (DynaBean) getCurrentRowObject();
        	id = (Object)object.get("busid");
        }catch(Exception ex){
        	System.out.println(ex.getMessage());
        }
        return "<a href=\"/admintasks.do?id=" + id
            + "&action=edit&frompage=pendingtips\">Edit</a> | "
            + "<a href=\"/admintasks.do?id=" + id
            + "&action=delete&frompage=pendingtips\">Delete</a>";
    }

    // for restaurants //
    public String getAdmin2(){

        try{
        	DynaBean object = (DynaBean) getCurrentRowObject();
        	id = (Object)object.get("busid");
        }catch(Exception ex){
        	System.out.println(ex.getMessage());
        }
        return "<a href=\"/admintasks.do?id=" + id
            + "&action=edit&frompage=rest\">Edit</a> | "
            + "<a href=\"/admintasks.do?id=" + id
            + "&action=delete&frompage=rest\">Delete</a>";
    }

    // for comments //
    public String getAdmin3(){

        try{
        	DynaBean object = (DynaBean) getCurrentRowObject();
        	id = (Object)object.get("id");
        }catch(Exception ex){
        	System.out.println(ex.getMessage());
        }
        return "<a href=\"/admintasks.do?id=" + id
            + "&action=delete&frompage=comments\">Delete</a>";
    }

}//end class.
