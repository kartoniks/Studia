package main2;

public class SquareWorker implements IShapeWorker {
    public boolean AcceptsName(String name){
        return name.equals("Square");
    }

    public IShape Create(Object... params){
        double height = new Double(params[0].toString());
        return new Square(height);
    }
}
