"""Canonical paths relative to kernel/platform/kernel-6.12."""

SOC_REPO_PATH = "vendor/sony/pdx267"
MODULES_REPO_PATH = "vendor/sony/pdx267-modules"
DEVICETREES_REPO_PATH = "vendor/sony/pdx267-devicetrees"

def soc_label(target):
    """Label in the platform package."""
    return "//{}:{}".format(SOC_REPO_PATH, target)

def modules_label(target):
    """Label in a modules subpackage, including its package:target suffix."""
    return "//{}/{}".format(MODULES_REPO_PATH, target)

def devicetrees_label(target):
    """Label in the device-tree package."""
    return "//{}:{}".format(DEVICETREES_REPO_PATH, target)
