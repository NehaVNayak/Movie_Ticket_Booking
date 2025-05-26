/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package movieBooking.admin.model;
import java.math.BigDecimal;

public class MoviePrices {
    private int id;
    private int movieID;
    private BigDecimal cost;

    // Constructor
    public MoviePrices(int id, int movieID, BigDecimal cost) {
        this.id = id;
        this.movieID = movieID;
        this.cost = cost;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }

    // toString method
    @Override
    public String toString() {
        return "MoviePrice{" +
                "id=" + id +
                ", movieID=" + movieID +
                ", cost=" + cost +
                '}';
    }
}

