--------------------------------------------------------------------------------
-- Company: 		Ohio State University
-- Engineer:		Ali Ibrahim and Mohammed Jama-Handulleh
--
-- Create Date:   22:46:19 11/24/2023
-- Design Name:   
-- Module Name:   U:/Documents/ECE3561/ECE3561/ParallelAdder4BitTest.vhd
-- Project Name:  ECE3561
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ParallelAdder4Bit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY ParallelAdder4BitTest IS
END ParallelAdder4BitTest;
 
ARCHITECTURE behavior OF ParallelAdder4BitTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ParallelAdder4Bit
    PORT(
         X4 : IN  std_logic;
         X3 : IN  std_logic;
         X2 : IN  std_logic;
         X1 : IN  std_logic;
         Y4 : IN  std_logic;
         Y3 : IN  std_logic;
         Y2 : IN  std_logic;
         Y1 : IN  std_logic;
         CI : IN  std_logic;
         S4 : OUT  std_logic;
         S3 : OUT  std_logic;
         S2 : OUT  std_logic;
         S1 : OUT  std_logic;
         CO : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X4 : std_logic := '0';
   signal X3 : std_logic := '0';
   signal X2 : std_logic := '0';
   signal X1 : std_logic := '0';
   signal Y4 : std_logic := '0';
   signal Y3 : std_logic := '0';
   signal Y2 : std_logic := '0';
   signal Y1 : std_logic := '0';
   signal CI : std_logic := '0';

 	--Outputs
   signal S4 : std_logic;
   signal S3 : std_logic;
   signal S2 : std_logic;
   signal S1 : std_logic;
   signal CO : std_logic;
	
	-- Temporal signal definition
	signal TEMPORAL: std_logic_vector(5 downto 0) := "000000";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ParallelAdder4Bit PORT MAP (
          X4 => X4,
          X3 => X3,
          X2 => X2,
          X1 => X1,
          Y4 => Y4,
          Y3 => Y3,
          Y2 => Y2,
          Y1 => Y1,
          CI => CI,
          S4 => S4,
          S3 => S3,
          S2 => S2,
          S1 => S1,
          CO => CO
        );

   -- ***Test Bench*** --
   tb: process
   begin		
      for i in 0 to 21 loop -- 1050ns simulation
			TEMPORAL <= std_logic_vector(UNSIGNED(TEMPORAL) + 1); -- increment temporal
			
			if (TEMPORAL = "000001") then -- 50 ns have passed
				-- slight delay to allow circuit to initalize before performing first addition (annoying VHDL quirk)
				-- first addition tested is 2 + 2 + 0 = 4
				X4 <= '0';
				X3 <= '0';
				X2 <= '1';
				X1 <= '0';
				Y4 <= '0';
				Y3 <= '0';
				Y2 <= '1';
				Y1 <= '0';
				CI <= '0';
			end if;
			
			if (TEMPORAL = "000111") then -- 350 ns have passed
				-- new addition should be set to 1111b + 1 + 1 = 0001b + 1 carried out
				X4 <='1';
				X3 <= '1';
				X2 <= '1';
				X1 <= '1';
				Y4 <= '0';
				Y3 <= '0';
				Y2 <= '0';
				Y1 <= '1';
				CI <= '1';
			end if;
			
			if (TEMPORAL = "001110") then -- 700 ns have passed
				-- new addition should be set to 0000b + 0 + 1 = 0001b
				X4 <= '0';
				X3 <= '0';
				X2 <= '0';
				X1 <= '0';
				Y4 <= '0';
				Y3 <= '0';
				Y2 <= '0';
				Y1 <= '0';
				CI <= '1';
			end if;
			
			wait for 50ns; -- time resolution is 100 ns
		end loop;
		WAIT;
   end process;

END;
