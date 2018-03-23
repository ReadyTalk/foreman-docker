# Foreman Container for Kubernetes

This is based on the phusion base image.  https://github.com/phusion/passenger-docker

## Background and Design

The container sets up a default install of Foreman with a link to a postgres container.  There is a test script that will run the postgres container and foreman with the default configs in order to test it.  This container is ready to be launched into Kubernetes with configmaps and secrets, allowing it to be configured for any situation.

Foreman is built from source and is tagged to the stable version of 1.14 (for now).  In order to test a new version, just change the version in the Dockerfile.

## Usage

* Build the container:  `./build.sh` NOTE: if you are running Docker 1.13 or higher, feel free to add the --squash option to the build command
* Run the test: `./start_test.sh`
* Take note of the admin password that should be somewhere towards the end of the output

Now you should have a running postgres container and a running foreman container.  Add `<test machine IP> foreman-test.domain.com` to your hosts file and go to foreman-test.domain.com:8080 in your browser.
