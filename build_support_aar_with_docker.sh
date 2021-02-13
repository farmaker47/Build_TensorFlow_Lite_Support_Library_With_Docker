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

# Setting variables
FLAG_CHECKPOINT="r2.4" # Change to latest when occur.

# Running inside docker container, download the SDK first.
android update sdk --no-ui -a \
  --filter tools,platform-tools,android-${ANDROID_API_LEVEL},build-tools-${ANDROID_BUILD_TOOLS_VERSION}

cd /tensorflow_src

# Run configure.
configs=(
  '/usr/bin/python3'
  '/usr/lib/python3/dist-packages'
  'N'
  'N'
  'N'
  'N'
  '-march=native -Wno-sign-compare'
  'y'
  '/android/sdk'
)
printf '%s\n' "${configs[@]}" | ./configure

# Pull the latest code from tensorflow.
git pull -a
git checkout ${FLAG_CHECKPOINT}

# Configure Bazel.
source tensorflow/tools/ci_build/release/common.sh
install_bazelisk

# Building with bazel.
export OMIT_PRINTING_OUTPUT_PATHS=YES
bash /tensorflow_src/tensorflow/lite/tools/build_support_aar.sh
