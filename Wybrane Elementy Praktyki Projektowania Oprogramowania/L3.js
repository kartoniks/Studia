//zad.1
var foo = {
    _i : 0,
    fun : function  func(params) {
        return "funkcja tez dziala";
    },
    get bar() {
        return foo._i;
    },
    set bar(i) {
        foo._i = i;
    }
}    
foo.baz = 42;
foo.fun2 = function(args) {
    return "dodana funkcja";
}
Object.defineProperty(foo, 'getbaz', {
    get: function() {
        return foo.baz;
    }
})
//console.log(foo.getbaz)
//czym się różni pole od właściwośći? w tym drugim musi być getter i setter?
//chyba bez defineProperty nie da się wstawić gettera? można wszystko
// console.log(foo.getbaz);
// foo.bar = 5;
// console.log(foo.bar);

//zad.2
function fib(n) {
    if(typeof arr === 'undefined') {
        var arr = [1,1];
    }
    function fibcount(k){
        if(typeof arr[k] === 'undefined') {
            arr[k] = fibcount(k-1) + fibcount(k-2);
        }
        return arr[k];
    };
    //console.log(arr[10]);
    return fibcount(n);
}
//console.log(fib(10));
// console.log(fib(200));

//zad.3
function myFor(arr, f) {
    for(i in arr) {
        f(arr[i]);
    }
}
//myFor([1,2,3], x => console.log(x*x));

function myMap(arr,f) {
    for(i in arr) {
        arr[i] = f(arr[i]);
    }
    return arr;
}
//console.log(myMap(["a", "r", "t"], s => s+"$"));

function myFilter(arr, f) {
    var newarr = [];
    for(i in arr) {
        if(f(arr[i])) {
            newarr.push(arr[i]);
        }
    }
    return newarr;
}
//console.log(myFilter([2,6,3,123,25,1], x => x>10));

//zad.4
// za SO: var is scoped to the nearest function block and 
//let is scoped to the nearest enclosing block, which can be smaller than a function block
function createFs(n) { // tworzy tablicę n funkcji
    var fs = []; // i-ta funkcja z tablicy ma zwrócić i
    for (let i=0; i<n; i++ ) {
        fs[i] =
            function() {
                return i;
            };
    };
    return fs;
};
//var myfs = createVars(10);
// console.log( myfs[0]() ); // zerowa funkcja miała zwrócić 0
// console.log( myfs[2]() ); // druga miała zwrócić 2
// console.log( myfs[7]() );

function createVars(n) {
    // tworzy tablicę n funkcji
    var fs = []; // i-ta funkcja z tablicy ma zwrócić i

    var _loop = function _loop(i) {
        fs[i] = function () {
            return i;
        };
    };

    for (var i = 0; i < n; i++) {
        _loop(i);
    };
    return fs;
};
var _vars = createVars(10);
// console.log( _vars[0]() ); // zerowa funkcja miała zwrócić 0
// console.log( _vars[2]() ); // druga miała zwrócić 2
// console.log( _vars[7]() );

//zad.5
function suma() {
    var sum = 0;
    for (var i = 0; i < arguments.length; i++) {
        sum +=arguments[i];
    }
    //console.log(arguments);
    return sum;
}
//console.log(suma(1,2,3,4,5));

//zad.6
function mygen(nd) {
    return function createGenerator() {
        var _state = 0;
        return {
            next : function() {
                return {
                    value : _state,
                    done : _state++ >= nd
                }
            }
        }
    }
}

// var foo = {
//     [Symbol.iterator] : mygen(5)
// };
// for ( var f of foo )
//     console.log(f);


//zad.7
function fib() {
    var _state = [1,1]
    return {
        next : function() {
            
            return {
                value : _state[1],
                done  : (_state = [_state[1], _state[0]+_state[1]]) === 0
            }
        }
    }
}

// var _it = fib();
// for ( var _result; _result = _it.next(), !_result.done; ) {
//     if(_result.value < 1000)
//         console.log( _result.value );
// }

function *fib2() {
    _sta = [1,1];
    while(true){
        _sta = [_sta[1], _sta[0]+_sta[1]];
        yield _sta[1];
    } 
}

// var _it = fib2();
// for ( var _result; _result = _it.next(), !_result.done; ) {
//     console.log( _result.value );
// }
// for ( var i of fib2() ) {
//     console.log( i );
// }    

//zad.8
function* take(it, top) {
    for(var i of it) {
        if(top-- > 0)
            yield i
        else
            break;
    }
}
// zwróć dokładnie 10 wartości z potencjalnie
// "nieskończonego" iteratora/generatora
// for (let num of take( fib2(), 10 ) ) {
//     console.log(num);
// }