# seL4 Lab

## 配置环境并运行

**依赖:** git、make、docker

**环境:**
./init.sh

init.sh 对self4的kernel构建进行调整，方便构建出clangd依赖的 compile_commands.json
修改内容：

```text
seL4test/kernel$ git diff
diff --git a/config.cmake b/config.cmake
index 7c97174af..16a5fdfcc 100644
--- a/config.cmake
+++ b/config.cmake
@@ -601,3 +601,4 @@ if(DEFINED KernelDTSList AND (NOT "${KernelDTSList}" STREQUAL ""))
 endif()
 
 add_config_library(kernel "${configure_string}")
+set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
```

**编译运行**

./build.sh
./run.sh

**调试**

修改下面的配置，开启debug模式：

```text
diff --git a/config.cmake b/config.cmake
index 7c97174af..c11daaf4e 100644
--- a/config.cmake
+++ b/config.cmake
@@ -242,7 +242,7 @@ config_option(
     "When enabled this configuration option prevents the usage of any other options that\
     would compromise the verification story of the kernel. Enabling this option does NOT\
     imply you are using a verified kernel."
-    DEFAULT ON
+    DEFAULT OFF
 )
```

## 参考

https://docs.sel4.systems/Tutorials/setting-up.html