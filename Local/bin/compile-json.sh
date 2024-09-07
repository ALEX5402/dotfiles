#!/bin/bash

# Set the NDK path
NDK_PATH="/opt/android-ndk"

# Get the current directory
CURRENT_DIR=$(pwd)

# Define the output path for the obj directory
OBJ_DIR="${CURRENT_DIR}/obj"

# Create the JSON structure
cat <<EOL > compile_commands.json
{
  "buildFiles": [
    "${CURRENT_DIR}/Android.mk",
    "${CURRENT_DIR}/Application.mk"
  ],
  "cleanCommandsComponents": [
    [
      "${NDK_PATH}/ndk-build",
      "NDK_PROJECT_PATH=null",
      "APP_BUILD_SCRIPT=${CURRENT_DIR}/Android.mk",
      "NDK_APPLICATION_MK=${CURRENT_DIR}/Application.mk",
      "NDK_DEBUG=1",
      "clean"
    ]
  ],
  "libraries": {
    "MyLibName-debug": {
      "buildCommandComponents": [
        "${NDK_PATH}/ndk-build",
        "NDK_PROJECT_PATH=null",
        "APP_BUILD_SCRIPT=${CURRENT_DIR}/Android.mk",
        "NDK_APPLICATION_MK=${CURRENT_DIR}/Application.mk",
        "NDK_DEBUG=1",
        "${OBJ_DIR}/local/\$APP_ABI/libMyLibName.so"
      ],
      "output": "${OBJ_DIR}/local/\$APP_ABI/libMyLibName.so"
    },
    "xdl-debug": {
      "buildCommandComponents": [
        "${NDK_PATH}/ndk-build",
        "NDK_PROJECT_PATH=null",
        "APP_BUILD_SCRIPT=${CURRENT_DIR}/Android.mk",
        "NDK_APPLICATION_MK=${CURRENT_DIR}/Application.mk",
        "NDK_DEBUG=1",
        "${OBJ_DIR}/local/\$APP_ABI/libxdl.a"
      ],
      "output": "${OBJ_DIR}/local/\$APP_ABI/libxdl.a"
    },
    "Server-debug": {
      "buildCommandComponents": [
        "${NDK_PATH}/ndk-build",
        "NDK_PROJECT_PATH=null",
        "APP_BUILD_SCRIPT=${CURRENT_DIR}/Android.mk",
        "NDK_APPLICATION_MK=${CURRENT_DIR}/Application.mk",
        "NDK_DEBUG=1",
        "${OBJ_DIR}/local/\$APP_ABI/libServer.so"
      ],
      "output": "${OBJ_DIR}/local/\$APP_ABI/libServer.so"
    }
  },
  "toolchains": {
    "toolchain": {
      "cCompilerExecutable": "${NDK_PATH}/toolchains/llvm/prebuilt/linux-x86_64/bin/clang",
      "cppCompilerExecutable": "${NDK_PATH}/toolchains/llvm/prebuilt/linux-x86_64/bin/clang++"
    }
  },
  "cFileExtensions": [
    "c"
  ],
  "cppFileExtensions": [
    "cpp"
  ]
}
EOL

echo "compile_commands.json has been generated in the current directory."

# Create a .clangd file in the current directory
cat <<EOL > .clangd
CompileFlags:
  Add:
    - -std=c++14  # Use C++14 standard; adjust if needed
    - -I/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include  # NDK headers
    - -I/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/x86_64-linux-android/asm  # Android platform headers
    - -I/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/aarch64-linux-android/asm  # Android platform headers
    - -I/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/arm-linux-androideabi/asm  # Android platform headers
    - -I/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/i686-linux-android/asm  # Android platform headers
    - -I/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/riscv64-linux-android/asm  # Android platform headers
    - -I/usr/include  # System headers
    - -I$CURRENT_DIR  # Current project headers
    - -DANDROID  # Define for Android
    - -fexceptions  # Enable exception handling
    - -funwind-tables  # Enable stack unwinding
    - -frtti  # Enable run-time type information
  Remove:
    - -W*  # Remove all warning flags if needed

CompilationDatabase:
  Ancestors: true  # Look for compile_commands.json in parent directories

Index:
  Background: Build  # Enable background indexing

Diagnostics:
  ClangTidy:
    Add:
      - modernize-*  # Enable all modernize checks
    Remove:
      - modernize-use-trailing-return-type  # Exclude a specific check

InlayHints:
  Enabled: true
  ParameterNames: true
  DeducedTypes: true

# Optional: Customize the indexing behavior
Index:
  StandardLibrary: No  # Disable eager indexing of the standard library

# Optional: Configure unused includes diagnostics
Diagnostics:
  UnusedIncludes: Strict  # Enable strict checks for unused includes
EOL

# Output success message
echo ".clangd file generated successfully in $CURRENT_DIR"
