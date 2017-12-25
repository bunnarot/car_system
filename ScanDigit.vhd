----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:23:51 12/23/2017 
-- Design Name: 
-- Module Name:    ScanDigit - Behavioral 
-- Project Name: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ScanDigit is
Port(
	clk : in std_logic;
	rstb : in std_logic;
	
	i1ms : in std_logic;
	
	idigit1 : in std_logic_vector(6 downto 0);
	idigit2 : in std_logic_vector(6 downto 0);
	
	odigit : out std_logic_vector(3 downto 0);
	odata : out std_logic_vector(6 downto 0)
);

end ScanDigit;

architecture Behavioral of ScanDigit is
	signal rcnt : std_logic_vector(3 downto 0);
	signal rshift : std_logic_vector(3 downto 0);


begin
odigit <= rshift;
	
	odata <= idigit1 when rshift="0111" else
				idigit2 when rshift="1011" else
				"0000000" when rshift="1101" else
				"0000000";
	
	u_rCnt : Process(clk,rstb)
	Begin
		if(rstb='0') then
			rcnt <= (others => '0');
			rshift <= "0111";
		elsif(rising_edge(clk)) then
			if(rcnt=4 and i1ms='1') then
				rcnt <= (others => '0');
				rshift <= rshift(0) & rshift(3 downto 1);
			elsif(i1ms = '1') then
				rcnt <= rcnt + 1;
				rshift <= rshift;
			else
				rcnt <= rcnt;
				rshift <= rshift;
			end if;
		end if;
	end Process;
		
		
end Behavioral;

