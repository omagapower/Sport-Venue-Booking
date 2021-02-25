
package bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


public class CourtList implements Serializable {
    private List<Court> list = new ArrayList<Court>();

    public void setChild(Court object){
        list.add(object);
    }
    public List<Court> getList(){
        return list;
    }
}
