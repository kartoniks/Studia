package main3;


public class Main3 {
    public static void main(String[] args) {
        testSamePlaneRelease();
        testInvalidPlaneError();
        testSizeReachedError();
    }

    static void testSamePlaneRelease() {
        System.out.println("Testing if planes are equal");
        Airport airport = new Airport(2);
        Plane plane1 = airport.AcquirePlane();
        try {
            airport.ReleasePlane(plane1);
            Plane plane2 = airport.AcquirePlane();
            System.out.println("Planes are equal: " +(plane1 == plane2));
        } catch (Exception e){
            System.out.println(e);
        }
        System.out.println();
    }
    static void testInvalidPlaneError() {
        System.out.println("Testing if different plane is invalid");
        Airport airport = new Airport(2);
        Plane plane = new Plane(42);
        try {
            airport.ReleasePlane(plane);
        } catch (Exception e){
            System.out.println(e);
        }
        System.out.println();
    }

    static void testSizeReachedError() {
        System.out.println("Testing if size limit is handled");
        Airport airport = new Airport(2);
        Plane plane1 = airport.AcquirePlane();
        Plane plane2 = airport.AcquirePlane();
        Plane plane3 = airport.AcquirePlane();
        try {
            airport.ReleasePlane(plane1);
            airport.ReleasePlane(plane2);
            airport.ReleasePlane(plane3);
        } catch(Exception e) {
            System.out.println(e);
        }
        System.out.println();
    }
}

