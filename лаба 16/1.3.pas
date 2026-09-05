program prim; //минимальный элемент в срезе и срез с четными  индексами 
begin
  var n := readinteger;
  var a := readarrinteger(n);
  var evenslice:= a[1::2]; //переменная для хранения полученного среза с начальным индексом 1 до конца массива с шагом 2
  
  print('срез:', evenslice);
  println('мин:', evenslice.min);
 end.