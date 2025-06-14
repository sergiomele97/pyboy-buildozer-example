
 # This is a basic example of how to build a pyboy application that runs on android using buildozer (kivi framework).

 => The application on main.py just creates an instance of pyboy that runs an open source .gbc game, takes a frame and prints it on the bottom left corner of the mobile screen, as an indicator that it is working properly.

 ![screenshot](screenshot.jpg)

 !¡ Buildozer is not supported on windows so either use linux (I'm using ubuntu with KDE plasma (its great, try it!!))
 Or you can use Windows Subsystem for Linux which also works great.

 To make things easier, I have the other_builds folder on the root of this repository, so this is kind of heavy when you download it.

 2 options:
 
 # 1. If you just want to reproduce it FAST:
       1.1 open you terminal and execute this to create a virtual environment with all the dependencies


```
# ACTUALIZAR SISTEMA
sudo apt update && sudo apt upgrade -y
# INSTALAR DEPENDENCIAS DEL SISTEMA
sudo apt install -y \
    build-essential \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    openjdk-17-jdk \
    zip unzip \
    git \
    autoconf \
    automake \
    libtool \
    pkg-config \
    zlib1g-dev \
    libncurses5 \
    libncurses5-dev \
    libffi-dev \
    libssl-dev \
    libsqlite3-dev \
    libjpeg-dev \
    adb \
    curl
# ACTUALIZAR pip A 25.1.1 CONCRETAMENTE
python3.10 -m pip install --upgrade pip==25.1.1
# CREAR ENTORNO VIRTUAL
python3.10 -m venv kivy_env
source kivy_env/bin/activate
# VERIFICAR VERSIONES
echo "Python version:" && python --version
echo "Pip version:" && pip --version
# INSTALAR LIBRERÍAS EXACTAS DESDE AQUÍ
pip install \
    appdirs==1.4.4 \
    build==1.2.2.post1 \
    buildozer==1.5.0 \
    certifi==2025.4.26 \
    charset-normalizer==3.4.2 \
    colorama==0.4.6 \
    Cython==3.1.1 \
    distlib==0.3.9 \
    distro==1.9.0 \
    docutils==0.21.2 \
    exceptiongroup==1.3.0 \
    filelock==3.18.0 \
    filetype==1.2.0 \
    idna==3.10 \
    Jinja2==3.1.6 \
    Kivy==2.3.1 \
    Kivy-Garden==0.1.5 \
    MarkupSafe==3.0.2 \
    numpy==1.21.6 \
    packaging==25.0 \
    pathspec==0.12.1 \
    pexpect==4.9.0 \
    pillow==11.2.1 \
    platformdirs==4.3.8 \
    ptyprocess==0.7.0 \
    pyboy==2.3.0 \
    Pygments==2.19.1 \
    pyproject_hooks==1.2.0 \
    PySDL2==0.9.17 \
    pysdl2-dll==2.32.0 \
    python-for-android==2024.1.21 \
    requests==2.32.3 \
    scikit-build==0.18.1 \
    scikit_build_core==0.11.4 \
    sh==1.14.3 \
    toml==0.10.2 \
    tomli==2.2.1 \
    typing_extensions==4.14.0 \
    urllib3==2.4.0 \
    virtualenv==20.31.2
# VERIFICAR INSTALACIÓN DE BUILDOZER Y CYTHON
echo "Buildozer version:" && buildozer --version
echo "Cython version:" && python -m Cython --version
echo "✅ Entorno configurado correctamente. Usa 'source kivy_env/bin/activate' para activarlo."

```

   1.2 "Use source kivy_env/bin/activate" on the terminal to activate the virtual environment

   1.3 Download the github repository and navigate to the src directory (which has the buildozer.spec) on the terminal

   1.4 Execute "buildozer android debug --arch=arm64-v8a" !!! THIS IS EXPECTED TO FAIL !!! we will patch it in the next step.

            # Note: the first time it takes a while, it gets fastter after that, go do another thing meanwhile.

            => On this step we are looking for the "buildozerPyboyExample/src/.buildozer/android/platform/build-arm64-v8a/build/other_builds/"
            other_builds director to be created with all the original dependencies.

   1.5 Now we will apply the changes to the source code so it compiles on buildozer: Copy the contents of the other_builds directory which is at the root of the repository (In the same directory as this readme) into the "buildozerPyboyExample/src/.buildozer/android/platform/build-arm64-v8a/build/other_builds/" directory.

   1.6 Now we continue with the building proccess that was interrupted before because of the error: Execute "buildozer android debug --arch=arm64-v8a"

   1.7 An apk should be generated in the bin repository, you cant just copy that on your android device and execute it.


## 2. (This is just extra info, you can ignore it) If you want to know more about the proccess and maybe apply it to your own case:

        # We did several modifications to the buildozer.spec file:

    => source.include_exts = py,png,jpg,kv,atlas,GBC,pxd,pyx,ttf,bin
    => A lot of trial and error to find the version of dependencies that worked: requirements = python3,kivy,numpy,pillow,cython==3.0.6,pyboy
        as a general rule, its better to use the default buildozer dependencies.
    => We put the .gbc and bootrom files in the root directory of buildozer.
    => Made a local recipe for pyboy: p4a.local_recipes = ./recipes
    => Also made available some cython dependencies: cython_include_dirs = /home/sergio/mi_app_prueba/.buildozer/android/platform/build-arm64-v8a/build/other_builds/cython/arm64-v8a__ndk_target_21/cython/Cython/Includes


        # We compiled ("buildozer android debug --arch=arm64-v8a"): find a problem => change the source code on other_build => iterate

    Beware if you buildozer clean, you will lose all your changes in this directory.

    After changing anything on other builds, I delete the dist directory and the app directory, so the changes have an effect.
    
    Also, deleting some directories from the python_installs directory also helps the changes in other_builds to take effect.








# Aditional information about my system:

Distributor ID: Ubuntu
Description:    Ubuntu 24.04.2 LTS
Release:        24.04

My virtual environment or venv as the following things installed:

Python 3.10.17
pip 25.1.1
Buildozer 1.5.0
Cython Version: 3.1.1

pip freeze > requirements output:

appdirs==1.4.4
build==1.2.2.post1
buildozer==1.5.0
certifi==2025.4.26
charset-normalizer==3.4.2
colorama==0.4.6
Cython==3.1.1
distlib==0.3.9
distro==1.9.0
docutils==0.21.2
exceptiongroup==1.3.0
filelock==3.18.0
filetype==1.2.0
idna==3.10
Jinja2==3.1.6
Kivy==2.3.1
Kivy-Garden==0.1.5
MarkupSafe==3.0.2
numpy==1.21.6
packaging==25.0
pathspec==0.12.1
pexpect==4.9.0
pillow==11.2.1
platformdirs==4.3.8
ptyprocess==0.7.0
pyboy==2.3.0
Pygments==2.19.1
pyproject_hooks==1.2.0
PySDL2==0.9.17
pysdl2-dll==2.32.0
python-for-android==2024.1.21
requests==2.32.3
scikit-build==0.18.1
scikit_build_core==0.11.4
sh==1.14.3
toml==0.10.2
tomli==2.2.1
typing_extensions==4.14.0
urllib3==2.4.0
virtualenv==20.31.2
