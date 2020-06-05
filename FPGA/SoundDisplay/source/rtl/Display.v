`timescale 1ns/1ns

// Define colors RGB--8|8|8。色彩定义，定义色彩数据
`define RED		24'hFF0000 
`define GREEN	24'h00FF00 
`define BLUE  	24'h0000FF 
`define WHITE 	24'hFFFFFF 
`define BLACK 	24'h000000 
`define YELLOW	24'hFFFF00 
`define CYAN  	24'hFF00FF 
`define ROYAL 	24'h00FFFF 

//定义选择哪种模式。每次只能保证一个定义存在
// Define Display Mode
 `define VGA_Graph
 
module Display
#(
	parameter H_DISP = 1280,   //分辨率调整
	parameter V_DISP = 1024
)
( 
	input  wire	 		clk,	
	input  wire			rst_n,	
	input  wire [7:0]   on_off,
	input  wire [7:0]   rx_data,
	
	
	input  wire	[11:0]	lcd_xpos,	//lcd horizontal coordinate，水平坐标
	input  wire	[11:0]	lcd_ypos,	//lcd vertical coordinate，竖直坐标
	
	output reg  [23:0]	lcd_data	//lcd data
);

reg [31:0] count;
reg [31:0] counta;
reg [1279:0] mema [1023:0];//显示屏分辨率
reg [31:0] i;
reg [31:0] j;
reg [31:0] p;
reg [31:0] q;

reg clk1s; 
parameter max=10000;    //分频后周期，周期越大，闪烁越稳定
reg[30:0]n; 
 
always@(posedge clk)
begin 
	if(n==max)
		begin 
			if(!clk1s)     //分频
				 clk1s<=1'b1; 
			else clk1s<=1'b0; 
				 n<=0; 
		end
	 else 
	 n<=n+1; 
end



`ifdef VGA_Graph
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		lcd_data <= 24'h0;
	else
	begin
	if(rx_data  >  8'd30 )

	begin
		if(on_off[0])   //不同按键显示不同花色
			begin
			counta<=counta+1;
				i<=counta % 1280;
				j<=counta % 1024;
				if(lcd_xpos<(1280+i) && lcd_xpos>(0+i) && lcd_ypos<(1024+j) && lcd_ypos>(0+j) )
				lcd_data <= `WHITE;	
				else  lcd_data <= 24'h0;	
			end
		else if(on_off[1])
			begin
			counta<=counta+1;
				i<=counta % 640;
				j<=counta % 512;
				if(lcd_xpos<(640+i) && lcd_xpos>(640-i) && lcd_ypos<(512+j) && lcd_ypos>(512-j) )
				lcd_data <= `WHITE;	
				else  lcd_data <= 24'h0;	
			end  
		   else if(on_off[2])
			begin
			counta<=counta+1;
				i<=counta % 800;
				j<=counta % 600;
				if(lcd_xpos<(640+j) && lcd_xpos>(640-j) && lcd_ypos<(512+i) && lcd_ypos>(512-i) )
				lcd_data <= `WHITE;	
				else  lcd_data <= 24'h0;	
			end  
		 
		 
		   else if(on_off[3])
			begin
			counta<=counta+1;
				i<=counta % 900;
				j<=counta % 600;
				if(lcd_xpos<(640+j) && lcd_xpos>(640-j) && lcd_ypos<(512+i) && lcd_ypos>(512-i) )
				lcd_data <= `WHITE;	
				else  lcd_data <= 24'h0;	
			end  		
			   else if(on_off[4])
			begin
			counta<=counta+1;
				i<=counta % 900;
				j<=counta % 1000;
				if(lcd_xpos<(640+j) && lcd_xpos>(640-j) && lcd_ypos<(512+i) && lcd_ypos>(512-i) )
				lcd_data <= `WHITE;	
				else  lcd_data <= 24'h0;	
			end  	
		
		else lcd_data <= 24'h0;	

		end      
        end
		
end
`endif

endmodule