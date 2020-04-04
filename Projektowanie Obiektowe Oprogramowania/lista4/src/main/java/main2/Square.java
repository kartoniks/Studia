package main2;

public class Square implements IShape {
    public double height;
    public double length;

    public Square(double h) {
        height = h;
        length = h;
    }

    public double area() {
        return height*height;
    }
}
