# Packet Decoder - Verilog Directed Testbench

Directed Verilog testbench for `pkt_decoder`: valid CRC (dest AA), invalid CRC (dest BB), different destination (CC), and zero payload length.

## Layout
- `rtl/` - `pkt_decoder.sv` (DUT)
- `tb/` - `pkt_decoder_tb.v` (testbench)
- `eda_playground/` - `design.sv` (DUT) and `testbench.sv` (testbench with waveform dump), ready to paste

## Run on EDA Playground
Link: https://edaplayground.com/x/i_QH

Simulator: any (Icarus Verilog works since this is plain Verilog). Top module: `pkt_decoder_tb`.

## Results
<img width="1657" height="846" alt="image" src="https://github.com/user-attachments/assets/02b8e2fe-b5d6-4518-a2bf-9c9d13f0181b" />
<img width="1897" height="883" alt="image" src="https://github.com/user-attachments/assets/201c3166-e961-4768-916d-e7539b622996" />
