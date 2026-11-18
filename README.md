# Sony SM8850 platform

Qualcomm/Sony platform sources for **Sony Xperia 1 VIII (pdx267)**.
Based on the Sony **73.1.A.2.74** source archive, with changes for the
**73.1.A.2.100** LineageOS port.

Place this repository at `vendor/sony/pdx267` within the kernel workspace.

## Dependencies

| Workspace path | Source |
| --- | --- |
| `common` | AOSP GKI, commit `202a62288cb6884f0bdcea8a8d47a1a8c4d3e143` |
| `vendor/sony/pdx267-modules` | [External drivers](https://github.com/exstrim401/android_kernel_sony_pdx267-modules) |
| `vendor/sony/pdx267-devicetrees` | [Device trees](https://github.com/exstrim401/android_kernel_sony_pdx267-devicetrees) |
| `build/kernel` | [Sony/DDK Kleaf](https://github.com/exstrim401/android_kernel_sony_pdx267-kleaf) |

The Generic Kernel Image (GKI) uses unmodified AOSP common:
Linux 6.12.69, Android 16, Kernel Module Interface (KMI) generation 6,
and 4 KiB pages.

Use `manifests/pdx267-kernel.draft.xml` from the device tree for pinned
dependencies, toolchains, and workspace links.

## Build integration

`repo_paths.bzl` defines repository paths.
`lineage/BUILD.bazel` provides the distribution target:

```text
//vendor/sony/pdx267/lineage:lineage_dist
```

The distribution contains:

- The GKI kernel image.
- 416 vendor modules.
- 103 GKI modules in `system_dlkm/`.

Separate module directories preserve GKI and vendor modules with identical names.
The build also checks an additional `gpi` target, which it excludes from the distribution.

With the pdx267 device tree and dependencies in a LineageOS checkout,
build the kernel and modules with:

```sh
m -j16 kernel
```

The build signs the GKI modules with its own key.
Module signature protection, symbol version checks, and control-flow integrity remain enabled.
