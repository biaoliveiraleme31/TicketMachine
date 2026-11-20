library ieee;
use ieee.std_logic_1164.all;

entity KT_Mux6x1 is 
	port(
		Start    : in std_logic;
		K        : in std_logic_vector(3 downto 0);
		Stop     : in std_logic;
		Selector : in std_logic_vector(2 downto 0);
		Y        : out std_logic
	);
end KT_Mux6x1;

architecture logic of KT_Mux6x1 is

component Mux2x1 is
	port(
		A : in std_logic;
		B : in std_logic;
		S : in std_logic;
		Y : out std_logic
	);
end component;

signal Mux01_out : std_logic;
signal Mux02_out : std_logic;
signal Mux03_out : std_logic;
signal Mux11_out : std_logic;
signal Mux12_out : std_logic;
signal Mux21_out : std_logic;

begin
Mux01 : Mux2x1
	port map(
		A => K(0),
		B => K(1),
		S => Selector(0),
		Y => Mux01_out
	);
	
Mux02 : Mux2x1
	port map(
		A => K(2),
		B => K(3),
		S => Selector(0),
		Y => Mux02_out
	);
	
Mux03 : Mux2x1
	port map(
		A => Start,
		B => Stop,
		S => Selector(0),
		Y => Mux03_out
	);
	
Mux11 : Mux2x1
	port map(
		A => Mux01_out,
		B => Mux02_out,
		S => Selector(1),
		Y => Mux11_out
	);
	
Mux12 : Mux2x1
	port map(
		A => Mux03_out,
		B => '0',
		S => Selector(1),
		Y => Mux12_out
	);
	
Mux21 : Mux2x1
	port map(
		A => Mux11_out,
		B => Mux12_out,
		S => Selector(2),
		Y => Mux21_out
	);
	
Y <= Mux21_out;

end logic;