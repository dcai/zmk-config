# ZMK Config Project Guide

This is a personal ZMK (Zephyr Mechanical Keyboard) firmware configuration repository for multiple split and non-split keyboards.

## Project Overview

This repo contains keymap configurations and build automation for:
- **Sweep (cradio)** - 34-key split keyboard (daily driver)
- **Reviung34** - 34-key unibody with RGB underglow
- **Reviung5** - 5-key macropad

## Directory Structure

```
.
├── config/
│   ├── west.yml           # ZMK west manifest
│   ├── 34.dtsi            # Shared 34-key keymap (included by cradio & reviung34)
│   ├── cradio.keymap      # Sweep keyboard (includes 34.dtsi)
│   ├── reviung34.keymap   # Reviung34 (includes 34.dtsi)
│   ├── reviung5.keymap    # Reviung5 standalone keymap
│   ├── cradio.conf        # Sweep-specific ZMK config
│   └── reviung34.conf     # Reviung34-specific ZMK config (RGB, sleep)
├── build_matrix/
│   ├── sweep.yaml         # Build targets for Sweep
│   ├── reviung34.yaml     # Build targets for Reviung34
│   ├── reviung5.yaml      # Build targets for Reviung5
│   └── reset.yaml         # Settings reset firmware
├── .github/workflows/
│   ├── sweep.yaml         # CI for Sweep builds
│   ├── reviung34.yaml     # CI for Reviung34 builds
│   ├── reviung5.yaml      # CI for Reviung5 builds
│   ├── settings_reset.yaml # CI for reset firmware
│   └── draw-keymaps.yaml  # Auto-generate keymap SVGs
├── assets/                # Generated keymap SVG images
├── build.sh               # Helper script to generate keymap visuals
└── Makefile               # Commands for keymap-drawer
```

## Keymap Architecture

### Shared 34-Key Layout (`config/34.dtsi`)

Both Sweep (cradio) and Reviung34 share the same base keymap via `#include "34.dtsi"`. This enables consistent typing experience across both keyboards.

**Layout (3x5 + 2 thumb keys per side):**
```
  0   1   2   3   4  |  5   6   7   8   9
 10  11  12  13  14  | 15  16  17  18  19
 20  21  22  23  24  | 25  26  27  28  29
            30  31  | 32  33
```

### Layers

1. **base** (Layer 0) - Default typing layer with home-row mods
2. **symbols** (Layer 1) - Symbols and brackets (accessed via `SYM()` on right thumb)
3. **numbers** (Layer 2) - Numpad + navigation + Bluetooth (accessed via `NUM()` on left thumb)
4. **config** (Layer 3) - RGB, Bluetooth, boot controls (accessed via `CFG()` on Z key)
5. **blank** (Layer 4) - Empty layer for locking keyboard during transit

### Key Behaviors & Macros

Defined macros in `34.dtsi`:
- `L1(k1)` / `SYM(k1)` - Layer tap for symbols
- `L2(k1)` / `NAV(k1)` / `NUM(k1)` - Layer tap for numbers/navigation
- `L3(k1)` / `CFG(k1)` - Layer tap for config
- `LAT(k1)` - Hold: Left Alt, Tap: key
- `LGT(k1)` - Hold: Left GUI, Tap: key
- `ST(k1)` - Hold: Left Shift, Tap: key
- `CT(k1)` - Hold: Left Ctrl, Tap: key
- `HOLD_PREFER_GUI(k1)` / `hp` behavior - GUI-focused hold-tap
- `HG(k1)` - GUI + key combo
- `ENTER` - GUI + Return (hold-preferred)
- `BT(k1)` - Bluetooth select profile 0-4
- `BTC` - Clear all Bluetooth bonds
- `BOOT` - Enter bootloader mode

### Combos (34-key layout)

- `DF` (keys 12+13) → Escape
- `QW` (keys 0+1) → Escape
- `NM` (keys 26+27) → Volume Down
- `M,<` (keys 27+28) → Volume Up
- `ER` (keys 13+16) → Caps Word

## ZMK Configuration

### Sleep & Power Management

Both keyboards use:
- `CONFIG_ZMK_SLEEP=y` - Enable deep sleep
- `CONFIG_ZMK_IDLE_TIMEOUT=30000` - 30s to idle (backlight off)
- `CONFIG_ZMK_IDLE_SLEEP_TIMEOUT=1800000` - 30min to deep sleep

### Reviung34 RGB Settings

- `CONFIG_ZMK_RGB_UNDERGLOW=y` - Enable underglow
- `CONFIG_ZMK_RGB_UNDERGLOW_EFF_START=3` - Start with effect #3
- `CONFIG_ZMK_RGB_UNDERGLOW_BRT_START=50` - 50% brightness

