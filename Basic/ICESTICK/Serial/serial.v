`define VGA_36_MHZ
`define BIDIRECTIONAL
// Comment-out for monodirectional mode (saves 34 cells)
//   Bidirectional: 155 cells
// Monodirectional: 121 cells

// ---------------- Decoder 1 hex digit in ASCII -> 5 bits binary -----------
module decoder (
    input  [7:0] data,
    output [2:0] leds		
);
/*
   assign leds =
	   (data >= 8'h30 && data <= 8'h39) ? data - 8'h30 : 
	   (data >= 8'h61 && data <= 8'h66) ? data - 8'h61 + 8'd10 : 
           8'h00
           ;
*/
   assign leds = data[2:0];
endmodule   

module uartclock(
   input  wire pclk,
   output wire pixel_clk,
   output wire lock
);


`ifdef VGA_36_MHZ
  SB_PLL40_CORE #(
      .FEEDBACK_PATH("SIMPLE"),
	.DELAY_ADJUSTMENT_MODE_FEEDBACK("FIXED"),
	.DELAY_ADJUSTMENT_MODE_RELATIVE("FIXED"),
	.PLLOUT_SELECT("GENCLK"),
	.FDA_FEEDBACK(4'b1111),
	.FDA_RELATIVE(4'b1111),
      .DIVR(4'b0011),
      .DIVF(7'b0010110),
      .DIVQ(3'b100),
      .FILTER_RANGE(3'b010),
  ) pll (
      .REFERENCECLK(pclk),
      .PLLOUTCORE(pixel_clk),
      .LOCK(lock),
      .RESETB(1'b1),
      .BYPASS(1'b0)
  );
`endif


endmodule
// -------------------------- Main module -----------------------------------
module serial (
    input  pclk,
    output LED1,  LED2,  LED3,	
    //output led1, led2, led3, led4, led5,
    output TXD, 
    input  RXD,
    input  resetq	       
);

  wire uart0_valid;
  wire [7:0] uart0_data;
  reg  [7:0] data;
  
  decoder _decoder0(
     .data(data),
     .leds({ LED1,LED2,LED3})		     
  );
   
   
`ifdef BIDIRECTIONAL
  reg  uart0_wr;
  wire uart0_busy;
  buart _uart0 (
     .clk(pixel_clk),
     .resetq(1'b1),
     .rx(RXD),
     .tx(TXD),
     .rd(1'b1),
     .wr(uart0_wr),
     .valid(uart0_valid),
     .busy(uart0_busy),
     .tx_data(data),
     .rx_data(uart0_data)
  );
  
  always @(posedge pixel_clk ) begin
     if(uart0_valid) begin
        data <= uart0_data;
	uart0_wr <= 1; 
     end else begin
        uart0_wr <= 0; 
     end
  end
  
`else

  rxuart _uart0 (
     .clk(pixel_clk),
     .resetq(1'b1),
     .uart_rx(RXD),
     .rd(1'b1),
     .valid(uart0_valid),
     .data(uart0_data)
  );

  always @(posedge pixel_clk) begin
     if(uart0_valid) begin
        data <= uart0_data;
     end 
  end

`endif


 
endmodule

//  miniterm.py --dtr=0 /dev/ttyUSB1 115200
