package renonkarton.playarena_app;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class LeagueList
{
    List<List<String>>list;

    public LeagueList()
    {
        list = new ArrayList<List<String>>();
        List<String> city = new ArrayList<String>(Arrays.asList("Wrocław", "28","15679","15680","15681","15682","16323"));
        list.add(city);
        city = new ArrayList<String>(Arrays.asList("Opole","3","15613"));
        list.add(city);
        city = new ArrayList<String>(Arrays.asList("Lubin","193","16025","16026"));
        list.add(city);
        city = new ArrayList<String>(Arrays.asList("Głogów","1035","15609"));
        list.add(city);
        city = new ArrayList<String>(Arrays.asList("Zielona Góra","408","15628"));
        list.add(city);
        city = new ArrayList<String>(Arrays.asList("Gorzów Wielkopolski","716","15599"));
        list.add(city);
    }
}