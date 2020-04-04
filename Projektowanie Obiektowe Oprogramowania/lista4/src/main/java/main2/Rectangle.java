package main2;

public class Rectangle implements IShape{
    public double height;
    public double length;

    public Rectangle(double h, double l) {
        height = h;
        length = l;
    }

    public double area() {
        return height*length;
    }
}
