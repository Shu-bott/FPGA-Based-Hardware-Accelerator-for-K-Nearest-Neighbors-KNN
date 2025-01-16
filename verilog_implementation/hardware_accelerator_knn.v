
module knn_working #(parameter n = 26,

  parameter size = 5
)(
  input [size-1:0] sample_in,
  input [0:2]k,
  input [size-1:0] sample_in1,
  input clk,
  //input clk1,
  //output reg[6:0] seg,
 output reg led_out0,
 output reg led_out1
 //output reg [7:0] z
 );

integer i, j, temp;
reg [size-1:0] samples[0:n-1];
reg [size-1:0] samples1[0:n-1];
reg [7:0] a[0:9];
reg[7:0] element_a[0:9];
reg r;
reg[3:0] classa;
reg[3:0] classb;

//reg flag,flag1,flag2,flag3;

initial begin
//flag=0;
//flag1=0;
  samples[0] = 5'b00000;
  samples[1] = 5'b00001;
  samples[2] = 5'b00010;
  samples[3] = 5'b00011;
  samples[4] = 5'b00100;
  samples[5] = 5'b10010;
  samples[6] = 5'b01110;
  samples[7] = 5'b01111;
  samples[8] = 5'b10100;
  samples[9] = 5'b01001;
  samples[10] = 5'b01010;
  samples[11] = 5'b01011;
  samples[12] = 5'b01000;
  samples[13] = 5'b01000;
  samples[14] = 5'b00110;
  samples[15] = 5'b00111;
  samples[16] = 5'b00110;
  samples[17] = 5'b01101;
  samples[18] = 5'b10010;
  samples[19] = 5'b10011;
  samples[20] = 5'b10100;
  samples[21] = 5'b10101;
  samples[22] = 5'b10110;
  samples[23] = 5'b10111;
  samples[24] = 5'b11000;
  samples[25] = 5'b11001;
 
 
 
 
  samples1[0] = 5'b10100;
  samples1[1] = 5'b10000;
  samples1[2] = 5'b11001;
  samples1[3] = 5'b11011;
  samples1[4] = 5'b11111;
  samples1[5] = 5'b10100;
  samples1[6] = 5'b10001;
  samples1[7] = 5'b10100;
  samples1[8] = 5'b10001;
  samples1[9] = 5'b11110;
  samples1[10] = 5'b11101;
  samples1[11] = 5'b11011;
  samples1[12] = 5'b11000;
  samples1[13] = 5'b10011;
  samples1[14] = 5'b10111;
  samples1[15] = 5'b10101;
  samples1[16] = 5'b11111;
  samples1[17] = 5'b00111;
  samples1[18] = 5'b01000;
  samples1[19] = 5'b10011;
  samples1[20] = 5'b00101;
  samples1[21] = 5'b01000;
  samples1[22] = 5'b10110;
  samples1[23] = 5'b10111;
  samples1[24] = 5'b01111;
  samples1[25]= 5'b01001;
end

reg [12:0] distances [0:n-1], distances2[0:n-1];
//reg [size-1:0] diff_sample, diff_sample1;
//reg [15:0] square_diff_sample, square_diff_sample1;

//reg [15:0] xyz[0:n-1];
//reg [15:0] abc[0:n-1];
//reg [15:0] d[0:n-1];

always @(negedge clk) begin
//flag1=0;
//d[0:n-1] = distances [0:n-1];
  for (i = 0; i < n; i = i + 1) begin
  distances[i] = (((sample_in - samples[i]) * (sample_in - samples[i])) + ((sample_in1 - samples1[i]) * (sample_in1 - samples1[i]))) ;
	 distances2[i] = distances[i];
  end
 
 
   for (i = 0; i < n; i = i + 1) begin
  //abc[i]=distances[i];
    for (j = i + 1; j < n; j = j + 1) begin
      if (distances[i] > distances[j]) begin
        temp = distances[i];
        distances[i] = distances[j];
        distances[j] = temp;
 
 
      end
    end
  end
  //flag2=1;
//end


for(i=0;i<k;i=i+1)
begin
a[i]=distances[i];
//a[i]=xyz[i];
end


for(i=0;i<n;i=i+1)begin
for(j=0;j<k;j=j+1)
begin
//for(r=0;r<k;r=r+1)
//begin
    if (a[j]==distances2[i]) begin
element_a[j]<=i;
end

end
end
end
//r=r+1;

always@(negedge clk)
begin
classa=0;
classb=0;
for(j=0;j<k;j=j+1)
begin
if (element_a[j] <= 4 || (element_a[j] > 8 && element_a[j] <= 16)) begin
    classa = classa + 1;
  end
  else
 if ((element_a[j] > 4 && element_a[j] <=8)||(element_a[j] > 16)) begin
    classb = classb + 1;
  end
   // end
end

 
   
if (classa>classb)
begin
led_out0<=1;
led_out1<=0;
//flag=1;
end
else
begin

led_out0<=0;
led_out1<=1;
//flag=1;
end
//flag1=0
end

  endmodule