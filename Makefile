
export ARCHS = armv7 arm64
export TARGET = iphone:clang:9.2

include theos/makefiles/common.mk

TWEAK_NAME = relogin
relogin_FRAMEWORKS = Security UIKit

relogin_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
