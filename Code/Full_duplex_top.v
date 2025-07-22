`include "Duplex.v"

module full_duplex(input   wire         reset_n,       //  Active low reset.
    		   input   wire         send,          //  An enable to start sending data.
    		   input   wire         clock,         //  The main system's clock.
    		   input   wire  [1:0]  parity_type,   //  Parity type agreed upon by the Tx and Rx units.
    		   input   wire  [1:0]  baud_rate,     //  Baud Rate agreed upon by the Tx and Rx units.
    		   input   wire  [7:0]  data_in,       //  The data input.

    		   output  wire         tx_active_flag, //  outputs logic 1 when data is in progress.
    		   output  wire         tx_done_flag,   //  Outputs logic 1 when data is transmitted
    		   output  wire         rx_active_flag, //  outputs logic 1 when data is in progress.
    		   output  wire         rx_done_flag,   //  Outputs logic 1 when data is recieved
    		   output  wire  [7:0]  data_out,       //  The 8-bits data separated from the frame.
    		   output  wire  [2:0]  error_flag
    		   //  Consits of three bits, each bit is a flag for an error
    		   //  error_flag[0] ParityError flag, error_flag[1] StartError flag,
    		   //  error_flag[2] StopError flag.
);


wire tx_active_flag_loop, tx_done_flag_loop, rx_active_flag_loop, rx_done_flag_loop;
wire [7:0] data_out_loop;
wire [2:0] error_flag_loop;
// First Duplex
Duplex first_duplex(.reset_n(reset_n),
		.send(send),
		.clock(clock),
		.parity_type(parity_type),
		.baud_rate(baud_rate),
		.data_in(data_in),

		.tx_active_flag(),
		.tx_done_flag(),
		.rx_active_flag(),
		.rx_done_flag(),
		.data_out(data_out_loop),
		.error_flag()
	);

// Second Duplex
Duplex Second_duplex(.reset_n(reset_n),
		.send(send),
		.clock(clock),
		.parity_type(parity_type),
		.baud_rate(baud_rate),
		.data_in(data_out_loop),

		.tx_active_flag(tx_active_flag),
		.tx_done_flag(tx_done_flag),
		.rx_active_flag(rx_active_flag),
		.rx_done_flag(rx_done_flag),
		.data_out(data_out),
		.error_flag(error_flag)
	);

endmodule
