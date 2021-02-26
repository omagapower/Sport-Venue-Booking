
package bean;

import java.io.Serializable;
import java.sql.Time;


public class Report implements Serializable {
    private int id, courtId, booking, approved, declined, cancelled;
    private double earned, totalTime;

    public int getId() {
        return id;
    }

   
    public void setId(int id) {
        this.id = id;
    }
    
    
    public int getCourtId() {
        return courtId;
    }

   
    public void setCourtId(int courtId) {
        this.courtId = courtId;
    }
    
    public int getBooking() {
        return booking;
    }

   
    public void setBooking(int booking) {
        this.booking = booking;
    }
    
    public int getApproved() {
        return approved;
    }

   
    public void setApproved(int approved) {
        this.approved = approved;
    }
    
    public int getDeclined() {
        return declined;
    }

   
    public void setDeclined(int declined) {
        this.declined = declined;
    }
    
    public int getCancelled() {
        return cancelled;
    }

   
    public void setCancelled(int cancelled) {
        this.cancelled = cancelled;
    }

    public double getEarned() {
        return earned;
    }

   
    public void setEarned(double earned) {
        this.earned = earned;
    }
   
    public double getTotalTime() {
        return totalTime;
    }

   
    public void setTotalTime(double totalTime) {
        this.totalTime = totalTime;
    }
   
    
}
