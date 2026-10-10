interface spi_if(input bit clock);
logic ss;
logic sclk;
logic mosi;
logic miso;
//assign sclk=~clock;

clocking spi_drv@(posedge clock);
	default input #1 output #1;
	input ss;
	input sclk;
	input mosi;
	output miso;
endclocking
	

clocking spi_mon@(posedge clock);
	default input #1 output #1;
	input ss;
	input sclk;
	input mosi;
	input miso;
endclocking
	
modport SPI_DRV_CB(clocking spi_drv);
modport SPI_MON_CB(clocking spi_mon);
endinterface
