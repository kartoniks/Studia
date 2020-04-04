package main2;

import java.util.ArrayList;
import java.util.List;

public class ShapeFactory {

    private List<IShapeWorker> workers = new ArrayList<IShapeWorker>();

    public ShapeFactory() {
        workers.add(new SquareWorker());
    }

    public void RegisterWorker(IShapeWorker worker) {
        workers.add(worker);
    }

    public IShape CreateShape(String shapeName, Object... params) {
        for (IShapeWorker worker : workers) {
            if(worker.AcceptsName(shapeName)) {
                return worker.Create(params);
            }
        }

        return null;
    }
}

