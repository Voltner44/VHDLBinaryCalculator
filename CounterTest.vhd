--------------------------------------------------------------------------------
-- Engineer: 		Ali Ibrahim and Mohammed Jama-Handulleh
-- Company:			Ohio State University
--
-- Create Date:   01:20:08 11/23/2023
-- Design Name:   
-- Module Name:   U:/Documents/ECE3561/ECE3561/CounterTest.vhd
-- Project Name:  ECE3561
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Counter
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
 
ENTITY CounterTest IS
END CounterTest;
 
ARCHITECTURE behavior OF CounterTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Counter
    PORT(
         ENT : IN  std_logic;
         ENP : IN  std_logic;
         LOAD_L : IN  std_logic;
         D : IN  std_logic;
         C : IN  std_logic;
         B : IN  std_logic;
         A : IN  std_logic;
         CLK : IN  std_logic;
         CLR_L : IN  std_logic;
         RCO : OUT  std_logic;
         QD : BUFFER  std_logic;
         QC : BUFFER  std_logic;
         QB : BUFFER  std_logic;
         QA : BUFFER  std_logic
        );
    END COMPONENT;
    

   --Initialize non-clock inputs
   signal ENT : std_logic := '0';
   signal ENP : std_logic := '0';
   signal LOAD_L : std_logic := '0';
   signal D : std_logic := '1';
   signal C : std_logic := '0';
   signal B : std_logic := '1';
   signal A : std_logic := '0';
   signal CLR_L : std_logic := '1';

 	--Outputs
   signal RCO : std_logic;
   signal QD : std_logic;
   signal QC : std_logic;
   signal QB : std_logic;
   signal QA : std_logic;

   -- Clock Definitions
	signal CLK : std_logic;
	signal TEMPORAL : std_logic_vector(5 downto 0) := "000000";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Counter PORT MAP (
          ENT => ENT,
          ENP => ENP,
          LOAD_L => LOAD_L,
          D => D,
          C => C,
          B => B,
          A => A,
          CLK => CLK,
          CLR_L => CLR_L,
          RCO => RCO,
          QD => QD,
          QC => QC,
          QB => QB,
          QA => QA
        );

   -- ***Test Bench*** --
   tb: process
   begin		
      for i in 0 to 40 loop -- 2000ns simulation
			CLK <= TEMPORAL(0); -- iterate the clock
			TEMPORAL <= std_logic_vector(UNSIGNED(TEMPORAL) + 1); -- increment temporal
			
			if (TEMPORAL = "000010") then -- 50 ns have passed
				-- 1010 should be loaded as the count on the counter
				LOAD_L <= '1'; -- assert load low, stop loading
			end if;
			
			if (TEMPORAL = "001010") then -- 500 ns have passed
				-- count has held at 1010
				ENT <= '1';
				ENP <= '1'; -- assert ENP and ENT, enable counting
			end if;
			
			if (TEMPORAL = "010100") then -- 1000 ns have passed
				-- count has been incrementing for 10 clock cycles				
				CLR_L <= '0'; -- turn off clear low, clear the count to 0
			end if;
			
			if (TEMPORAL = "011110") then -- 1500 ns have passed
				-- count has been cleared for 10 clock cycles				
				CLR_L <= '1'; -- assert clear low, stop clearing the count to 0
				LOAD_L <= '0'; -- turn off load low, load 1010 as the count again
			end if;
			
			wait for 50ns; -- CLK period is 100 seconds
		end loop;
		WAIT;
   end process;


END;
