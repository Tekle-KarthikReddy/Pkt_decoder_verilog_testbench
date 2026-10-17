module pkt_decoder_tb;
parameter WIDTH=8,WIDTH1=2,DEPTH=16;
reg clk,reset;
reg [WIDTH-1:0] data_in;
reg valid_in;
wire valid_out;
wire [WIDTH1-1:0] valid_port;
wire [WIDTH-1:0] aa ;
wire [WIDTH-1:0] bb ;
wire [WIDTH-1:0] cc ;
wire [WIDTH-1:0] dd ;
reg [WIDTH-1:0]out;


pkt_decoder dut(.clk(clk), .reset(reset), .data_in(data_in), .valid_in(valid_in), .valid_out(valid_out), .valid_port(valid_port), .aa(aa), .bb(bb), .cc(cc), .dd(dd));

always #5 clk=~clk;

task rst;
        begin
                reset=1;
                data_in=0;
                valid_in=0;
                #15;
                reset=0;

        end
endtask

task crc_cal;
        input [WIDTH-1:0] in;
        output [WIDTH-1:0] out;
        begin
                out=0;
                out=out^in;

        end
endtask


task valid_crc;
        begin
                valid_in=1;
                data_in=8'hAA;
                #10;
                data_in=8'h04;
                #10;
                data_in=8'h11;
                crc_cal(8'h11,out);
                #10;
                data_in=8'h22;
                crc_cal(8'h22,out);
                #10;
                data_in=8'h33;
                crc_cal(8'h33,out);
                #10;
                data_in=8'h44;
                crc_cal(8'h44,out);
                #10;
                data_in=out;
                #30;
                valid_in=0;
                #10;
                $display("destination=%0h payload_len=%0h payload_count=%0h  crc=%0h",dut.destination_addr, dut.payload_len,dut.payload_count,dut.recieved_crc);
                if(valid_out)
                        $display( "aa=%0h bb=%0h cc=%0h dd=%0h",aa,bb,cc,dd);

        end
endtask

task invalid_crc;
        begin
                valid_in=1;
                data_in=8'hBB;
                #10;
                data_in=8'h04;
                #10;
                data_in=8'h11;
                crc_cal(8'h11,out);
                #10;
                data_in=8'h22;
                crc_cal(8'h22,out);
                #10;
                data_in=8'h33;
                crc_cal(8'h33,out);
                #10;
                data_in=8'h44;
                crc_cal(8'h44,out);
                #10;
                data_in=8'h34;
                #30;
                valid_in=0;
                #10;
                if(valid_out)
                        $display( "aa=%0h bb=%0h cc=%0h dd=%0h",aa,bb,cc,dd);

        end
endtask

task diff_dest;
        begin
                valid_in=1;
                data_in=8'hCC;
                #10;
                data_in=8'h04;
                #10;
                data_in=8'h11;
                crc_cal(8'h11,out);
                #10;
                data_in=8'h22;
                crc_cal(8'h22,out);
                #10;
                data_in=8'h33;
                crc_cal(8'h33,out);
                #10;
                data_in=8'h44;
                crc_cal(8'h44,out);
                #10;
                data_in=out;
                #30;
                valid_in=0;
                #10;
                if(valid_out)
                        $display( "aa=%0h bb=%0h cc=%0h dd=%0h",aa,bb,cc,dd);

        end
endtask

task zero_payload_len;
        begin
                valid_in=1;
                data_in=8'hCC;
                #10;
                data_in=8'h00;
                #10;
                data_in=8'h11;
                crc_cal(8'h11,out);
                #10;
                data_in=8'h22;
                crc_cal(8'h22,out);
                #10;
                data_in=8'h33;
                crc_cal(8'h33,out);
                #10;
                data_in=8'h44;
                crc_cal(8'h44,out);
                #10;
                data_in=out;
                #30;
                valid_in=0;
                #10;
                if(valid_out)
                        $display( "aa=%0h bb=%0h cc=%0h dd=%0h",aa,bb,cc,dd);

        end
endtask

initial begin
        clk=0;
        rst();
        valid_crc();
        rst();
        invalid_crc();
        rst();
        diff_dest();
        rst();
        zero_payload_len();
        #100;
        $finish;
end
endmodule
