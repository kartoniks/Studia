import java.util.Hashtable;

public class Wezel {
    Hashtable Hashe;
    char symbol = ' ';
    int val;
    Wezel lsyn;
    Wezel psyn;
    Wezel(char s, Wezel l, Wezel p) {
        lsyn=l;
        psyn=p;
        symbol=s;
    }
    Wezel(int v)
    {
        val=v;
    }
    Wezel(char s)
    {
        symbol=s;
    }
    int oblicz() //da się jakoś ładniej?
    {
        if(Hashe!=null) {
            if(psyn!=null)
                psyn.Hashe = this.Hashe;
            if(lsyn!=null)
                lsyn.Hashe = this.Hashe;
        }
        if(symbol=='+')
            return lsyn.oblicz()+psyn.oblicz();
        if(symbol=='-')
            return lsyn.oblicz()-psyn.oblicz();
        if(symbol=='*')
            return lsyn.oblicz()*psyn.oblicz();
        if(symbol=='/')
            return lsyn.oblicz()/psyn.oblicz();
        if(symbol!=' ')
            return (int)Hashe.get(symbol);
        return val;
    }
    public String toString()
    {
        if(symbol=='+')
            return "("+lsyn.toString()+"+"+psyn.toString()+")";
        if(symbol=='-')
            return "("+lsyn.toString()+"-"+psyn.toString()+")";
        if(symbol=='*')
            return "("+lsyn.toString()+"*"+psyn.toString()+")";
        if(symbol=='/')
            return "("+lsyn.toString()+"/"+psyn.toString()+")";
        if(symbol!=' ')//zmienna
            return Character.toString(symbol);
        return Integer.toString(val);
    }
    Wezel pochodna()//przyjmuje mnożenie i dodawanie
    {
        if(symbol=='+')
            return new Wezel('+', lsyn.pochodna(), psyn.pochodna());
        if(symbol=='-')
            return new Wezel('+', lsyn.pochodna(), psyn.pochodna());
        if(symbol=='*')//(fg)'=fg'+f'g
            return new Wezel('+', new Wezel('*', lsyn.pochodna(), psyn), new Wezel('*', lsyn, psyn.pochodna()));
        if(symbol=='/')//(f/g)'=(f'g-fg')/g^2
            return new Wezel('-', new Wezel('*', lsyn.pochodna(), psyn), new Wezel('*', lsyn, psyn.pochodna()));
        if(symbol!=' ')//x'=1
            return new Wezel(1);
        return new Wezel(0);//C'=0
    }

}
