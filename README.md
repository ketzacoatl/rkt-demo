## Demo Building and Running Container Images w/ rkt

This project aims to demonstrate how to run builds and drive deployments with
`rkt` and Gitlab, and includes the `.gitlab-ci.yml` and build specs to run the
demo once imported into a Gitlab project.


### Builds

* OCI image `nginx-OCI-buildah-raw` from many `buildah` commands
* OCI image `nginx-OCI-buildah-dockerfile` from conversion
* Docker image `nginx-docker-buildah` from `buildah`, pushing to the Gitlab registry
* Docker image `nginx-docker-docker`, pushing also to the registry
