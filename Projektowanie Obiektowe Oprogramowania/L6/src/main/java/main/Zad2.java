package main;


import java.util.HashMap;
import java.util.Map;

public class Zad2 {

    public Zad2() {
        Context ctx = new Context();
        ctx.set("x", false);
        ctx.set("y", true);
        Expression exp = new BinaryExpression(
                "and",
                new NegationExpression(
                        new ConstExpression("x")),
                new ConstExpression("y"));

        System.out.println("Expression is: "+exp.Interpret(ctx));
    }

    public interface Expression {
        Boolean Interpret(Context context);
    };

    public class BinaryExpression implements Expression {
        public Expression left;
        public Expression right;
        public String type;

        public BinaryExpression( String type, Expression l, Expression r) {
            this.left = l;
            this.right = r;
            this.type = type;
        }
        public Boolean Interpret(Context context){
            if(type.equals("or"))
                return left.Interpret(context) || right.Interpret(context);
            if(type.equals("and"))
                return left.Interpret(context) && right.Interpret(context);
            return false;
        }
    }

    public class ConstExpression implements Expression {
        public String variable;

        public ConstExpression(String var) {
            this.variable = var;
        }

        public Boolean Interpret(Context context) {
            return context.get(variable);
        }
    }

    public class NegationExpression implements Expression {
        public Expression innerExp;

        public NegationExpression(Expression exp) {
            this.innerExp = exp;
        }

        public Boolean Interpret(Context context) {
            return !innerExp.Interpret(context);
        }
    }

    public class Context {
        Map<String, Boolean> variables;

        public Context() {
            this.variables = new HashMap<>();
        }

        public Boolean get(String variable) {
            return variables.get(variable);
        }
        public void set(String variable, Boolean value){
            variables.put(variable, value);
        }
    }
}



