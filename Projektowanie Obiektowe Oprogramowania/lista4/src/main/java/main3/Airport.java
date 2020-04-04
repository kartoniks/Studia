package main3;

import com.sun.javaws.exceptions.InvalidArgumentException;

import javax.naming.SizeLimitExceededException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Airport {

    List<Plane> ready = new ArrayList<Plane>();
    List<Plane> released = new ArrayList<Plane>();
    int maxSize;

    public Airport(int size) {
        maxSize = size;
    }

    public Plane AcquirePlane() {
        if(ready.isEmpty()) {
            Plane newPlane = new Plane(new Random().nextInt());
            ready.add(newPlane);
        }

        Plane plane = ready.get(0);
        ready.remove(plane);
        released.add(plane);

        return plane;
    }

    public void ReleasePlane(Plane plane) throws InvalidArgumentException, SizeLimitExceededException{
        if(!released.contains(plane)) {
            String[] args = {plane.toString()};
            throw new InvalidArgumentException(args);
        }
        if(ready.size()== maxSize) {
            throw new SizeLimitExceededException("size limit reached of: " + maxSize +" in collection "+ready.toString());
        }
        released.remove(plane);
        ready.add(plane);
    }
}
