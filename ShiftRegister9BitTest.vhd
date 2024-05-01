--------------------------------------------------------------------------------
-- Company: 		Ohio State University
-- Engineer:		Ali Ibrahim and Mohammed Jama-Handulleh
--
-- Create Date:   21:11:50 11/24/2023
-- Design Name:   
-- Module Name:   U:/Documents/ECE3561/ECE3561/ShiftRegister9BitTest.vhd
-- Project Name:  ECE3561
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ShiftRegister9Bit
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
 
ENTITY ShiftRegister9BitTest IS
END ShiftRegister9BitTest;
 
ARCHITECTURE behavior OF ShiftRegister9BitTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ShiftRegister9Bit
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         C : IN  std_logic;
         D : IN  std_logic;
         E : IN  std_logic;
         F : IN  std_logic;
         G : IN  std_logic;
         H : IN  std_logic;
         J : IN  std_logic;
         SLI : IN  std_logic;
         SRI : IN  std_logic;
         S0 : IN  std_logic;
         S1 : IN  std_logic;
         CLR_L : IN  std_logic;
         CLK : IN  std_logic;
         QA : BUFFER  std_logic;
         QB : BUFFER  std_logic;
         QC : BUFFER  std_logic;
         QD : BUFFER  std_logic;
         QE : BUFFER  std_logic;
         QF : BUFFER  std_logic;
         QG : BUFFER  std_logic;
         QH : BUFFER  std_logic;
         QJ : BUFFER  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '1';
   signal B : std_logic := '1';
   signal C : std_logic := '1';
   signal D : std_logic := '1';
   signal E : std_logic := '1';
   signal F : std_logic := '1';
   signal G : std_logic := '1';
   signal H : std_logic := '1';
   signal J : std_logic := '1';
   signal SLI : std_logic :='1';
   signal SRI : std_logic := '1';
   signal S0 : std_logic := '0';
   signal S1 : std_logic := '0';
   signal CLR_L : std_logic := '0';

 	--Outputs
   signal QA : std_logic;
   signal QB : std_logic;
   signal QC : std_logic;
   signal QD : std_logic;
   signal QE : std_logic;
   signal QF : std_logic;
   signal QG : std_logic;
   signal QH : std_logic;
   signal QJ : std_logic;

   -- Clock definitions
	signal CLK : std_logic;
	signal TEMPORAL: std_logic_vector(5 downto 0) := "000000"; -- temporal signal for the clock
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ShiftRegister9Bit PORT MAP (
          A => A,
          B => B,
          C => C,
          D => D,
          E => E,
          F => F,
          G => G,
          H => H,
          J => J,
          SLI => SLI,
          SRI => SRI,
          S0 => S0,
          S1 => S1,
          CLR_L => CLR_L,
          CLK => CLK,
          QA => QA,
          QB => QB,
          QC => QC,
          QD => QD,
          QE => QE,
          QF => QF,
          QG => QG,
          QH => QH,
          QJ => QJ
        );

   -- ***Test Bench*** --
   tb: process
   begin		
      for i in 0 to 60 loop -- 3000ns simulation
			CLK <= TEMPORAL(0); -- iterate the clock
			TEMPORAL <= std_logic_vector(UNSIGNED(TEMPORAL) + 1); -- increment temporal
			
			if (TEMPORAL = "000010") then -- 100 ns have passed
				-- CLR_L has been low to initalize the counter, assert it
				CLR_L <= '1';
			end if;
			
			if (TEMPORAL = "001010") then -- 500 ns have passed
				-- initial state has been held, begin shifting right
				S0 <= '1';
			end if;
			
			if (TEMPORAL = "010100") then -- 1000 ns have passed
				-- clear the ones that have been serially shifted in
				CLR_L <= '0';
				S1 <= '1';
				S0 <= '0'; -- begin shifting left when CLR_L is asserted
			end if;
			
			if (TEMPORAL = "011110") then -- 1500 ns have passed
				-- begin shifting left
				CLR_L <= '1';
			end if;
			
			if (TEMPORAL = "101000") then -- 2000 ns have passed
				-- load in ones
				S0 <= '1';
			end if;
			
			wait for 50ns; -- CLK period is 100 seconds
		end loop;
		WAIT;
   end process;

END;
