package renonkarton.playarena_app;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class LeagueList
{
    static final List<List<String>> list = new ArrayList<List<String>>()
    {{
        List<String> city = new ArrayList<String>(Arrays.asList("Wrocław", "28", "15679", "15680", "15681", "15682", "16323"));
        add(city);
        city = new ArrayList<String>(Arrays.asList("Warszawa", "6", "15658"));
        add(city);
        city = new ArrayList<String>(Arrays.asList("Opole", "3", "15613"));
        add(city);
        city = new ArrayList<String>(Arrays.asList("Lubin", "193", "16025", "16026"));
        add(city);
        city = new ArrayList<String>(Arrays.asList("Głogów", "1035", "15609"));
        add(city);
        city = new ArrayList<String>(Arrays.asList("Zielona Góra", "408", "15628"));
        add(city);
        city = new ArrayList<String>(Arrays.asList("Gorzów Wielkopolski", "716", "15599"));
        add(city);
    }};
}