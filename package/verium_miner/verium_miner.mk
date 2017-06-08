################################################################################
#
# verium_miner
#
################################################################################

VERIUM_MINER_VERSION = ffc4a8f64364ecc79d71fd4837ee7a7800ba4b0f
VERIUM_MINER_SITE = $(call github,effectsToCause,veriumMiner,$(VERIUM_MINER_VERSION))
VERIUM_MINER_DEPENDENCIES = zlib libcurl openssl jansson
VERIUM_MINER_AUTORECONF = YES
VERIUM_MINER_CONF_OPTS = --with-crypto --with-curl CFLAGS="$(TARGET_CFLAGS) -O3 -std=c99 -mfpu=neon-vfpv4 -mfloat-abi=hard -fomit-frame-pointer -ffast-math"

$(eval $(autotools-package))
