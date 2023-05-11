LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libffi
LOCAL_SRC_FILES := \
	src/closures.c \
	src/debug.c \
	src/java_raw_api.c \
	src/prep_cif.c \
	src/raw_api.c \
	src/types.c
LOCAL_SRC_FILES += ast.cc ffi.cc ffilib.cc lib.cc lua.cc main.cc parser.cc util.cc byopen_android.c
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../lua
LOCAL_STATIC_LIBRARIES := luajava

LOCAL_CFLAGS := -DFFI_LITTLE_ENDIAN
LOCAL_LDLIBS += -L$(SYSROOT)/usr/lib -llog -ldl



ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
LOCAL_SRC_FILES += \
	src/arm/sysv.S \
	src/arm/ffi.c
LOCAL_C_INCLUDES += $(LOCAL_PATH)/linux-arm
endif

ifeq ($(TARGET_ARCH_ABI), arm64-v8a)
LOCAL_SRC_FILES += \
	src/aarch64/sysv.S \
	src/aarch64/ffi.c
LOCAL_C_INCLUDES += $(LOCAL_PATH)/linux-arm64
endif

ifeq ($(TARGET_ARCH_ABI), x86)
LOCAL_SRC_FILES += \
	src/x86/sysv.S \
	src/x86/ffi.c
LOCAL_C_INCLUDES += $(LOCAL_PATH)/linux-x86
endif

ifeq ($(TARGET_ARCH_ABI), x86_64)
LOCAL_SRC_FILES += \
	src/x86/ffi64.c \
	src/x86/ffiw64.c \
	src/x86/unix64.S \
	src/x86/win64.S
LOCAL_C_INCLUDES += $(LOCAL_PATH)/linux-x86
endif


include $(BUILD_SHARED_LIBRARY)