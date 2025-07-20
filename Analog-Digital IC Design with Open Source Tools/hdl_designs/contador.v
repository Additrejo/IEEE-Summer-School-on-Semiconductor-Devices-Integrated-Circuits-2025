module counter #(parameter bits=4)(
	input clk,
	input rst,
	input select, //0=up counter,1=down counter
	output reg [bits-1:0] count); 

	
always@ (posedge clk)
	begin 
		if (rst==1) begin
			count <= 0;			
		end	
	else begin
		case (select)
			1'b0: count <= count + 1; 
			default: count <= count - 1;
			endcase
		end
		
	end
endmodule	