[![Build Status](https://travis-ci.org/ReadyTalk/foreman-docker.svg?branch=master)](https://travis-ci.org/ReadyTalk/foreman-docker)

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

## Kubernetes

There is a helm chart that will allow you to run Foreman (and eventually a puppetmaster) in Kubernetes.  It is in helm_charts

### Utility Pod

There is an optional utility pod that you can enable.  This pod will have utilities like dnsutils, nettools, psql, etc. that you can use to diagnose any issues or to do cleanup.

### Storage

There are two current storage options.  The first is to let Kubernetes create a gp2 volume for each service (Foreman, Postgres, Utility).  This will create a single volume per service to store persistent database data and certs, etc.

The second option (Preferred) is EFS.  You can create an efs volume and put that information in the values file.  This will use that EFS volume for all persistence, and keep folders for each servcice.  In this case, the utility pod will mount the root of the EFS volume to /data, allowing you to view all of your data, and to work with all of it.

#### Files

Puppet requires a lot of files to be in place for things to work.  Mainly this is your puppet code.  This needs to be placed on the persistent storage somehow.  I have provided the utility container and suggest using EFS so that you can place all the files.  The rest is up to you.
