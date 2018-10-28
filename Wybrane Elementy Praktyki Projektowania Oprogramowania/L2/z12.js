function evenNumbers (number) {  
  return number % 2 === 0;  
}  


var arr = []
for(var i=1; i<11; i++){
  arr.push(i)
}

arr = arr.filter(evenNumbers);
console.log(arr);
