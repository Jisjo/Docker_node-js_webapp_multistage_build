# Docker_node-js_webapp_multistage_build

## About Multistage Build

When we scale the number of containers up or down in the data center, container size must stay at the absolute minimum. A multistage Docker build process makes it possible to build out an application and then remove any unnecessary development tools from the container. This approach reduces the container's final size, but it is a complex process.

The Dockerfile contains a set of instructions on how to build a Docker container-based application. A Docker image is a snapshot of a Docker container at some point in time, providing a template to execute containers. A base image is equivalent to a fresh install of an OS. Finally, an artifact is anything created during a build process of an application or Docker image.

A multistage build enables IT teams to optimize Dockerfiles and maintain them over time, regardless of infrastructure requirements. To set up a successful multistage build, you should first identify when to use the process, assess the advantages and disadvantages, and review these guidelines.


```
jisjo@mylappy:~$ docker image build -t jisjo/mini:v1 ./
Sending build context to Docker daemon  2.048kB
Step 1/14 : FROM alpine:3.8 As build1
3.8: Pulling from library/alpine
486039affc0a: Pull complete 
Digest: sha256:2bb501e6173d9d006e56de5bce2720eb06396803300fe1687b58a7ff32bf4c14
Status: Downloaded newer image for alpine:3.8
 ---> c8bccc0af957
Step 2/14 : RUN mkdir /var/flaskapp
 ---> Running in a385425b1440
Removing intermediate container a385425b1440
 ---> af660ed0b6a5
Step 3/14 : WORKDIR  /var/flaskapp
 ---> Running in f1be9b64c571
Removing intermediate container f1be9b64c571
 ---> 30662bfc9a7d
Step 4/14 : RUN  apk update && apk add python3 && apk add git
 ---> Running in ddc259f6d3c7
fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/community/x86_64/APKINDEX.tar.gz
v3.8.5-67-gf94de196ca [http://dl-cdn.alpinelinux.org/alpine/v3.8/main]
v3.8.5-66-gccbd6a8ae7 [http://dl-cdn.alpinelinux.org/alpine/v3.8/community]
OK: 9564 distinct packages available
(1/11) Installing libbz2 (1.0.6-r7)
(2/11) Installing expat (2.2.8-r0)
(3/11) Installing libffi (3.2.1-r4)
(4/11) Installing gdbm (1.13-r1)
(5/11) Installing xz-libs (5.2.4-r0)
(6/11) Installing ncurses-terminfo-base (6.1_p20180818-r1)
(7/11) Installing ncurses-terminfo (6.1_p20180818-r1)
(8/11) Installing ncurses-libs (6.1_p20180818-r1)
(9/11) Installing readline (7.0.003-r0)
(10/11) Installing sqlite-libs (3.25.3-r4)
(11/11) Installing python3 (3.6.9-r1)
Executing busybox-1.28.4-r3.trigger
OK: 67 MiB in 24 packages
(1/6) Installing ca-certificates (20191127-r2)
(2/6) Installing nghttp2-libs (1.39.2-r0)
(3/6) Installing libssh2 (1.9.0-r1)
(4/6) Installing libcurl (7.61.1-r3)
(5/6) Installing pcre2 (10.31-r0)
(6/6) Installing git (2.18.4-r0)
Executing busybox-1.28.4-r3.trigger
Executing ca-certificates-20191127-r2.trigger
OK: 81 MiB in 30 packages
Removing intermediate container ddc259f6d3c7
 ---> 1f2dbe3b9cb0
Step 5/14 : RUN git clone https://github.com/Jisjo/Docker_python_flask_helow-world.git /var/flaskapp
 ---> Running in 475e5b41a520
Cloning into '/var/flaskapp'...
Removing intermediate container 475e5b41a520
 ---> 0914c200baa8
Step 6/14 : FROM alpine:3.8
 ---> c8bccc0af957
Step 7/14 : RUN mkdir /var/flaskapp
 ---> Using cache
 ---> af660ed0b6a5
Step 8/14 : WORKDIR  /var/flaskapp
 ---> Using cache
 ---> 30662bfc9a7d
Step 9/14 : RUN  apk update && apk add python3
 ---> Running in 543086e253e4
fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/community/x86_64/APKINDEX.tar.gz
v3.8.5-67-gf94de196ca [http://dl-cdn.alpinelinux.org/alpine/v3.8/main]
v3.8.5-66-gccbd6a8ae7 [http://dl-cdn.alpinelinux.org/alpine/v3.8/community]
OK: 9564 distinct packages available
(1/11) Installing libbz2 (1.0.6-r7)
(2/11) Installing expat (2.2.8-r0)
(3/11) Installing libffi (3.2.1-r4)
(4/11) Installing gdbm (1.13-r1)
(5/11) Installing xz-libs (5.2.4-r0)
(6/11) Installing ncurses-terminfo-base (6.1_p20180818-r1)
(7/11) Installing ncurses-terminfo (6.1_p20180818-r1)
(8/11) Installing ncurses-libs (6.1_p20180818-r1)
(9/11) Installing readline (7.0.003-r0)
(10/11) Installing sqlite-libs (3.25.3-r4)
(11/11) Installing python3 (3.6.9-r1)
Executing busybox-1.28.4-r3.trigger
OK: 67 MiB in 24 packages
Removing intermediate container 543086e253e4
 ---> 089e8811b078
Step 10/14 : COPY --from=build1 /var/flaskapp .
 ---> eb2fa71cbe3f
Step 11/14 : RUN  pip3 install -r requirements.txt
 ---> Running in b1e0c4634246
Collecting flask (from -r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/8f/b6/b4fdcb6d01ee20f9cfe81dcf9d3cd6c2f874b996f186f1c0b898c4a59c04/Flask-2.0.2-py3-none-any.whl (95kB)
Collecting click>=7.1.2 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/48/58/c8aa6a8e62cc75f39fee1092c45d6b6ba684122697d7ce7d53f64f98a129/click-8.0.3-py3-none-any.whl (97kB)
Collecting itsdangerous>=2.0 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/9c/96/26f935afba9cd6140216da5add223a0c465b99d0f112b68a4ca426441019/itsdangerous-2.0.1-py3-none-any.whl
Collecting Werkzeug>=2.0 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/1e/73/51137805d1b8d97367a8a77cae4a792af14bb7ce58fbd071af294c740cf0/Werkzeug-2.0.2-py3-none-any.whl (288kB)
Collecting Jinja2>=3.0 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/20/9a/e5d9ec41927401e41aea8af6d16e78b5e612bca4699d417f646a9610a076/Jinja2-3.0.3-py3-none-any.whl (133kB)
Collecting importlib-metadata; python_version < "3.8" (from click>=7.1.2->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/a0/a1/b153a0a4caf7a7e3f15c2cd56c7702e2cf3d89b1b359d1f1c5e59d68f4ce/importlib_metadata-4.8.3-py3-none-any.whl
Collecting dataclasses; python_version < "3.7" (from Werkzeug>=2.0->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/fe/ca/75fac5856ab5cfa51bbbcefa250182e50441074fdc3f803f6e76451fab43/dataclasses-0.8-py3-none-any.whl
Collecting MarkupSafe>=2.0 (from Jinja2>=3.0->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/bf/10/ff66fea6d1788c458663a84d88787bae15d45daa16f6b3ef33322a51fc7e/MarkupSafe-2.0.1.tar.gz
Collecting zipp>=0.5 (from importlib-metadata; python_version < "3.8"->click>=7.1.2->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/bd/df/d4a4974a3e3957fd1c1fa3082366d7fff6e428ddb55f074bf64876f8e8ad/zipp-3.6.0-py3-none-any.whl
Collecting typing-extensions>=3.6.4; python_version < "3.8" (from importlib-metadata; python_version < "3.8"->click>=7.1.2->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/05/e4/baf0031e39cf545f0c9edd5b1a2ea12609b7fcba2d58e118b11753d68cf0/typing_extensions-4.0.1-py3-none-any.whl
Installing collected packages: zipp, typing-extensions, importlib-metadata, click, itsdangerous, dataclasses, Werkzeug, MarkupSafe, Jinja2, flask
  Running setup.py install for MarkupSafe: started
    Running setup.py install for MarkupSafe: finished with status 'done'
Successfully installed Jinja2-3.0.3 MarkupSafe-2.0.1 Werkzeug-2.0.2 click-8.0.3 dataclasses-0.8 flask-2.0.2 importlib-metadata-4.8.3 itsdangerous-2.0.1 typing-extensions-4.0.1 zipp-3.6.0
You are using pip version 18.1, however version 21.3.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
Removing intermediate container b1e0c4634246
 ---> aa14a2a7c284
Step 12/14 : EXPOSE  5000
 ---> Running in 55bbb33b1dbc
Removing intermediate container 55bbb33b1dbc
 ---> fb6de1b7f916
Step 13/14 : ENTRYPOINT [ "/usr/bin/python3" ]
 ---> Running in 7f7a0e8b6d9f
Removing intermediate container 7f7a0e8b6d9f
 ---> 49beb500466e
Step 14/14 : CMD [ "app.py" ]
 ---> Running in 5e65a002bf27
Removing intermediate container 5e65a002bf27
 ---> 2488e08b3b84
Successfully built 2488e08b3b84
Successfully tagged jisjo/mini:v1
```
```
jisjo@mylappy:~$ docker image ls
REPOSITORY                    TAG          IMAGE ID       CREATED          SIZE
jisjo/mini                    v1           2488e08b3b84   13 seconds ago   62.7MB
alpine                        3.8          c8bccc0af957   23 months ago    4.41MB

```
