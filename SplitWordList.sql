/* CREDIT: https://stackoverflow.com/questions/2647/how-do-i-split-a-string-so-i-can-access-item-x/2681#2681 */
CREATE function [SplitWordList]
(
 @list varchar(8000)
)
returns @t table 
(
  Word varchar(50) not null,
  Position int identity(1,1) not null
)
as begin
  declare 
    @pos int,
    @lpos int,
    @item varchar(100),
    @ignore varchar(100),
    @dl int,
    @a1 int,
    @a2 int,
    @z1 int,
    @z2 int,
    @n1 int,
    @n2 int,
    @c varchar(1),
    @a smallint
  select
    @a1 = ascii('a'),
    @a2 = ascii('A'),
    @z1 = ascii('z'),
    @z2 = ascii('Z'),
    @n1 = ascii('0'),
    @n2 = ascii('9')
  set @ignore = '''"'
  set @pos = 1
  set @dl = datalength(@list)
  set @lpos = 1
  set @item = ''
  while (@pos <= @dl) begin
    set @c = substring(@list, @pos, 1)
    if (@ignore not like '%' + @c + '%') begin
      set @a = ascii(@c)
      if ((@a >= @a1) and (@a <= @z1))
        or ((@a >= @a2) and (@a <= @z2))
        or ((@a >= @n1) and (@a <= @n2))
      begin
        set @item = @item + @c
      end else if (@item > '') begin
        insert into @t
        values
          (@item)
        set @item = ''
      end
    end
    set @pos = @pos + 1
  end
  if (@item > '') begin
    insert into @t
    values
      (@item)
  end
  return
end
