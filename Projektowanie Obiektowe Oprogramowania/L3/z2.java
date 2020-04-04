//class before changing:

public class ReportPrinter {
    public String document;
    public String GetData(){
        return "this is mock data";
    };
    public void FormatDocument(){
        this.document += " formatted";
    };
    public void PrintReport(){
        System.out.println(this.document);
    };
}

//here one class is responsible for three processes, let's decouple it into
//three classes driven by a controller

public class ReportContoller {
    private ReportRepository repo = new ReportRepository();
    private Formatter formatter = new Formatter();
    private Displayer displayer = new Displayer();
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

//not every method should be a new class, only those which have a different
//responsibility (are logically separate and not part of one process)