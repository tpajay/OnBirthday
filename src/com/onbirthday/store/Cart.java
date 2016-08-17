package com.onbirthday.store;

import java.util.*;
import java.text.*;
import com.onbirthday.store.*;

public class Cart{
	
    HashMap shoppingCart;
    
    public void init(){
    	shoppingCart = new HashMap();
    }

    public void addItem(String sku,CartItem item){
    	this.shoppingCart.put(sku,item);
    }
    
    public HashMap getCart(){    	
    	return this.shoppingCart;
    }

    public void deleteItem(String sku){
    	this.shoppingCart.remove(sku);        
    }
    
    public void clearCart(){
    	this.shoppingCart.clear();        
    }
    
    //public void updateItemQty(){        
    //}
    
    //public void showItems(){        
    //}

}//end class.
