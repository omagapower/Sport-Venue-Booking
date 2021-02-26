
package bean;

import java.io.Serializable;
import java.sql.Time;


public class Booking implements Serializable {
    private int id, courtId, userId;
    private Time start, end;
    private String day, status;

    public int getId() {
        return id;
    }

   
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }

   
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getCourtId() {
        return courtId;
    }

   
    public void setCourtId(int courtId) {
        this.courtId = courtId;
    }
    
    public String getDay() {
        return day;
    }

   
    public void setDay(String day) {
        this.day = day;
    }
    
    public String getStatus() {
        return status;
    }

   
    public void setStatus(String status) {
        this.status = status;
    }

    
    public Time getStart() {
        return start;
    }

    
    public void setStart(Time start) {
        this.start = start;
    }
    
    public Time getEnd() {
        return end;
    }

    
    public void setEnd(Time end) {
        this.end = end;
    }
    
}
