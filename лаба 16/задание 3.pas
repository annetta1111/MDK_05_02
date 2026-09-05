type
  nodeptr = ^node;
  node = record
    data: integer;
    next: nodeptr;
  end;

var
  head, tail, current: nodeptr;
  x, i: integer;
  minVal, maxVal: integer;

procedure add(var h, t: nodeptr; a: integer);
var
  newnode: nodeptr;
begin
  new(newnode);
  newnode^.data := a;
  newnode^.next := nil;
  
  if (h = nil) and (t = nil) then
  begin
    h := newnode;
    t := newnode;
  end
  else
  begin
    t^.next := newnode;
    t := newnode;
  end;
end;

procedure print(h: nodeptr);
begin
  write('список: ');
  while h <> nil do
  begin
    write(h^.data, ' ');
    h := h^.next;
  end;
  writeln;
end;

begin
  head := nil;
  tail := nil;
  
  writeln('введите 10 чисел:');
  for i := 1 to 10 do
  begin
    write('число ', i, ': ');
    readln(x);
    add(head, tail, x);
  end;
  
  writeln;
  print(head);
  writeln;
  
  if head <> nil then
  begin
    minVal := head^.data;
    maxVal := head^.data;
    
    current := head^.next;
    while current <> nil do
    begin
      if current^.data < minVal then
        minVal := current^.data;
      if current^.data > maxVal then
        maxVal := current^.data;
      current := current^.next;
    end;
    
    writeln('минимальный элемент: ', minVal);
    writeln('максимальный элемент: ', maxVal);
  end
  else
  begin
    writeln('список пуст!');
  end;
  
end.