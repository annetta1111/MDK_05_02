var
  numbers: array[1..10] of integer;
  i: integer;
  flag: boolean;
begin
  writeln('введите 10 чисел:');
  
  for i := 1 to 10 do
  begin
    write('число ', i, ': ');
    readln(numbers[i]);
  end;
  
  writeln;
  writeln('весь список:');
  for i := 1 to 10 do
  begin
    write(numbers[i], ' ');
  end;
  
  writeln;
  writeln('четные элементы:');
  flag := false;
  for i := 1 to 10 do
  begin
    if numbers[i] mod 2 = 0 then
    begin
      write(numbers[i], ' ');
      flag := true;
    end;
  end;
  
  if not flag then
  begin
    writeln('нет четных элементов');
  end;
end.