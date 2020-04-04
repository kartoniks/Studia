/*
In the given example, a square is initialized with w=4 and h=5
which is not correct (w and h should be always equal).
So the given code doesn't satisfy the Liskov Substitution Principle.
Instead, let's introduce an interface which is extended by both square
and rectangle.
*/
public interface Figure {
    public getArea();
} 

public class Rectangle implements Figure {
    private int width;
    private int height;
    public int setHeight(int height) {
        this.height = height;
    }
    public getHeight() {
        return this.height;
    }
    public int setWidth(int width) {
        this.width = width;
    }
    public getWidth() {
        return this.width;
    }
    public getArea() {
        return this.height*this.width;
    }
}

public class Square implements Figure {
    private int width;
    private int height;
    public int setHeight(int height) {
        this.height = height;
        this.width = height;
    }
    public getHeight() {
        return this.height;
    }
    public int setWidth(int width) {
        this.width = width;
        this.height = width;
    }
    public getWidth() {
        return this.width;
    }
    public getArea() {
        return this.height*this.width;
    }
}

//now you can't set square width and height separately because you can't
//isntantiate the interface.