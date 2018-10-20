function divisible() {
    arr = [];
    for(i = 1; i < 100000; i++) {
        num = i;
        divis = true;
        sum=0;
        while(num>0) {
            remainder = num % 10;
            sum += remainder;
            if(i/remainder != Math.floor(i/remainder) || remainder == 0) {
                divis = false;
            }
            num = Math.floor(num/10);
        }
        if(i/sum != Math.floor(i/sum)) {
            divis = false;
        }
        if(divis == true) {
            arr.push(i);
        }
    }
    return arr;
}

function primes() {
    prim = [];
    for(i = 2; i < 100000; i++) {
        divis = true;
        for(j = 2; j*j <i; j++) {
            if(i%j == 0) {
                divis = false;
                break;
            }
        }
        if(divis == true) {
            prim.push(i);
        }
    }
    return prim;
}


console.log(divisible());
