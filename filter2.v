module filter2(input wire clk,output reg [8:0]yr); //main module
  reg [29:0] delay1;

  wire [8:0]y0r,y1r,y2r,y3r,y4r,y5r,y6r,y7r,y0i,y1i,y2i,y3i,y4i,y5i,y6i,y7i;
  wire [8:0]x20r,x20i,x21r,x21i,x22r,x22i,x23r,x23i,x24r,x24i,x25r,x25i,x26r,x26i,x27r,x27i;
  wire [8:0]x10r,x10i,x11r,x11i,x12r,x12i,x13r,x13i,x14r,x14i,x15r,x15i,x16r,x16i,x17r,x17i;
  wire [8:0]x0,x1,x2,x3,x4,x5,x6,x7,x0i,x1i,x2i,x3i,x4i,x5i,x6i,x7i;
  wire [8:0]dy2r,dy2i,dy3r,dy3i,dy4r,dy4i,dy5r,dy5i;
//ifft
  wire [8:0]s0r,s0i,s1r,s1i,s2r,s2i,s3r,s3i,s4r,s4i,s5r,s5i,s6r,s6i,s7r,s7i; 
  wire [8:0]yi0r,yi1r,yi2r,yi3r,yi4r,yi5r,yi6r,yi7r,yi0i,yi1i,yi2i,yi3i,yi4i,yi5i,yi6i,yi7i;
  wire [8:0]xi20r,xi20i,xi21r,xi21i,xi22r,xi22i,xi23r,xi23i,xi24r,xi24i,xi25r,xi25i,xi26r,xi26i,xi27r,xi27i;  
  wire [8:0]xi10r,xi10i,xi11r,xi11i,xi12r,xi12i,xi13r,xi13i,xi14r,xi14i,xi15r,xi15i,xi16r,xi16i,xi17r,xi17i;
  

parameter w0r=9'b1;
parameter w0i=9'b0;
parameter w1r=9'b010110101;
parameter w1i=9'b101001011;
parameter w1i_ifft=9'b010110101;
parameter w2r=9'b0;
parameter w2i=9'b111111111;
parameter w2i_ifft=9'b1;
parameter w3r=9'b101001011;
parameter w3i=9'b101001011;
parameter w3i_ifft=9'b010110101;

assign x0=15;
assign x1=9;
assign x2=19;
assign x3=-15;
assign x4=0;//16 
assign x5=-30;//32 
assign x6=9;//64 
assign x7=-9;//128 
assign x0i=9'b0;
assign x1i=9'b0;
assign x2i=9'b0;
assign x3i=9'b0;
assign x4i=9'b0;//16 
assign x5i=9'b0;//32 
assign x6i=9'b0;//64 
assign x7i=9'b0;//128 
/*
assign x0=9'b000001100;//12
assign x1=9'b000010000;//16
assign x2=9'b000001001;//9
assign x3=9'b111111101;//-3
assign x4=9'b111110010;//-14
assign x5=9'b111110001;//-15
assign x6=9'b111111010;//-6
assign x7=9'b000000110;//6 
*/

//stage1
bfly2_4 s11(x0,x0i,x4,x4i,w0r,w0i,x10r,x10i,x11r,x11i);
bfly2_4 s12(x2,x2i,x6,x6i,w0r,w0i,x12r,x12i,x13r,x13i);
bfly2_4 s13(x1,x1i,x5,x5i,w0r,w0i,x14r,x14i,x15r,x15i);  
bfly2_4 s14(x3,x3i,x7,x7i,w0r,w0i,x16r,x16i,x17r,x17i);
//stage2
bfly2_4 s21(x10r,x10i,x12r,x12i,w0r,w0i,x20r,x20i,x22r,x22i);
bfly2_4 s22(x11r,x11i,x13r,x13i,w2r,w2i,x21r,x21i,x23r,x23i);
bfly2_4 s23(x14r,x14i,x16r,x16i,w0r,w0i,x24r,x24i,x26r,x26i);
bfly2_4 s24(x15r,x15i,x17r,x17i,w2r,w2i,x25r,x25i,x27r,x27i);

//stage3
bfly2_4 s31(x20r,x20i,x24r,x24i,w0r,w0i,y0r,y0i,y4r,y4i);
bfly4_4 s32(x21r,x21i,x25r,x25i,w1r,w1i,y1r,y1i,y5r,y5i);
bfly2_4 s33(x22r,x22i,x26r,x26i,w2r,w2i,y2r,y2i,y6r,y6i);
bfly4_4 s34(x23r,x23i,x27r,x27i,w3r,w3i,y3r,y3i,y7r,y7i);

assign dy2r=0;
assign dy2i=0;
assign dy3r=0;
assign dy3i=0;
assign dy4r=0;
assign dy4i=0;
assign dy5r=0;
assign dy5i=0;

//ifft
//stage1
bfly2_4 si11(y0r,y0i,dy4r,dy4i,w0r,w0i,xi10r,xi10i,xi11r,xi11i);
bfly2_4 si12(dy2r,dy2i,y6r,y6i,w0r,w0i,xi12r,xi12i,xi13r,xi13i);
bfly2_4 si13(y1r,y1i,dy5r,dy5i,w0r,w0i,xi14r,xi14i,xi15r,xi15i);  
bfly2_4 si14(dy3r,dy3i,y7r,y7i,w0r,w0i,xi16r,xi16i,xi17r,xi17i);

//stage2
bfly2_4 si21(xi10r,xi10i,xi12r,xi12i,w0r,w0i,xi20r,xi20i,xi22r,xi22i);
bfly2_4 si22(xi11r,xi11i,xi13r,xi13i,w2r,w2i_ifft,xi21r,xi21i,xi23r,xi23i);
bfly2_4 si23(xi14r,xi14i,xi16r,xi16i,w0r,w0i,xi24r,xi24i,xi26r,xi26i);
bfly2_4 si24(xi15r,xi15i,xi17r,xi17i,w2r,w2i_ifft,xi25r,xi25i,xi27r,xi27i);

