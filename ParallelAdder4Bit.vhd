----------------------------------------------------------------------------------
-- Company: 		 Ohio State University
-- Engineer: 		 Ali Ibrahim and Mohammed Jama-Handulleh
-- 
-- Create Date:    02:12:48 11/23/2023 
-- Design Name: 
-- Module Name:    ParallelAdder4Bit - Behavioral 
-- Project Name: 	 Binary Multiplier Circuit
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ParallelAdder4Bit is
    Port ( X4 : in  STD_LOGIC;
           X3 : in  STD_LOGIC;
           X2 : in  STD_LOGIC;
           X1 : in  STD_LOGIC;
           Y4 : in  STD_LOGIC;
           Y3 : in  STD_LOGIC;
           Y2 : in  STD_LOGIC;
           Y1 : in  STD_LOGIC;
           CI : in  STD_LOGIC;
           S4 : out  STD_LOGIC;
           S3 : out  STD_LOGIC;
           S2 : out  STD_LOGIC;
           S1 : out  STD_LOGIC;
           CO : out  STD_LOGIC);
end ParallelAdder4Bit;

architecture Behavioral of ParallelAdder4Bit is
	signal X, Y: STD_LOGIC_VECTOR(4 downto 0); -- define X and Y into unsigned binary numbers rather than individual bits
	signal S: STD_LOGIC_VECTOR(4 downto 0); -- define S output number, MSB used as carry out
begin
	X(4) <= '0';
	X(3) <= X4;
	X(2) <= X3;
	X(1) <= X2;
	X(0) <= X1; -- load the X vector
	
	Y(4) <= '0';
	Y(3) <= Y4;
	Y(2) <= Y3;
	Y(1) <= Y2;
	Y(0) <= Y1; -- load the Y vector
	
	S <= X + Y + CI; -- combinational asynchronous addition
	
	S4 <= S(3);
	S3 <= S(2);
	S2 <= S(1);
	S1 <= S(0); -- set the S outputs to the appropriate bits in the S vector
	CO <= S(4); -- set the carry out bit
	
end Behavioral;

