module float_add(
    input logic [31:0]a,
    input logic [31:0]b,
    output logic [31:0]sum
    );
    
    logic sgn_a, sgn_b;
    logic[7:0]exp_a,exp_b;
    logic[23:0]mant_a,mant_b;
    logic[7:0]exp_diff;
    logic out_sgn;
    logic [7:0]out_exp;
    logic[23:0]out_mant;

assign sgn_a = a[31];
assign sgn_b = b[31];
assign exp_a = a[30:23];
assign exp_b = b[30:23];


always_comb begin
// padding the one hidden bit 
    mant_a = {1'b1, a[22:0]};
    mant_b = {1'b1, b[22:0]};

// aligning the mantessa according to the difference between the exponents 
    case({exp_a,exp_b})
        exp_a < exp_b : begin
            out_exp = exp_b;
            exp_diff = exp_b - exp_a;
            mant_a = a[22:0] >> exp_diff;
        end
        exp_a > exp_b : begin 
            out_exp = exp_a;
            exp_diff = exp_a - exp_b;
            mant_b = b[22:0] >> exp_diff;
        end
    endcase

    case({sgn_a, sgn_b})
        2'b11:  begin
            out_sgn = 1;
            out_mant = mant_a + mant_b;
        end
        2'b00 : begin
            out_sgn = 0;
            out_mant = mant_a + mant_b ;
        end
        2'b10 : begin
            if(mant_a < mant_b) begin
                out_sgn = sgn_b;
                out_mant = mant_b - mant_a;
            end else begin
                out_sgn = sgn_a;
                out_mant = mant_a - mant_b;
            end
            end
        2'b01 : begin
            if(mant_b < mant_a) begin
                out_sgn = sgn_a;
                out_mant = mant_a - mant_b;
            end else begin
                out_sgn = sgn_b;
                out_mant = mant_b - mant_a;
            end
        end
    endcase

// normalization of the output after addition 
/*
      if(out_mant[23])begin 
        out_mant = out_mant >> 1;
        out_exp = out_exp + 1;
    end 
*/  
end 

assign sum[31] = out_sgn;
assign sum[30:23] = out_exp;
assign sum[22:0] = out_mant[22:0];

  
endmodule
