library ieee;
use ieee.std_logic_1164.all;

entity KT_Datapath is
    port(
        MClk     : in std_logic;
        TXclk    : in std_logic;
        K        : in std_logic_vector(3 downto 0);
		  KBfree	  : in std_logic;
        Load     : in std_logic;
        TXEnable : in std_logic;
        ClrCnt   : in std_logic;
        Rst      : in std_logic;
        Count    : out std_logic_vector(2 downto 0);
        TXD      : out std_logic
    );
end KT_Datapath;

architecture structural of KT_Datapath is

    component Register_4bit IS
    PORT(
        CLK   : in  STD_LOGIC;
        Rst   : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        D_IN  : in  STD_LOGIC_VECTOR(3 downto 0);
        Q_OUT : out STD_LOGIC_VECTOR(3 downto 0)
    );
   END component;

    component KT_Counter is
        port(
            TXclk    : in std_logic;
            TXEnable : in std_logic;
            ClrCnt   : in std_logic;
            Rst      : in std_logic;
            Q        : out std_logic_vector(2 downto 0)
        );
    end component;

    component KT_Mux8x1 is  
        port(
            Start0   : in std_logic;
            Start1   : in std_logic;
            K        : in std_logic_vector(3 downto 0);
            Stop0    : in std_logic;
            Stop1    : in std_logic;
            Selector : in std_logic_vector(2 downto 0);
            Y        : out std_logic
        );
    end component;

    signal K_reg_s : std_logic_vector(3 downto 0);
    signal Count_s : std_logic_vector(2 downto 0);
    signal TXD_mux : std_logic;

begin

    Reg1 : Register_4bit
        port map(
            CLK   => Load,
            Rst     => Rst,
            EN  => KBfree,
            D_IN  => K,
            Q_OUT => K_reg_s
        );

    Counter1 : KT_Counter
        port map(
            TXclk    => TXclk,
            TXEnable => TXEnable,
            ClrCnt   => ClrCnt,
            Rst      => Rst,
            Q        => Count_s
        );

    DataMux : KT_Mux8x1
        port map(
            Start0   => '0',
            Start1   => '1',
            K        => K_reg_s,
            Stop0    => '0',
            Stop1    => '1',
            Selector => Count_s,
            Y        => TXD_mux
        );	  

    Count <= Count_s;

    TXD <= TXD_mux when TXEnable = '1' else '1';

end structural;