program dva; //макс элемент и удаляет его
begin
  var n := readinteger('Количество элементов:'); //ввод кол-ва и самих чисел
  var a := readarrinteger(n);
  var l := new list<integer>(a); //создание списка
  println('список:', l);

  var maxIndex := l.IndexMax; //поиск максимального 
  l.removeat(maxIndex);
  
  print('результат:');
  l.println; //выводит список
end.