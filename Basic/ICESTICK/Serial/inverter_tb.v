module inverter_tb();
reg a; wire YINV;
inverter inverter_ins (a, YINV);
initial
begin
a=0;
#10 a=1;
#10 a=0; #10 a=1;
end
initial
begin
	$dumpfile("inverter.vcd");
	$dumpvars(0,inverter_ins);
end
endmodule