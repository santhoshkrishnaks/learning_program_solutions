interface Document{
    void print();
}

class Word implements Document{
    public void print(){
        System.out.println("Word Document created");
    }
}
class Pdf implements Document{
    public void print(){
        System.out.println("Pdf Document created");
    }
}
class Excel implements Document{
    public void print(){
        System.out.println("Excel Document created");
    }
}

abstract class DocumentFactory{
    abstract Document createDocument();
}
class WordDocument extends DocumentFactory{
    Document createDocument(){
        return new Word();
    }
}
class PdfDocument extends DocumentFactory{
    Document createDocument(){
        return new Pdf();
    }
}
class ExcelDocument extends DocumentFactory{
    Document createDocument(){
        return new Excel();
    }

}


public class Main{
    public static void main(String ar[]){
        DocumentFactory word=new WordDocument();
        Document worddoc=word.createDocument();
        worddoc.print();

        DocumentFactory pdf=new PdfDocument();
        Document pdfdoc=pdf.createDocument();
        pdfdoc.print();

        DocumentFactory excel=new ExcelDocument();
        Document exceldoc=excel.createDocument();
        exceldoc.print();
    }
}