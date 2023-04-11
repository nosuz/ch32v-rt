This is minimum runtime and start routine for Rust programs on WCH CH32V103 and is forked from [riscv-rt](https://github.com/rust-embedded/riscv-rt).

CH32V103 has QingKe V3 RISC-V processor. the processor has RV32IMAC ISA and doesn't support Supervisor mode. So, most of codes not used on this processor is removed.

Please also refer original [README](README_riscv-rt.md) and [its repository](https://github.com/rust-embedded/riscv-rt).

Finally I am very happy to receiving any comments and advices.

Thank you

## Configurations

### Cargo.toml

Set MPU specific feature to use interrupts. The "interrupt" feature is enabled when MPU specific feature is enabled.

MPU specific feature is optional. But all methods related to exceptions and interrupts are not exist if not enabled them. So if any exception or interrupts will make bad thing.

The interrupt vector fo CH32V must align 1kb and binary size will be larger than 1kb if interrupt feature is enabled.

```
[dependencies.ch32v-rt]
git = "https://github.com/nosuz/ch32v-rt.git"
# set MPU specific feature to use interrupts.
features = ["ch32v103"]

```

### .cago/config.toml

Add linker options to include link_int.x in ch32-rt and device.x in MPU specific PAC.

```
[build]
target = "riscv32imac-unknown-none-elf"

[target.riscv32imac-unknown-none-elf]
rustflags = [
  "-C", "link-arg=-Tmemory.x",
  # with interrupts
  "-C", "link-arg=-Tlink_int.x",
  "-C", "link-arg=-Tdevice.x",
  # to minimize binary by omitting interrupts
  #"-C", "link-arg=-Tlink.x",
  # #"-C", "link-arg=-Tdevice.x",

]

```
