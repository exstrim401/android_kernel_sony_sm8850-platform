"""Native Kleaf dist with separate GKI and vendor module payloads."""
load("@bazel_skylib//rules:write_file.bzl", "write_file")
load("@rules_pkg//pkg:install.bzl", "pkg_install")
load("@rules_pkg//pkg:mappings.bzl", "pkg_files", "strip_prefix")
load("//common:modules.bzl", "get_gki_modules_list", "get_kunit_modules_list")

def pdx267_lineage_dist(vendor_modules):
    gki = get_gki_modules_list("arm64") + get_kunit_modules_list("arm64")
    write_file(
        name = "system_dlkm_load",
        out = "system_dlkm.modules.load",
        content = ["system_dlkm/" + p.split("/")[-1] for p in gki] + [""],
    )
    pkg_files(
        name = "lineage_gki_modules",
        srcs = ["//common:kernel_aarch64/" + p for p in gki],
        prefix = "system_dlkm",
        strip_prefix = strip_prefix.files_only(),
    )
    pkg_files(
        name = "lineage_vendor_modules",
        srcs = vendor_modules,
        strip_prefix = strip_prefix.files_only(),
    )
    pkg_files(
        name = "lineage_kernel_files",
        srcs = [
            "//common:kernel_aarch64/Image",
            "//common:kernel_aarch64/System.map",
            "//common:kernel_aarch64/modules.builtin",
            "//common:kernel_aarch64/modules.builtin.modinfo",
            "//common:kernel_aarch64/vmlinux",
            ":system_dlkm_load",
        ],
        strip_prefix = strip_prefix.files_only(),
    )
    pkg_install(
        name = "lineage_dist",
        srcs = [
            ":lineage_gki_modules",
            ":lineage_vendor_modules",
            ":lineage_kernel_files",
        ],
        destdir = "out/pdx267-lineage/dist",
    )
