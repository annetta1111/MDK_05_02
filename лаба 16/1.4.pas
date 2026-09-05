program prim;
begin
  var n := readinteger;
  var a := readarrinteger(n);
  
  var maxIndex := a.IndexMax;
  a := a[:maxIndex] + a[maxIndex+1:];
  
  println('результат:', a);
end.