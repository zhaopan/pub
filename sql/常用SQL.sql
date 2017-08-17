declare @val nvarchar(200)
declare my_cursor cursor local static read_only forward_only for 
select order_num from transportquarantinecert
open my_cursor
fetch from my_cursor into @val
while @@fetch_status = 0
	begin

		fetch from my_cursor into @val
	end
close my_cursor
deallocate my_cursor