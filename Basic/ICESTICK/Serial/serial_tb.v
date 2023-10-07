module serial_tb();
    wire  pclk;
    wire led1, led2, led3, led4, led5;
    wire TXD; 
    reg  RXD;
    reg  resetq;
testserial serial0 (
.pclk(pclk),
.led1(led1),
.led2(led2),
.led3(led3),
.led3(led4),
.led3(led5),
.TXD(TXD),
.RXD(RXD),
.resetq(resetq)
);


 
initial
begin
	$dumpfile("serial.vcd");
	$dumpvars(0,serial_ins);
end
endmodule