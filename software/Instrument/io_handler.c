//io_handler.c
#include "io_handler.h"
#include <stdio.h>

void IO_init(void)
{
	*otg_hpi_reset = 1;
	*otg_hpi_cs = 1;
	*otg_hpi_r = 1;
	*otg_hpi_w = 1;
	*otg_hpi_address = 0;
	*otg_hpi_data = 0;
	// Reset OTG chip
	*otg_hpi_cs = 0;
	*otg_hpi_reset = 0;
	*otg_hpi_reset = 1;
	*otg_hpi_cs = 1;
}

void IO_write(alt_u8 Address, alt_u16 Data)
{

	*otg_hpi_address = Address; // fill w/ address
	*otg_hpi_cs = 0; // hold
	*otg_hpi_w = 0; // hold
	*otg_hpi_data = Data; // fill with data
	*otg_hpi_w = 1; // write high
	*otg_hpi_cs = 1;

}

alt_u16 IO_read(alt_u8 Address)
{
	alt_u16 temp;

	*otg_hpi_address = Address; // fill w/ address
	*otg_hpi_cs = 0; //hold
	*otg_hpi_r = 0; // hold
	temp = *otg_hpi_data; // read what's in this
	*otg_hpi_r = 1; // read high
	*otg_hpi_cs = 1;

	//printf("%x\n",temp);
	return temp;
}
