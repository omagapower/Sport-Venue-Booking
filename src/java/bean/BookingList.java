
package bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


public class BookingList implements Serializable {
    private List<Booking> list = new ArrayList<Booking>();

    public void setChild(Booking object){
        list.add(object);
    }
    public List<Booking> getList(){
        return list;
    }
}
