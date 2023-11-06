## zmk-config

[Firmware builds](https://github.com/dcai/zmk-config/actions)

My daily drivers are Reviung34 and Sweep Bling MX, they are both 34 keys, they share the same [zmk keymap file](./config/34.dtsi).

Besides the common `symbols`, `numbers` and `config` layers, there is a blank layer for locking purpose, during transit I could lock keyboard to this layer to avoid triggering key press, unlock (`&to 0`) it via combo when I want to use it.

[Sweep](https://github.com/davidphilipbarr/Sweep/tree/main/Sweep%20Bling%20MX) keymap:

```
                    == layout and key index ==

 +----+----+----+----+----+            +----+----+----+----+----+
 |  0 |  1 |  2 |  3 |  4 |            |  5 |  6 |  7 |  8 |  9 |
 +----+----+----+----+----+            +----+----+----+----+----+
 | 10 | 11 | 12 | 13 | 14 |            | 15 | 16 | 17 | 18 | 19 |
 +----+----+----+----+----+            +----+----+----+----+----+
 | 20 | 21 | 22 | 23 | 24 |            | 25 | 26 | 27 | 28 | 29 |
 +----+----+----+----+----+----+  +----+----+----+----+----+----+
                     | 30 | 31 |  | 32 | 33 |
                     +----+----+  +----|----+


```

![keymap](./assets/cradio-keymap.svg)

Generated by @caksoylar's [keymap-drawer](https://github.com/caksoylar/keymap-drawer)

### Other keyboards

- [reviung34](./reviung34.md)
- [reviung5](./reviung5.md)
