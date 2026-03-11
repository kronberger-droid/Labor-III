# Labor III — Physics Laboratory Reports

Lab reports for **Labor III** at TU Wien (Faculty of Physics), written in [Typst](https://typst.app/).

**Authors:** Raul Wagner & Martin Kronberger

## Experiments

| Directory | Experiment | Topic |
|-----------|-----------|-------|
| `Cp/` | Specific Heat of Solids | Specific heat capacity of Holmium at low temperatures (80K–300K) |
| `EModul/` | Elasticity Modulus | Young's modulus of various materials via tension rod and bending beam |
| `Roentgen/` | X-Ray Physics | X-ray attenuation and Lambert's law verification |
| `ESR/` | Electron Spin Resonance | ESR detection in DPPH samples |
| `Wp/` | Heat Pump | Analysis of a compression heat pump refrigeration cycle |

## Building

Each experiment directory contains a `flake.nix` for a reproducible development environment. With [Nix](https://nixos.org/) installed:

```sh
cd <experiment>/
nix develop
typst compile main.typ main.pdf
```

Or use watch mode for live preview:

```sh
typst watch main.typ main.pdf
```

## Structure

Each experiment follows the same layout:

- `main.typ` — Main document
- `lab-report.typ` — Shared report template
- `lib.typ` — Helper functions for data parsing and analysis
- `assets/` — Setup diagrams and images
- `data/` — Raw measurement data (`.lvm`, `.data`)

Data analysis and plotting are done directly in Typst using the [lilaq](https://github.com/lilaq-project/lilaq) library.

## License

This project is licensed under the [MIT License](LICENSE).

