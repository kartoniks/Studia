package main2;

public class RectangleWorker implements IShapeWorker  {
    public boolean AcceptsName(String name){
        return name.equals("Rectangle");
    }

    public IShape Create(Object... params){
        double height = new Double(params[0].toString());
        double length = new Double(params[1].toString());
        return new Rectangle(height, length);
    }
}
