package movieBooking.admin.model;

public class Movie {
    private int id;
    private String name;
    private String director;
    private String description;
    private String releaseDate;
    private String casts;
    private String poster;
    private String trailer;
    private String duration;
    private String category;

    public Movie(int id, String name, String director, String description, String releaseDate,
                 String casts, String poster, String trailer, String duration, String category) {
        this.id = id;
        this.name = name;
        this.director = director;
        this.description = description;
        this.releaseDate = releaseDate;
        this.casts = casts;
        this.poster = poster;
        this.trailer = trailer;
        this.duration = duration;
        this.category = category;
    }

    public Movie() {}
    
    
    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getCasts() {
        return casts;
    }

    public void setCasts(String casts) {
        this.casts = casts;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getTrailer() {
        return trailer;
    }

    public void setTrailer(String trailer) {
        this.trailer = trailer;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
