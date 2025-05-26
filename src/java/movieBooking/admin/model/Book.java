/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package movieBooking.admin.model;

public class Book {
    private int bookingID;
    private int userID;
    private int movieID;
    private int seatID;
    private String showTime;
    private String paymentStatus;
    private String bookingDate; 

    // Constructor
    public Book(int bookingID, int userID, int movieID, int seatID, String showTime, String paymentStatus, String bookingDate) {
        this.bookingID = bookingID;
        this.userID = userID;
        this.movieID = movieID;
        this.seatID = seatID;
        this.showTime = showTime;
        this.paymentStatus = paymentStatus;
         this.bookingDate = bookingDate;
    }

    // Getters and Setters
    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public int getSeatID() {
        return seatID;
    }

    public void setSeatID(int seatID) {
        this.seatID = seatID;
    }

    public String getShowTime() {
        return showTime;
    }

    public void setShowTime(String showTime) {
        this.showTime = showTime;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }
    

    // toString method
    @Override
    public String toString() {
        return "Booking{" +
                "bookingID=" + bookingID +
                ", userID=" + userID +
                ", movieID=" + movieID +
                ", seatID=" + seatID +
                ", showTime='" + showTime + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", Booking Date='" + bookingDate + '\'' +
                '}';
    }
}

