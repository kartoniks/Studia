public interface TaxCalculator {
    public Decimal CalculateTax( Decimal Price );
}

public class Item {
    private Decimal price;
    public Decimal getPrice() {
        return this.price;
    }
    private String name;
    public String getName() {
        return this.name;
    }
}

//instead of having a TaxCalculator class, let's have it as an interface, which whill allow
//us to have multiple implementations
//The tax calculator won't be given in the class, but as a parameter in the class constructor

public class VATTaxCalculator implements TaxCalculator {
    public Decimal CalculateTax( Decimal Price ){
        return Price * 0.23;
    }
}

public class LowerTaxCalculator implements TaxCalculator {
    public Decimal CalculateTax( Decimal Price ){
        return Price * 0.18;
    }
}

//similarly, you can add a comparator as an argument to the PrintBill method
//which will allow to print the bills in any way you want in the future,
//without specifying the implementation strictly.

public class CashRegister {
    TaxCalculator taxCalc;

    CashRegister(TaxCalculator taxCalculator) {
        this.taxCalc = taxCalculator;
    }

    public Decimal CalculatePrice( Item[] Items ) {
        Decimal _price = 0;
        for ( Item item : Items ) {
            _price +=  this.taxCalc.CalculateTax( item.Price );
        }
        return _price;
    }

    public String PrintBill( Item[] items, Comparator<Item> comparator ) {
        Collections.sort(items, comparator);
        for ( var item : items )
            System.out.println( "towar {0} : cena {1} + podatek {2}",
            item.Name, item.Price, this.taxCalc.CalculateTax( item.Price ) );
    }
}