//stage3
bfly2_4 si31(xi20r,xi20i,xi24r,xi24i,w0r,w0i,yi0r,yi0i,yi4r,yi4i);
bfly4_4 si32(xi21r,xi21i,xi25r,xi25i,w1r,w1i_ifft,yi1r,yi1i,yi5r,yi5i);
bfly2_4 si33(xi22r,xi22i,xi26r,xi26i,w2r,w2i_ifft,yi2r,yi2i,yi6r,yi6i);
bfly4_4 si34(xi23r,xi23i,xi27r,xi27i,w3r,w3i_ifft,yi3r,yi3i,yi7r,yi7i);

/*assign s0r=yi0r/w;
assign s0i=yi0i/w;
assign s1r=yi1r/w;
assign s1i=yi1i/w;
assign s2r=yi2r/w;
assign s2i=yi2i/w;
assign s3r=yi3r/w;
assign s3i=yi3i/w;
assign s4r=yi4r/w;
assign s4i=yi4i/w;
assign s5r=yi5r/w;
assign s5i=yi5i/w;
assign s6r=yi6r/w;
assign s6i=yi6i/w;
assign s7r=yi7r/w;
assign s7i=yi7i/w;

always@(posedge clk)
case(sel)
  0:begin yr=s0r; yi=s0i; end
  1:begin yr=s1r; yi=s1i; end
  2:begin yr=s2r; yi=s2i; end
  3:begin yr=s3r; yi=s3i; end
  4:begin yr=s4r; yi=s4i; end
  5:begin yr=s5r; yi=s5i; end
  6:begin yr=s6r; yi=s6i; end
  7:begin yr=s7r; yi=s7i; end
endcase
*/

/*always@(posedge clk)
case(sel)
  0:begin yr=yi0r; yi=yi0i; end
  1:begin yr=yi1r; yi=yi1i; end
  2:begin yr=yi2r; yi=yi2i; end
  3:begin yr=yi3r; yi=yi3i; end
  4:begin yr=yi4r; yi=yi4i; end
  5:begin yr=yi5r; yi=yi5i; end
  6:begin yr=yi6r; yi=yi6i; end
  7:begin yr=yi7r; yi=yi7i; end
endcase*/

always@ (posedge clk)
begin
delay1 <= delay1+1;
case(delay1)
       //(27'b00000011110100001001000000): yr = yi0r;
       (30'b000101111101011110000100000000):yr <= yi0r;
       (30'b001011111010111100001000000000):yr <= yi1r;
       (30'b010001111000011010001100000000):yr <= yi2r;
       (30'b010111110101111000010000000000):yr <= yi3r;
       (30'b011101110011010110010100000000):yr <= yi4r;
       (30'b100011110000110100011000000000):yr <= yi5r;
       (30'b101001101110010010011100000000):yr <= yi6r;
       (30'b101111101011110000100000000000):yr <= yi7r;
       //(29'b0010111110101111000010000000):yr = yi4r;
       //(29'b0011100100111000011100000000):yr = yi5r;
       //(29'b0100001011000001110110000000):yr = yi6r;
       //(29'b0100110001001011010000000000):yr = yi7r;
       //(27'b00000111101000010010000000): yr = yi1r;
       //(27'b00001011011100011011000000): yr = yi2r;
       //(27'b00001111010000100100000000): yr = yi3r;
       //(27'b00010011000100101101000000): yr = yi4r;
       //(27'b00010110111000110110000000): yr = yi5r;
       //(27'b00011010101100111111000000): yr = yi6r;
       //(27'b00011110100001001000000000): yr = yi7r;
       
endcase
//if (delay>29'b10001111000011010001100000000);
//begin
//delay<=0;
//end
end

/*always@ (posedge clk)
begin
delay <= delay+1;
case(delay)
       (27'b00000011110100001001000000): yr = yi0r;
       (27'b00000111101000010010000000): yr = yi1r;
endcase
if (delay>27'b00000111101000010010000000)
begin
delay<=0;
end
end*/
endmodule

module bfly2_4(xr,xi,yr,yi,wr,wi,x0r,x0i,x1r,x1i);// W08 & W28 
input signed [8:0]xr,xi,yr,yi; 
input signed [8:0]wr,wi; 
output[8:0]x0r,x0i,x1r,x1i; 
wire [17:0]p1,p2,p3,p4; 
assign p1=wr*yr; 
assign p2=wi*yi;
assign p3=wr*yi; 
assign p4=wi*yr; 
assign x0r=xr+p1[8:0]- p2[8:0];
assign x0i=xi+p3[8:0]+ p4[8:0]; 
assign x1r=xr-p1[8:0]+ p2[8:0]; 
assign x1i=xi-p3[8:0]- p4[8:0];
endmodule 

module bfly4_4(xr,xi,yr,yi,wr,wi,x0r,x0i,x1r,x1i); //W18 & W38 
input signed [8:0]xr,xi,yr,yi; 
input signed [8:0]wr,wi; 
output [8:0]x0r,x0i,x1r,x1i; 
wire [17:0]p1,p2,p3,p4; 
assign p1=wr*yr; 
assign p2=wi*yi; 
assign p3=wr*yi; 
assign p4=wi*yr; 
assign x0r=xr+p1[17:8]-p2[17:8];
assign x0i=xi+p3[17:8]+p4[17:8]; 
assign x1r=xr-p1[17:8]+p2[17:8]; 
assign x1i=xi-p3[17:8]- p4[17:8]; 
endmodule 
