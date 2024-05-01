--------------------------------------------------------------------------------
-- Company: 		Ohio State University
-- Engineer:		Ali Ibrahim and Mohammed Jama-Handulleh
--
-- Create Date:   13:08:20 11/21/2023
-- Design Name:   
-- Module Name:   U:/Documents/ECE3561/ECE3561/SystemControllerTest.vhd
-- Project Name:  ECE3561
-- Target Device:  
-- Tool versions:  
-- Description:   Test of the Binary Multiplier System Controller
-- 
-- VHDL Test Bench Created by ISE for module: SystemController
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
 
ENTITY SystemControllerTest IS
END SystemControllerTest;
 
ARCHITECTURE behavior OF SystemControllerTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SystemController
    PORT(
         CLK : IN  std_logic;
         START : IN  std_logic;
         LSB : IN  std_logic;
         C4 : IN  std_logic;
			INIT: IN std_logic;
         S10 : OUT  std_logic;
         S11 : OUT  std_logic;
         S20 : OUT  std_logic;
         S21 : OUT  std_logic;
         S30 : OUT  std_logic;
         S31 : OUT  std_logic;
         CLR_RES_L : OUT  std_logic;
         CLR_CNTR_L : OUT  std_logic;
         EN_CNTR : OUT  std_logic;
         DONE : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic;
	
	-- initialize non-clock inputs
   signal START : std_logic := '0';
   signal LSB : std_logic := '0';
   signal C4 : std_logic := '0';
	signal INIT: std_logic := '1';

 	--Outputs
   signal S10 : std_logic;
   signal S11 : std_logic;
   signal S20 : std_logic;
   signal S21 : std_logic;
   signal S30 : std_logic;
   signal S31 : std_logic;
   signal CLR_RES_L : std_logic;
	
   signal CLR_CNTR_L : std_logic;
   signal EN_CNTR : std_logic;
   signal DONE : std_logic;

   -- Temporal signal for CLK
	signal TEMPORAL : std_logic_vector(5 downto 0) := "000000";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SystemController PORT MAP (
          CLK => CLK,
          START => START,
          LSB => LSB,
          C4 => C4,
			 INIT => INIT,
          S10 => S10,
          S11 => S11,
          S20 => S20,
          S21 => S21,
          S30 => S30,
          S31 => S31,
          CLR_RES_L => CLR_RES_L,
          CLR_CNTR_L => CLR_CNTR_L,
          EN_CNTR => EN_CNTR,
          DONE => DONE
        );
		  

   -- ***Test Bench*** --
   tb: process
   begin		
      for i in 0 to 60 loop -- 3000ns simulation
			CLK <= TEMPORAL(0); -- iterate the clock
			TEMPORAL <= std_logic_vector(UNSIGNED(TEMPORAL) + 1); -- increment temporal
			
			if (TEMPORAL = "000011") then -- 150 ns have passed
				-- INIT was asserted up until now to force the controller to it's inital state
				INIT <= '0'; -- turn off INIT
			end if;
			
			if (TEMPORAL = "001001") then -- 450 ns have passed
				-- from 0 to 450 ns, the controller should remain in Init state
				-- now the START signal should change the state to Load
				-- Load only lasts for one clock cycle, so LSB will be kept at 0 to ensure controller changes to Shift state after for the next 450ns
				START <= '1'; -- assert START
				LSB <= '0'; -- turn off LSB
			end if;
			
			if (TEMPORAL = "010011") then -- 950 ns have passed
				-- at 950ns, the LSB input will turn on, controller should oscilate between Shift and Add states
				LSB <= '1'; -- assert LSB
			end if;
			
			if (TEMPORAL = "011101") then -- 1450 ns have passed
				-- at 1450ns, the C4 input will turn on, the circuit should change state to Done
				C4 <= '1'; -- assert C4 to change state to Done
			end if;
			
			if (TEMPORAL = "100111") then -- 1950 ns have passed
				-- at 1950ns, the START input will turn off, the circuit should change state to Init
				START <= '0'; -- turn off START to change state to Init
			end if;
			
			wait for 50ns; -- CLK period is 100 seconds
		end loop;
		WAIT;
   end process;

END;
