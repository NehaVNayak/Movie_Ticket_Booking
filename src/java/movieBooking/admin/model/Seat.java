package movieBooking.admin.model;


public class Seat {
    private int seatID;
    private int movieID;
    private String showTime;
    private String seatNumber;
    private String status;
    private String seatType;  // Regular or Premium

    // Constructor
    public Seat(int seatID, int movieID, String showTime, String seatNumber, String status, String seatType) {
        this.seatID = seatID;
        this.movieID = movieID;
        this.showTime = showTime;
        this.seatNumber = seatNumber;
        this.status = status;
        this.seatType = seatType;
    }

    // Getters and Setters
    public int getSeatID() { return seatID; }
    public void setSeatID(int seatID) { this.seatID = seatID; }

    public int getMovieID() { return movieID; }
    public void setMovieID(int movieID) { this.movieID = movieID; }

    public String getShowTime() { return showTime; }
    public void setShowTime(String showTime) { this.showTime = showTime; }

    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getSeatType() { return seatType; }
    public void setSeatType(String seatType) { this.seatType = seatType; }
}
