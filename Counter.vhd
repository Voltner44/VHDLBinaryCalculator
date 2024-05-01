----------------------------------------------------------------------------------
-- Company: 		 Ohio State University
-- Engineer: 		 Ali Ibrahim and Mohammed Jama-Handulleh
-- 
-- Create Date:    00:37:16 11/23/2023 
-- Design Name: 	 74LS163
-- Module Name:    Counter - Behavioral 
-- Project Name:   Binary Multiplier Circuit
-- Target Devices: 
-- Tool versions: 
-- Description:    A 0-15 counter for use in the Binary Multiplier
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
    Port ( ENT : in  STD_LOGIC;
           ENP : in  STD_LOGIC;
           LOAD_L : in  STD_LOGIC;
           D : in  STD_LOGIC;
           C : in  STD_LOGIC;
           B : in  STD_LOGIC;
           A : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CLR_L : in  STD_LOGIC;
           RCO : out  STD_LOGIC;
           QD : buffer  STD_LOGIC;
           QC : buffer  STD_LOGIC;
           QB : buffer  STD_LOGIC;
           QA : buffer  STD_LOGIC);
end Counter;

architecture Behavioral of Counter is
	signal Count: STD_LOGIC_VECTOR(3 downto 0); -- a bit vector representing D, C, B, and A
begin
	QD <= Count(3);
	QC <= Count(2);
	QB <= Count(1);
	QA <= Count(0); -- assign the D,C,B,A to the corresponding bits of the Count bit vector
	RCO <= QD AND QC AND QB AND QA;
	
	process(CLK) -- behavioral process of the counter
	begin
		if CLK'event and CLK= '1' then -- upon a rising clock edge
			if CLR_L = '0' then
				Count <= "0000"; -- CLR_L resets the count to 0
			elsif LOAD_L = '0' then -- LOAD_L loads the inputs into the count
				Count(3) <= D;
				Count(2) <= C;
				Count(1) <= B;
				Count(0) <= A;
			else -- not loading or clearing, count up if ENP and ENT are high
				if ENP = '1' AND ENT = '1' then
					Count <= STD_LOGIC_VECTOR(UNSIGNED(Count) + 1); -- increment Count
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;

