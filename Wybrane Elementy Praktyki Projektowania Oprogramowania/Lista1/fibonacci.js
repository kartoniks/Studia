function fib(n) {
    if(n==1)
        return 1;
    if(n==2)
        return 1;
    return fib(n-1) + fib(n-2);

}

function fibrek(n){
    x=1;
    y=1;
    while(n>1) {
        temp=y;
        y+=x;
        x=temp;
        n--;
    }
    return x;
}

testData=20;
console.time();
console.log(fib(testData));
console.timeEnd();
console.time();
console.log(fibrek(testData));
console.timeEnd();