//module serial_tb();
txrxserial _serial0 (
.pclk(pixel_clk);
.LED1(LED1),
.LED2(LED2),
.LED3(LED3),
.TXD(TXD),
.RXD(RXD),
.resetq(resetq)
)
)
initial
begin
a=0;
#10 a=1;
#10 a=0; #10 a=1;
end
initial
begin
	$dumpfile("serial.vcd");
	$dumpvars(0,serial_ins);
end
endmodule