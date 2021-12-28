# Docker_node-js_webapp_multistage_build

## About Multistage Build

When we scale the number of containers up or down in the data center, container size must stay at the absolute minimum. A multistage Docker build process makes it possible to build out an application and then remove any unnecessary development tools from the container. This approach reduces the container's final size, but it is a complex process.

The Dockerfile contains a set of instructions on how to build a Docker container-based application. A Docker image is a snapshot of a Docker container at some point in time, providing a template to execute containers. A base image is equivalent to a fresh install of an OS. Finally, an artifact is anything created during a build process of an application or Docker image.

A multistage build enables IT teams to optimize Dockerfiles and maintain them over time, regardless of infrastructure requirements. To set up a successful multistage build, you should first identify when to use the process, assess the advantages and disadvantages, and review these guidelines.


