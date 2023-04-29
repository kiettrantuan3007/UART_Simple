module UART_testbench();
	reg txclk, reset,tx_enable,ld_tx_data,rxclk,rx_enable;
	wire tx_out,tx_empty,rx_in,rx_empty;
	reg[7:0] tx_data;
	wire[7:0] rx_data;
	wire uld_rx_data;
	uart U1 (
		 .reset(reset), 
		 .txclk(txclk), 
		 .ld_tx_data(ld_tx_data), 
		 .tx_data(tx_data), 
		 .tx_enable(tx_enable), 
		 .tx_out(tx_out), 
		 .tx_empty(tx_empty), 
		 .rxclk(rxclk), 
		 .uld_rx_data(uld_rx_data), 
		 .rx_data(rx_data), 
		 .rx_enable(rx_enable), 
		 .rx_in(rx_in), 
		 .rx_empty(rx_empty)
		 );

	assign rx_in=tx_out;
	assign uld_rx_data=~rx_empty;

	always@(reset,tx_empty)
		begin
			if(reset) 
				tx_data=170;
		else if (tx_empty) 
			tx_data=tx_data+10;
		end

	initial 
	begin 
	txclk=0;
	forever #32 txclk=~txclk;
	end

	initial begin 
	rxclk=0;
	forever #2 rxclk=~rxclk;
	end

	initial begin
	reset=0;
	ld_tx_data=0;
	tx_enable=0;
	rx_enable=0;
	tx_data=170;
	#10;
	reset=1;
	#20;
	reset=0;

	#50;
	tx_enable=1;
	rx_enable=1;

	#50;
	ld_tx_data=1;
	#400;
	end
endmodule 