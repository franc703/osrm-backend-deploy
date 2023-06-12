FROM osrm/osrm-backend:latest

WORKDIR /data

# Change the repository URL and remove stretch-updates
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list && \
    apt-get -o Acquire::Check-Valid-Until=false update


# Install wget
RUN apt-get install -y wget

# Download the map data
RUN wget http://download.geofabrik.de/north-america/us/minnesota-latest.osm.pbf 

# Prepare the map data
RUN osrm-extract -p /opt/car.lua minnesota-latest.osm.pbf && \
    osrm-partition minnesota-latest.osrm && \
    osrm-customize minnesota-latest.osrm

# Start the OSRM backend with multithreading
CMD ["osrm-routed", "--algorithm", "mld", "-t", "32", "--port", "8080", "/data/minnesota-latest.osrm"]

