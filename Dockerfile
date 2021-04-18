FROM etherpad/etherpad:1.8.13
LABEL maintainer="Cristian Consonni <cristian@balist.es>"

# plugins to install while building the container. By default no plugins are
# installed.
# If given a value, it has to be a space-separated, quoted list of plugin names.
#
# EXAMPLE:
#   ETHERPAD_PLUGINS="ep_codepad ep_author_neat"
ARG ETHERPAD_PLUGINS=

# By default, Etherpad container is built and run in "production" mode. This is
# leaner (development dependencies are not installed) and runs faster (among
# other things, assets are minified & compressed).
ENV NODE_ENV=production

# add wait-for-it.sh
COPY ./wait-for-it/wait-for-it.sh /usr/local/bin/wait-for-it.sh

# set workdir
WORKDIR /opt/etherpad-lite

# run as non-privileged user
USER etherpad

# Copy the configuration file.
COPY --chown=etherpad:0 ./settings.json ./settings.json

# install bcrypt for hashed passwords
RUN npm install bcrypt

# Bash trick: in the for loop ${ETHERPAD_PLUGINS} is NOT quoted, in order to be
# able to split at spaces.
RUN for PLUGIN_NAME in ${ETHERPAD_PLUGINS}; \
      do npm install "${PLUGIN_NAME}" || exit 1; \
    done


EXPOSE 9001
CMD ["/usr/local/bin/wait-for-it.sh", "${DB_HOST}:${DB_PORT}", "-t", "1", \
     "--", \
     "node", "--experimental-worker", \
     "node_modules/ep_etherpad-lite/node/server.js"]
