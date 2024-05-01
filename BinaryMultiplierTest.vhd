--------------------------------------------------------------------------------
-- Company: 		Ohio State University
-- Engineer:		Ali Ibrahim and Mohammed Jama-Handulleh
--
-- Create Date:   20:15:58 11/24/2023
-- Design Name:   
-- Module Name:   U:/Documents/ECE3561/ECE3561/BinaryMultiplierTest.vhd
-- Project Name:  ECE3561
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BinaryMultiplier
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
 
ENTITY BinaryMultiplierTest IS
END BinaryMultiplierTest;
 
ARCHITECTURE behavior OF BinaryMultiplierTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BinaryMultiplier
    PORT(
         START : IN  std_logic;
         INIT : IN  std_logic;
         N1 : IN  std_logic;
         N2 : IN  std_logic;
         N3 : IN  std_logic;
         N4 : IN  std_logic;
         M1 : IN  std_logic;
         M2 : IN  std_logic;
         M3 : IN  std_logic;
         M4 : IN  std_logic;
         CLK : IN  std_logic;
         R8 : BUFFER  std_logic;
         R7 : BUFFER  std_logic;
         R6 : BUFFER  std_logic;
         R5 : BUFFER  std_logic;
         R4 : BUFFER  std_logic;
         R3 : BUFFER  std_logic;
         R2 : BUFFER  std_logic;
         R1 : BUFFER  std_logic;
         DONE : OUT  std_logic
        );
    END COMPONENT;
    

   -- Initialize inputs
   signal START : std_logic := '0';
   signal INIT : std_logic := '1'; -- to initialize circuit at the start
	signal N  : std_logic_vector(3 downto 0); -- to make reading the multiplicand input number easier
	signal M  : std_logic_vector(3 downto 0); -- to make reading the multiplier input number easier
   
 	-- Outputs
	signal R  : std_logic_vector(7 downto 0); -- to make reading the multiplier input number easier
	signal DONE : std_logic;
	
	-- single bit N, M, and R inputs/outputs
	signal N1 : std_logic := '0';
   signal N2 : std_logic := '0';
   signal N3 : std_logic := '0';
   signal N4 : std_logic := '0';
   signal M1 : std_logic := '0';
   signal M2 : std_logic := '0';
   signal M3 : std_logic := '0';
   signal M4 : std_logic := '0';
	signal R8 : std_logic;
   signal R7 : std_logic;
   signal R6 : std_logic;
   signal R5 : std_logic;
   signal R4 : std_logic;
   signal R3 : std_logic;
   signal R2 : std_logic;
   signal R1 : std_logic;

   -- Clock definitions
	signal CLK : std_logic;
	signal TEMPORAL: std_logic_vector(5 downto 0) := "000000"; -- temporal signal for the clock
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BinaryMultiplier PORT MAP (
          START => START,
          INIT => INIT,
          N1 => N1,
          N2 => N2,
          N3 => N3,
          N4 => N4,
          M1 => M1,
          M2 => M2,
          M3 => M3,
          M4 => M4,
          CLK => CLK,
          R8 => R8,
          R7 => R7,
          R6 => R6,
          R5 => R5,
          R4 => R4,
          R3 => R3,
          R2 => R2,
          R1 => R1,
          DONE => DONE
        );

	-- ***Test Bench*** --
   tb: process
   begin		
      for i in 0 to 30 loop -- 1500 ns simulation
			CLK <= TEMPORAL(0); -- iterate the clock
			TEMPORAL <= std_logic_vector(UNSIGNED(TEMPORAL) + 1); -- increment temporal
			
			if (TEMPORAL = "000011") then -- 150 ns have passed
				-- INIT was asserted up until now to force the circuit to it's inital state
				INIT <= '0'; -- turn off INIT
				
				-- prepare the multiplicand and multiplier inputs to perform 0110b * 0011b
				N4 <= '0';
				N3 <= '1';
				N2 <= '1';
				N1 <= '0'; -- N = 0110b
				
				M4 <= '0';
				M3 <= '0';
				M2 <= '1';
				M1 <= '1'; -- M = 0011b
			end if;
			
			if (TEMPORAL = "001001") then -- 450 ns have passed
				-- inputs have long since been ready, assert START
				START <= '1';
			end if;
			
			-- Final output of the circuit should be R = 10101010
			
			wait for 50ns; -- CLK period is 100 seconds
		end loop;
		WAIT;
   end process;
	
	input_output:  process(M4, M3, M2, M1, N4, N3, N2, N1, R8, R7, R6, R5, R4, R3, R2, R1) -- process to update the input/output vectors for ease of reading
	begin
		M(3) <= M4;
		M(2) <= M3;
		M(1) <= M2;
		M(0) <= M1;
		
		N(3) <= N4;
		N(2) <= N3;
		N(1) <= N2;
		N(0) <= N1;
		
		R(7) <= R8;
		R(6) <= R7;
		R(5) <= R6;
		R(4) <= R5;
		R(3) <= R4;
		R(2) <= R3;
		R(1) <= R2;
		R(0) <= R1;
	end process;
END;