## Build System

### Local Development

```bash
# Install keymap-drawer locally
make install

# Or install via pipx
make pipx-keymap

# Generate keymap SVGs
make                    # All keyboards
make draw-cradio        # Sweep only
make draw-reviung34     # Reviung34 only
make draw-reviung5      # Reviung5 only
```

### GitHub Actions CI

Each keyboard has its own workflow that triggers on:
- Push to main affecting relevant files
- Pull requests
- Manual dispatch

Builds use ZMK's official `build-user-config.yml` reusable workflow.

### Updating ZMK Version

When changing the ZMK version for this repo, update both of these places together:

1. `config/west.yml`
   - Update `revision:` for the `zmk` project
2. `.github/workflows/*.yaml`
   - Update `zmkfirmware/zmk/.github/workflows/build-user-config.yml@...`

Keep the version aligned in both places.

Example:

```yaml
# config/west.yml
revision: v0.2.1
```

```yaml
# .github/workflows/reviung34.yaml
uses: zmkfirmware/zmk/.github/workflows/build-user-config.yml@v0.2.1
```

Notes:
- Pinning to a release is safer than tracking `main`
- Tracking `main` can break builds when ZMK or Zephyr changes upstream
- If builds suddenly fail after working before, check whether the repo is following `main`

### ZMK v0.4.0 Upgrade Guide

When `v0.4.0` is released, use this checklist to upgrade safely:

1. Update pinned ZMK version in both places:
   - `config/west.yml`
   - `.github/workflows/*.yaml`
2. Update build matrix board names:
   - `nice_nano_v2` -> `nice_nano//zmk`
   - or use the explicit form `nice_nano@2.0.0//zmk`
3. Re-run all firmware builds:
   - `build_matrix/reviung34.yaml`
   - `build_matrix/sweep.yaml`
   - `build_matrix/reviung5.yaml`
   - `build_matrix/reset.yaml`
4. Verify artifacts build successfully for:
   - Reviung34
   - Sweep left/right
   - Reviung5
   - settings reset
5. Flash and test at least one board before changing more:
   - USB
   - Bluetooth
   - keymap behavior
   - sleep/wake

Notes for v0.4.0:
- The Zephyr 4.1 update changes ZMK board naming
- `nice_nano_v2` is replaced by `nice_nano//zmk`
- Shields should not need HWMv2 migration
- This repo uses in-tree boards/shields, so only build target naming should need changes

### Build Matrix Format

**Simple format** (sweep, reviung5):
```yaml
board:
  - nice_nano_v2
shield:
  - cradio_left
  - cradio_right
```

**Extended format** (reviung34):
```yaml
include:
  - shield: reviung34
    board: nice_nano_v2
    keymap: config/reviung34.keymap
```

## Keymap Visuals

Keymap SVGs are auto-generated using [keymap-drawer](https://github.com/caksoylar/keymap-drawer) and committed to `assets/`.

The `build.sh` script:
1. Parses `.keymap` files to YAML
2. Renders YAML to SVG

## Common Tasks

### Add a new combo

Edit `config/34.dtsi` in the `combos` node:

```dts
combo_name {
    timeout-ms = <50>;
    key-positions = <key1 key2>;
    bindings = <&kp KEYCODE>;
};
```

### Add a new layer

1. Add layer definition in `34.dtsi` (or specific `.keymap`)
2. Create layer tap macro if needed: `#define NEWLAYER(k1) &lt N k1`
3. Add layer bindings in `/ { keymap { ... } };`

### Modify hold-tap timing

Edit behavior timing in `34.dtsi`:
```dts
&mt {
    tapping-term-ms = <200>;    // Time to trigger hold
    quick-tap-ms = <180>;       // Time for repeat tap
};
```

### Change Bluetooth device name

Edit `config/*.conf`:
```
CONFIG_ZMK_KEYBOARD_NAME="New Name"
```

## Important Notes

- **34.dtsi is shared** - Changes affect both Sweep and Reviung34
- **Reviung5 has its own keymap** - Completely separate from the 34-key layout
- **Combos use key positions** - Not keycodes; positions are 0-33 for 34-key layout
- **West manifest** - Points to `zmkfirmware/zmk` main branch
- **Firmware builds** - Available in GitHub Actions artifacts

## References

- [ZMK Documentation](https://zmk.dev/docs)
- [ZMK Keymap Behaviors](https://zmk.dev/docs/keymaps/behaviors)
- [Keymap Drawer](https://github.com/caksoylar/keymap-drawer)
- [Sweep Keyboard](https://github.com/davidphilipbarr/Sweep)
- [Reviung34](https://github.com/gtips/reviung)
