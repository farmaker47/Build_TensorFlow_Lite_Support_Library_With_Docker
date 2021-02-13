# Build TensorFlow Lite Support Library With Docker

This is an extended guide that illustrates how to build Tensorflow Lite Support library with [Docker](https://www.docker.com/) inside Windows. This procedure is useful to developers that want to make changes to the library but they haven't installed [Bazel](https://bazel.build/) to their system. After build procedure the developer can obtain an .aar file that can be used inside an Android Studio project.

## First install Docker
If you have already Docker in your system then you can skip this part. If not go to the official page, download [Docker for Windows](https://www.docker.com/products/docker-desktop) and install Docker in your system. Run Docker desktop and if it prompts to upgrade WSL 2 then do this procedure also. After a restart of your PC run again to start Docker. You will see at your desktop the main window:
