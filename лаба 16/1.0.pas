program prim;
begin
   var a := arrrandominteger(10, -5, 20); //создает массив случайных чисел
  println('массив:', a); //выводит текст и массив на экран
  var l1 := new list<integer>;
  var l2 := new list<integer>;
  foreach var x in a do //цикл по каждому элементу массива
  begin
    if x > 0 then //на 2 списка положительные и отрицательные, без 0
      l1.add(x) 
    else if x < 0 then
      l2.add(x);
    end;
    print('L1:');
  l1.println;
  print('L2:');
  l2.println; //выводит содержимое списка 
end.