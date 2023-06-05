FROM osrm/osrm-backend:v5.22.0

WORKDIR /data

# Install wget
RUN apt-get update && \
    apt-get install -y wget

# Download the map data
RUN wget http://download.geofabrik.de/north-america/us/minnesota-latest.osm.pbf

# Prepare the map data
RUN osrm-extract -p /opt/car.lua minnesota-latest.osm.pbf && \
    osrm-partition minnesota-latest.osrm && \
    osrm-customize minnesota-latest.osrm

# Start the OSRM backend
CMD ["osrm-routed", "--algorithm", "mld", "minnesota-latest.osrm"]
