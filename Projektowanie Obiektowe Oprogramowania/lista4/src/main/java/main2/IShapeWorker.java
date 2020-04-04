package main2;

public interface IShapeWorker {
    boolean AcceptsName(String name);

    IShape Create(Object... params);
}
