FROM releases-docker.jfrog.io/jfrog/jfrog-cli:1.46.4

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
