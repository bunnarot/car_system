----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:24:03 12/23/2017 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
port 
		(
		  clk,reset_n: in std_logic; -- clock and reset of the car parking system
		  front_sensor, back_sensor: in std_logic; -- two sensor in front and behind the gate of the car parking system
		  password_1, password_2: in std_logic_vector(1 downto 0); -- input password 
		  GREEN_LED,RED_LED: out std_logic; -- signaling LEDs
		  HEX: out std_logic_vector(6 downto 0); -- 7-segment Display 
		  outDigit : out std_logic_vector(3 downto 0)
		);
end top;

architecture Behavioral of top is


	component car is
		port 
		(
		  clk,reset_n : in std_logic; -- clock and reset of the car parking system
		  front_sensor, back_sensor: in std_logic; -- two sensor in front and behind the gate of the car parking system
		  password_1, password_2: in std_logic_vector(1 downto 0); -- input password 
		  GREEN_LED,RED_LED: out std_logic; -- signaling LEDs
		  HEX_1, HEX_2: out std_logic_vector(6 downto 0); -- 7-segment Display 
		  clk1ms :in std_logic
		);
	end component car;
	
	component ScanDigit is
	Port(
		clk : in std_logic;
		rstb : in std_logic;
		i1ms : in std_logic;
		idigit1 : in std_logic_vector(6 downto 0);
		idigit2 : in std_logic_vector(6 downto 0);
		odigit : out std_logic_vector(3 downto 0);
		odata : out std_logic_vector(6 downto 0)
	);
end component ScanDigit;

	component CLK1ms is
	Port(
		clk : in std_logic;
		rstb : in std_logic;
		o1ms : out std_logic
	);

end component CLK1ms;

signal HEX_1 : std_logic_vector(6 downto 0);
signal HEX_2 : std_logic_vector(6 downto 0);
signal C1ms : std_logic;

begin
	u_car : car
	port map(
		  clk  =>  clk,
		  reset_n => reset_n,
		  front_sensor => front_sensor,
		  back_sensor => back_sensor,
		  password_1 => password_1,
		  password_2 => password_2,
		  GREEN_LED => GREEN_LED,
		  RED_LED => RED_LED,
		  HEX_1 => HEX_1,
		  HEX_2 => HEX_2,
		  clk1ms => C1ms
	);
	
	u_sacn : Scandigit
	port map(
		clk => clk,
		rstb => reset_n,
		i1ms => C1ms,
		idigit1 => HEX_1,
		idigit2 => HEX_2,
		odigit => outDigit,
		odata => HEX
	);
	
	u_clk : CLK1ms
	port map(
		clk => clk,
		rstb=> reset_n,		
		o1ms => C1ms
	);
	
end Behavioral;

