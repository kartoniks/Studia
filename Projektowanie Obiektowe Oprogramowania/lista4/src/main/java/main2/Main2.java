package main2;


public class Main2 {
    public static void main(String[] args) {
        factoryTest();
    }

    static void factoryTest(){
        // klient
        ShapeFactory factory = new ShapeFactory();
        IShape square = factory.CreateShape("Square", 5);
        // rozszerzenie
        factory.RegisterWorker(new RectangleWorker());
        IShape rect=factory.CreateShape("Rectangle",3,5);

        testSquareArea(square.area(), 25);
        testRectArea(rect.area(), 15);
    }

    static void testSquareArea(double actual, double expected){
        if(actual == expected)
            System.out.println("Area is as expected, "+actual);
        else
            System.out.println("Square area should be:"+expected+" , actually is:"+actual);
    }
    static void testRectArea(double actual, double expected){
        if(actual == expected)
            System.out.println("Area is as expected, "+actual);
        else
            System.out.println("Rectangle area should be:"+expected+" , actually is:"+actual);
    }
}

