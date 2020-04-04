package main1;



public class Zad1 {
    /**
     * Singleton implementation
     */
    public int id;
    private static Zad1 instance = new Zad1();
    public Zad1 getInstance() {
        return instance;
    }
    public String debug() {
        return "ID is: "+ id;
    }


    private static ThreadLocal<Zad1> _threadLocal =
        new ThreadLocal<Zad1>() {
        @Override
            protected Zad1 initialValue() {
                return new Zad1();
            }
        };
    /**
     * Returns the thread local singleton instance
     */
    public static Zad1 getThreadInstance() {
        return _threadLocal.get();
    }


    /**
     * Returns a new instance after five seconds have passed
     */
    public static long startMillis = System.currentTimeMillis();
    private static Zad1 timedInstance = new Zad1();

    public static Zad1 getTimedInstance() {
        long currentMillis = System.currentTimeMillis();
        if(currentMillis>startMillis+1000) {
            startMillis = System.currentTimeMillis();
            timedInstance = new Zad1();
        }
        return timedInstance;
    }
}
