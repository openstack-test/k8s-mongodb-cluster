FROM mongo:4.1.7
ADD mongodb-keyfile /data/config/mongodb-keyfile
RUN chown mongodb:mongodb /data/config/mongodb-keyfile \
    && chmod 600 /data/config/mongodb-keyfile

