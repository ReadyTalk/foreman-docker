[![Build Status](https://travis-ci.org/ReadyTalk/foreman-docker.svg?branch=master)](https://travis-ci.org/ReadyTalk/foreman-docker)

# DEPRECATED

This is no longer user or maintained and just around for reference.  If you are needing something like this please see the following links:

* https://community.theforeman.org/t/dockerfile-is-now-included-in-foreman-core/13987
* https://github.com/ohadlevy/foreman-kube


# Complete foreman in Kubernetes

# Containers

## Foreman

This is based on the phusion base image.  https://github.com/phusion/passenger-docker

## Puppetmaster

A fairly basic puppetmaster and a foreman smart proxy.

## Foreman-Proxy

A generic container that runs the foreman smart proxy.  This can be used to attach smart proxies to any of the things that foreman can control.

## Background and Design

The Foreman container sets up a default install of Foreman with a link to a postgres container.  There is a test script that will run the postgres container and foreman with the default configs in order to test it.  This container is ready to be launched into Kubernetes with configmaps and secrets, allowing it to be configured for any situation.

Foreman is built from source and is tagged to the stable version of 1.14 (for now).  In order to test a new version, just change the version in the Dockerfile.

I have added a puppetmaster and a puppetdb.  These can be turned off in the values file.

## Usage

Travis builds the containers.  Then you can install them into Kubernetes using helm.

## Kubernetes

There is a helm chart that will allow you to run Foreman (and eventually a puppetmaster) in Kubernetes.  It is in helm_charts

### Utility Pod

There is an optional utility pod that you can enable.  This pod will have utilities like dnsutils, nettools, psql, etc. that you can use to diagnose any issues or to do cleanup.

### Storage

There are two current storage options.  The first is to let Kubernetes create a gp2 volume for each service (Foreman, Postgres, Utility).  This will create a single volume per service to store persistent database data and certs, etc.

The second option (Preferred) is EFS.  You can create an efs volume and put that information in the values file.  This will use that EFS volume for all persistence, and keep folders for each servcice.  In this case, the utility pod will mount the root of the EFS volume to /data, allowing you to view all of your data, and to work with all of it.

#### Files

Puppet requires a lot of files to be in place for things to work.  Mainly this is your puppet code.  This needs to be placed on the persistent storage somehow.  I have provided the utility container and suggest using EFS so that you can place all the files.  The rest is up to you.
