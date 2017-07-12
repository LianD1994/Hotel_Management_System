package Hotel_Reservation_System;
import java.util.*;

public class resInfo {
	
	String resDate; 
	String checkin;
	String checkout;
	int HotelID;
	int room_no;
	int Cnumber;
	
	public resInfo(){
		this.resDate = null;
		this.checkin = null;
		this.checkout = null;
		this.HotelID = -1;
		this.room_no = -1;
		this.Cnumber = -1;
	}
	
	public void setResDate(String resDate){
		this.resDate = resDate;
	}
	
	public void setCheckinDate(String checkinDate){
		this.checkin = checkinDate;
	}
	
	public void setCheckoutDate(String checkoutDate){
		this.checkout = checkoutDate;
	}
	
	public void setHotelID(int HotelID){
		this.HotelID = HotelID;
	}
	
	public void setRoomNo(int roomNum){
		this.room_no = roomNum;
	}
	
	public void setCnumber(int Cnumber){
		this.Cnumber = Cnumber;
	}
	
	public int getRoomNo(){
		return this.room_no;
	}
	
	public int getHotelID(){
		return this.HotelID;
	}
	
	public String getResDate(){
		return this.resDate;
	}
	
	public String getCheckinDate(){
		return this.checkin;
	}
	
	public String getCheckoutDate(){
		return this.checkout;
	}
}
