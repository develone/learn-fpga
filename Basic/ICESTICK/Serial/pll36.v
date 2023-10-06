/**
 * PLL configuration
 *
 * This Verilog header file was generated automatically
 * using the icepll tool from the IceStorm project.
 * It is intended for use with FPGA primitives SB_PLL40_CORE,
 * SB_PLL40_PAD, SB_PLL40_2_PAD, SB_PLL40_2F_CORE or SB_PLL40_2F_PAD.
 * Use at your own risk.
 *
 * Given input frequency:       100.000 MHz
 * Requested output frequency:   36.000 MHz
 * Achieved output frequency:    35.938 MHz
 */

.FEEDBACK_PATH("SIMPLE"),
.DIVR(4'b0011),		// DIVR =  3
.DIVF(7'b0010110),	// DIVF = 22
.DIVQ(3'b100),		// DIVQ =  4
.FILTER_RANGE(3'b010)	// FILTER_RANGE = 2
