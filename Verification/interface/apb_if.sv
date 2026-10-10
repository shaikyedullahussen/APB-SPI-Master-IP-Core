interface apb_if(input bit clock);
	logic presetn;
	logic pclk;
	logic penable;
	logic psel;
	logic pready;
	logic pselver;
	logic pwrite;
	logic [7:0]prdata;
	logic [2:0]paddr;
	logic [7:0]pwdata;
	assign pclk=~clock;

clocking apb_drv@(posedge pclk);
	default input #1 output #1;
	output presetn;
	output penable;
	output psel;
	output paddr;
	output pwrite;
	output pwdata;
	input prdata;
	input pready;
	input pselver;
endclocking

clocking apb_mon@(posedge pclk);
	default input #1 output #1;
	input presetn;
	input psel;
	input paddr;
	input penable;
	input pwrite;
	input pwdata;
	input prdata;
	input pselver;
	input pready;
endclocking

modport APB_DRV_CB(clocking apb_drv);
modport APB_MON_CB(clocking apb_mon);

endinterface
