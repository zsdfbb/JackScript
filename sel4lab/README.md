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

## 参考

https://docs.sel4.systems/Tutorials/setting-up.html