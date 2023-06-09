FROM osrm/osrm-backend:v5.22.0

WORKDIR /data

# Install wget
RUN apt-get update && \
    apt-get install -y wget

# Download the map data
RUN wget http://download.geofabrik.de/north-america/us/minnesota-latest.osm.pbf -P /dev/nvme1n1

# Prepare the map data
RUN osrm-extract -p /opt/car.lua /dev/nvme1n1/minnesota-latest.osm.pbf && \
    osrm-partition /dev/nvme1n1/minnesota-latest.osrm && \
    osrm-customize /dev/nvme1n1/minnesota-latest.osrm

# Start the OSRM backend with multithreading
CMD ["osrm-routed", "--algorithm", "mld", "-t", "32", "/dev/nvme1n1/minnesota-latest.osrm"]

