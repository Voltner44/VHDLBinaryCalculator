----------------------------------------------------------------------------------
-- Company: 		 Ohio State University
-- Engineer: 		 Ali Ibrahim and Mohammed Jama-Handulleh
-- 
-- Create Date:    13:23:32 11/23/2023 
-- Design Name: 
-- Module Name:    ShiftRegister4Bit - Behavioral 
-- Project Name:   Binary Multiplier Circuit
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ShiftRegister9Bit is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           C : in  STD_LOGIC;
           D : in  STD_LOGIC;
			  E : in  STD_LOGIC;
			  F : in  STD_LOGIC;
			  G : in  STD_LOGIC;
			  H : in  STD_LOGIC;
			  J : in  STD_LOGIC;
           SLI : in  STD_LOGIC;
           SRI : in  STD_LOGIC;
           S0 : in  STD_LOGIC;
           S1 : in  STD_LOGIC;
           CLR_L : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : buffer  STD_LOGIC;
           QB : buffer  STD_LOGIC;
           QC : buffer  STD_LOGIC;
           QD : buffer  STD_LOGIC;
			  QE : buffer  STD_LOGIC;
			  QF : buffer  STD_LOGIC;
			  QG : buffer  STD_LOGIC;
			  QH : buffer  STD_LOGIC;
			  QJ : buffer  STD_LOGIC);
end ShiftRegister9Bit;

architecture Behavioral of ShiftRegister9Bit is
begin
	process(CLK) -- the behavioral process of the 9 bit bidirectional shift register
	begin
		if CLK'event AND CLK = '1' then -- upon a rising clock edge
			if (CLR_L = '0') then -- synchronous clear
				QA <= '0';
				QB <= '0';
			   QC <= '0';
				QD <= '0';
				QE <= '0';
				QF <= '0';
			   QG <= '0';
				QH <= '0';
				QJ <= '0';
			else
				if (S0 = '1' AND S1 = '1') then -- S0 = S1 = 1, load
					QA <= A;
					QB <= B;
					QC <= C;
					QD <= D;
					QE <= E;
					QF <= F;
					QG <= G;
					QH <= H;
					QJ <= J;
				elsif (S0 = '1') then -- S1 = 0, S0 = 1, shift right
					QJ <= QH;
					QH <= QG;
					QG <= QF;
					QF <= QE;
					QE <= QD;
					QD <= QC;
					QC <= QB;
					QB <= QA;
					QA <= SLI;
				elsif (S1 = '1') then -- S1 = 1, S0 = 0, shift left
					QA <= QB;
					QB <= QC;
					QC <= QD;
					QD <= QE;
					QE <= QF;
					QF <= QG;
					QG <= QH;
					QH <= QJ;
					QJ <= SRI;
				end if;			 -- if S1 = S2 = 0, no change to outputs
			end if;	
		end if;
	end process;
end Behavioral;

