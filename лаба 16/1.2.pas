program prim;
var o: array of integer;
n: integer;
begin
  write('сколько элементов ');
  readln(n);
  
  setlength(o, n);//память массива
  
  write('массив: ');
  for var i := 0 to n - 1 do
    read(o[i]);
  
  writeln;
  write('результат: ');
  
  o[::-1].println(' '); //срез массива, который берет элементы в обратном порядке (все элементы с шагом -1 с конца)
end.