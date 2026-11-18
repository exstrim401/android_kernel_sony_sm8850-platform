def register_modules(registry):
    registry.register(
        name = "drivers/mmc/core/mmc_error_logging",
        out = "mmc_error_logging.ko",
        config = "CONFIG_MMC_ERROR_LOGGING",
        srcs = [
            # do not sort
            "drivers/mmc/core/mmc_error_logging.c",
        ],
        deps = [
            "kernel/fels/fels",
            "//vendor/sony/pdx267:fels_headers",
            "//vendor/sony/pdx267:fels_uapi_headers",
        ],
    )
