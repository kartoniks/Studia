package renonkarton.playarena_app;

public class League {

    private String localization;
    Integer number;
    String url;

    public League()
    {
        localization = "";
        number = -1;
        url = "";
    }

    public League(String loc, int num, String url)
    {
        localization = loc;
        number = num;
        this.url = url;
    }

    public String toString()
    {
        return localization + number.toString();
    }
}
