# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../../../" && pwd)"

function print_output {
  if [ -z OMIT_PRINTING_OUTPUT_PATHS ]; then
    echo "Output can be found here: bazel-bin/tensorflow_lite_support/java/libtensorflowlite_support.jar"
  fi
}

# Check command line flags.
TARGET_ARCHS=x86,x86_64,arm64-v8a,armeabi-v7a
# If the environmant variable BAZEL_CACHE_DIR is set, use it as the user root
# directory of bazel.
if [ ! -z ${BAZEL_CACHE_DIR} ]; then
  CACHE_DIR_FLAG="--output_user_root=${BAZEL_CACHE_DIR}/cache"
fi

# Check if users have already run configure
cd $ROOT_DIR
if [ ! -f "$ROOT_DIR/.tf_configure.bazelrc" ]; then
  echo "ERROR: Please run ./configure first."
  exit 1
else
  if ! grep -q ANDROID_SDK_HOME "$ROOT_DIR/.tf_configure.bazelrc"; then
    echo "ERROR: Please run ./configure with Android config."
    exit 1
  fi
fi

# Build the support jar file.
if [ -z ${FLAG_MODELS} ]; then
  bazel ${CACHE_DIR_FLAG} build -c opt --cxxopt='--std=c++14' \
    --config=monolithic \
    --fat_apk_cpu=${TARGET_ARCHS} \
    --host_crosstool_top=@bazel_tools//tools/cpp:toolchain \
    //tensorflow_lite_support/java:tensorflow-lite-support

  print_output
  exit 0
fi
