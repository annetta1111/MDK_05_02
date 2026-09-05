program prim;
begin
  var n := readinteger ('введите n: ');
  var a := readarrinteger(n);
  var minIndex := a.IndexMin; //индекс минимального элемента 
  a := a[:minIndex] + Arr(n) + a[minIndex:]; //левая часть среза массива и вставляем элемент из массива и правая часть 
   Println('результат:', a);
end.