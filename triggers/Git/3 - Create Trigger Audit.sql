create trigger Auditoria on TablaX after insert,update,delete as
begin	
	declare @usuario varchar(20), @tabla varchar(10), @fecha datetime, @accion char(1), @filas int, @ins int, @del int;
	set @tabla = 'TablaX';
	select @fecha = getdate()
	select @ins = count(*) from inserted
	select @del = count(*) from deleted
	if (@ins = @del) 
	begin
		set @accion = 'U'
		set @filas = @ins
	end
	if (@ins > @del)
	begin
		set @accion = 'I'
		set @filas = @ins
	end
	if (@ins < @del)
	begin 
		set @accion = 'D'
		set @filas = @del
	end
	insert into audit (usuario, tabla, fecha, accion, filas_afectadas)
	values (SYSTEM_USER, @tabla, @fecha, @accion, @filas)
end
