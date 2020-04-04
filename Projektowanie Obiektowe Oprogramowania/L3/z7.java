//create a ReportComposer, which has other classes injected
//now the class doesn't depend on a single implementation, but can be extended 
//by different repo, formatter and displayer subclassess

public class ReportComposer {
    public ReportComposer(ReportRepository repo, Formatter formatter, Displayer displayer) {
        this.repo = repo;
        this.formatter = formatter;
        this.displayer = displayer;
    }

    private ReportRepository repo;
    private Formatter formatter;
    private Displayer displayer;
    private String document;

    public String GetData() {
        return repo.GetData();
    };
    public void FormatDocument() {
        String document = GetData();
        formatter.FormatDocument(this.document);
    };
    public void PrintReport() {
        return displayer.PrintReport(this.document);
    };
}

public class ReportRepository {
    private String data = "this is the document data";
    public String GetData() {
        return this.data;
    }
}

public class Formatter {
    void FormatDocument(String document) {
        document.concat(" formatted");
    }
}

public class Deisplayer {
    void PrintReport(String document) {
        System.out.println(document)
    }
}