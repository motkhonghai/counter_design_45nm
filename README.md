# Counter 8-bit trên công nghệ 45 nm — Kết quả Synthesis & Physical Design

Tài liệu này tổng kết kết quả của hệ thống thiết kế: RTL → Synthesis (Genus) →
Physical Design (Innovus Stylus). Các số liệu được lấy trực tiếp từ report trong
`synthesis/reports/mmmc/` và `physical_design/reports/mmmc/`.

## 1. Tổng quan thiết kế

| Mục | Giá trị |
|---|---|
| Chức năng | Counter 8-bit, reset bất đồng bộ (`rtl/counter.v`) |
| Công nghệ | GPDK045 (45 nm), thư viện `slow_vdd1v0` / `fast_vdd1v0` |
| Clock | `clk`, chu kỳ **10 ns (100 MHz)** |
| MMMC views | `view_wcl_slow` (PVT 0.9 V / 125 °C), `view_wcl_fast` (PVT 1.1 V / 0 °C) |
| Tools | Cadence Genus 25.1 + Innovus 25.1 (Stylus Common UI) |

## 2. Tóm tắt kết quả

| Chỉ tiêu | Synthesis (Genus) | Physical (Innovus) |
|---|---|---|
| Instance count | 20 (8 seq + 12 comb) | 20 |
| Cell area | 72.846 µm² | 72.846 µm² |
| Net area | 23.890 µm² | — |
| Total area | 96.736 µm² | — |
| Setup slack (`view_wcl_slow`) | +8.017 ns (MET) | **+8.680 ns (MET)** |
| Hold slack (`view_wcl_fast`) | — | **+0.058 ns (MET)** |
| Total power | 3.057 µW | 2.815 mW * |
| DRC | — | 0 violation |
| Connectivity | — | 0 violation, 0 warning |

\* Khác biệt giữa hai bước do hoạt động (activity factor / vector) khác nhau giữa
hai lần report.

## 3. Chi tiết Synthesis (Genus)

- **Area** (`counter_area.rpt`): 20 cell; cell area 72.846 µm², net area 23.890 µm²,
  total area 96.736 µm². Sequential chiếm 68.5%, logic 31.5%.
- **Gates** (`syn_opt_gates.rpt`): ADDHX1 ×1, DFFRHQX1 ×7, DFFRX1 ×1, NAND2X1 ×3,
  NOR2BX1 ×2, OA21X1 ×3, XNOR2X1 ×3.
- **Power** (`counter_power.rpt`): total 3.057 µW — leakage 1.603 nW (0.05%),
  internal 2.561 µW (83.8%), switching 0.495 µW (16.2%).
- **QoR** (`syn_opt_qor.rpt`): 0 violating path, TNS 0 ở cả hai view; critical path
  slack 8017 ps (`view_wcl_slow`).

## 4. Chi tiết Physical Design (Innovus, theo từng stage)

| Stage | Setup (MET) | Hold (MET) |
|---|---|---|
| 2 – Floorplan / power | +8.679 ns | — |
| 3 – Placement | +8.668 ns | — |
| 4 – CTS / CCOpt | +8.713 ns | +0.058 ns |
| 5 – Routing | +8.711 ns | +0.058 ns |
| 6 – Chip finish | +8.680 ns | +0.058 ns |

- **Area** (`6_chip_finish/area.rpt`): 20 instance, total area 72.846 µm².
- **Power** (`6_chip_finish/power.rpt`): total 2.815 mW — sequential 90.83%,
  combinational 9.17%.
- **DRC** (`6_chip_finish/drc.rpt`): 0 violation.
- **Connectivity** (`6_chip_finish/connectivity.rpt`): 0 violation, 0 warning.

## 5. Danh mục report

- **Synthesis** — `synthesis/reports/mmmc/`:
  `counter_area`, `counter_gates`, `counter_power`, `counter_qor`,
  `counter_pre_synthesis_timing`, `final`, `syn_generic_*`, `syn_map_*`, `syn_opt_*`.
- **Physical Design** — `physical_design/reports/mmmc/<stage>/`:
  `timing`, `setup`, `hold`, `area`, `power`, `drc`, `connectivity`.
