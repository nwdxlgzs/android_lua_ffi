#ifndef LIB_HH
#define LIB_HH

#include "lua.hh"
extern "C" {
#ifdef __ANDROID__
#include <android/log.h>
#define LOG_TAG "lua"
#define LOGD(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)

#include "lobject.h"
#include "lfunc.h"
#include "lstate.h"
#include "ldo.h"
#endif
}
namespace lib {

using handle = void *;
using func = void (*)();

struct c_lib {
    handle h;
    int cache;
};

void load(c_lib *cl, char const *path, lua_State *L, bool global = false,bool bypass = false);

void close(c_lib *cl, lua_State *L);

void *get_sym(c_lib const *cl, lua_State *L, char const *name);

bool is_c(c_lib const *cl);

} /* namespace lib */

#endif /* LIB_HH */
