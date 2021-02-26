
package bean;

import java.io.Serializable;
import java.sql.Time;


public class Court implements Serializable {
    private int id;
    private String name, location, picture, status;
    private double price;

    
    public String getStatus() {
        return status;
    }

   
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getName() {
        return name;
    }


    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }


    public void setLocation(String location) {
        this.location = location;
    }
    
    

    public String getPicture() {
        return picture;
    }


    public void setPicture(String picture) {
        this.picture = picture;
    }
    

  
    public int getId() {
        return id;
    }

   
    public void setId(int id) {
        this.id = id;
    }

    
    public double getPrice() {
        return price;
    }

    
    public void setPrice(double price) {
        this.price = price;
    }
}
