# Build TensorFlow Lite Support Library With Docker

This is an extended guide that illustrates how to build Tensorflow Lite Support library with [Docker](https://www.docker.com/) inside Windows. This procedure is useful to developers that want to make changes to the library but they haven't installed [Bazel](https://bazel.build/) to their system. After build procedure the developer can obtain an .aar file that can be used inside an Android Studio project.

## First install Docker
If you have already Docker in your system then you can skip this part. If not go to the official page, download [Docker for Windows](https://www.docker.com/products/docker-desktop) and install Docker in your system. Run Docker desktop and if it prompts to upgrade WSL 2 then do this procedure also. After a restart of your PC run again to start Docker. You will see at your desktop the main window:

<img src="images/docker_main.PNG" width="2560" height="540">

## Then collect neccessary files and start a container
Create a new folder and insert the 3 important files (that you can find here at the main branch) inside (build_support_aar_with_docker.sh, build_support_aar.sh and tflite-android.Dockerfile):

<img src="images/3_files.PNG" width="2560" height="540">

Click Shift + Right click of mouse and open a PowerShell window inside the folder that contains the 3 files:

<img src="images/power_shell_here.PNG" width="2560" height="540">

Then copy, paste command `docker build . -t tf-support-builder -f tflite-android.Dockerfile` inside the Powershell window that has been opened:

<img src="images/paste_command.PNG" width="2560" height="340">

Hit Enter and Docker starts downloading TensorFlow latest code, Android SDK and NDK:

