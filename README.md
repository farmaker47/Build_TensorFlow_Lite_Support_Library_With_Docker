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

<img src="images/download_tensorflow_devel.PNG" width="2560" height="540">

Copy, paste and run command `docker run -it -v pwd:/host_dir tf-support-builder bash` to start the container. After some seconds you will see:

<img src="images/start_container_command.PNG" width="2560" height="340">

## Import the script files at specific locations inside Docker container

To do this procedure we have to open a second Power shell window at the same folder where the scripts are. This is because at the first container we are already in Linux environment inside the container and we cannot move the files from Windows:

<img src="images/power_shell_here.PNG" width="2560" height="540">

We execute command `docker container ls --all` to find out the number of containers that exist and their names eg d40836790a39. After that we move the 2 script files and the folder that contains the TensorFlow Lite Support libray inside specific locations of the container:
- First execute `docker cp build_support_aar.sh d40836790a39:/tensorflow_src/tensorflow/lite/tools/` to insert it at `d40836790a39` container and inside `tensorflow_src/tensorflow/lite/tools` folder
- Second move tensorflow_lite_support folder inside the container by executing `docker cp tensorflow_lite_support d40836790a39:/tensorflow_src` 
- Third execute `docker cp build_support_aar_with_docker.sh d40836790a39:/` to move the second script file at the container

<img src="images/3_commands_at_container.PNG" width="2560" height="340">

CAUTION: name of the container always change so do not use `d40836790a39` but find out yours and replace at the above 3 commands.

## Go back at the first Power Shell window and execute linux commands

First execute `ls` to view the files

Second make the script file executable by inserting and running `chmod +x build_support_aar_with_docker.sh`

Third set the location of the Python library by inserting and running: `sudo ln -sf /usr/bin/python3 /usr/bin/python`

Finally copy paste `./build_support_aar_with_docker.sh` and run it.

Now procedure runs, responde "Yes" to Google's License agreement and neccessary libraries are downloaded.
After 5-10 minutes build will be successful.








