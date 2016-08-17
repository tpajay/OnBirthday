package com.onbirthday.store;

import java.util.*;
import java.text.*;
import com.onbirthday.store.*;

public class Customer{

    String email;
    String password;
	String fname;
	String lname;
	String company;
	String address1;
	String address2;
	String city;
	String state;
	String zipcode;
	String phone;
	String ipaddress;
	String approved;

    public String getEmail(){ return this.email; }
    public void setEmail(String value){ this.email = value; }

    public String getPassword(){ return this.password; }
    public void setPassword(String value){ this.password = value; }

    public String getFname(){ return this.fname; }
    public void setFname(String value){ this.fname = value; }

    public String getLname(){ return this.lname; }
    public void setLname(String value){ this.lname = value; }

    public String getCompany(){ return this.company; }
    public void setCompany(String value){ this.company = value; }

    public String getAddress1(){ return this.address1; }
    public void setAddress1(String value){ this.address1 = value; }

    public String getAddress2(){ return this.address2; }
    public void setAddress2(String value){ this.address2 = value; }

    public String getCity(){ return this.city; }
    public void setCity(String value){ this.city = value; }

    public String getState(){ return this.state; }
    public void setState(String value){ this.state = value; }

    public String getZipcode(){ return this.zipcode; }
    public void setZipcode(String value){ this.zipcode = value; }

    public String getPhone(){ return this.phone; }
    public void setPhone(String value){ this.phone = value; }

    public String getIpAddress(){ return this.ipaddress; }
    public void setIpAddress(String value){ this.ipaddress = value; }

    public String getApproved(){ return this.approved; }
    public void setApproved(String value){ this.approved = value; }

}//end class.
