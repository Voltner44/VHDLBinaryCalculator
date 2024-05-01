----------------------------------------------------------------------------------
-- Company: 		 Ohio State University
-- Engineer: 		 Ali Ibrahim and Mohamed Jama-Handulleh
-- 
-- Create Date:    16:15:44 11/16/2023 
-- Design Name: 
-- Module Name:    SystemController - Behavioral 
-- Project Name: 	 Binary Multiplier
-- Target Devices: 
-- Tool versions: 
-- Description: 	 The system controller unit for a Binary Multiplier Circuit
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

entity SystemController is
	Port ( CLK : in  STD_LOGIC;
		  START : in  STD_LOGIC;
		  LSB : in  STD_LOGIC;
		  C4 : in  STD_LOGIC;
		  INIT: in STD_LOGIC;
		  S10 : out  STD_LOGIC;
		  S11 : out  STD_LOGIC;
		  S20 : out  STD_LOGIC;
		  S21 : out  STD_LOGIC;
		  S30 : out  STD_LOGIC;
		  S31 : out  STD_LOGIC;
		  CLR_RES_L : out  STD_LOGIC;
		  CLR_CNTR_L : out  STD_LOGIC;
		  EN_CNTR : out  STD_LOGIC;
		  DONE : out  STD_LOGIC);
end SystemController;

architecture Behavioral of SystemController is
	Signal Q2, Q1, Q0: STD_LOGIC; -- state variables representing the state of the circuit
begin
	DFF2: process (CLK) -- Q2 D flip flop
	begin
		if CLK'event and CLK='0' then  -- upon a falling clock edge			
			if INIT='1' then   
				Q2 <= '0';
			else
				Q2 <= (NOT(Q1) AND Q0 AND LSB) OR (NOT(Q2) AND Q1 AND Q0 AND LSB AND NOT(C4)); -- next state for Q2
			end if;
		end if;
	end process;	
	
	DFF1: process (CLK) -- Q1 D flip flop
	begin
		if CLK'event and CLK='0' then  -- upon a falling clock edge			
			if INIT='1' then   
				Q1 <= '0';
			else
				Q1 <= Q0 OR (Q1 AND START); 	-- next state for Q1
			end if;
		end if;
	end process;
	
	DFF0: process (CLK) -- Q0 D flip flop
	begin
		if CLK'event and CLK='0' then  -- upon a falling clock edge			
			if INIT='1' then   
				Q0 <= '0';
			else
				Q0 <= Q2 OR (NOT(Q1) AND Q0) OR (NOT(Q1) AND START) OR (Q0 AND NOT(C4)); 		 -- next state for Q0
			end if;
		end if;
	end process;
	
	COMB: process(Q2, Q1, Q0) -- combinational logic for outputs of controller
	begin
			S10 <= NOT(Q1) AND Q0;  	  -- next output for S10
			S11 <= NOT(Q1) AND Q0; 		  -- next output for S11
			S20 <= NOT(Q2) AND Q0;       -- next output for S20
			S21 <= NOT(Q1) AND Q0; 		  -- next output for S21
			S30 <= Q1 AND Q0;		  		  -- next output for S30
			S31 <= Q2;				  		  -- next output for S31
			
			CLR_RES_L <= Q1 OR Q0;  -- next output for CLR_RES_L
			CLR_CNTR_L <= Q0 OR Q1;		  -- next output for CLR_CNTR_L
			EN_CNTR <= NOT(Q2) AND Q1 AND Q0; -- next output for EN_CNTR
			DONE <= NOT(Q0);				  -- next output for DONE
	end process;

end Behavioral;

