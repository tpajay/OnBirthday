package com.onbirthday.store;

import java.util.*;
import java.text.*;
import com.onbirthday.store.*;

public class CartItem{
	
    String sku;
    String description;
	String price;
	int qty;
		
    public String getSku(){ return this.sku; }
    public void setSku(String value){ this.sku = value; }
    
    public String getDescription(){ return this.description; }
    public void setDescription(String value){ this.description = value; }
    
    public String getPrice(){ return this.price; }
    public void setPrice(String value){ this.price = value; }
    
    public int getQty(){ return this.qty; }
    public void setQty(int value){ this.qty = value; }


}//end class.
