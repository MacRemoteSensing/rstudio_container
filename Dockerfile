# Uses Rstudio from certified repository - Refer:https://rocker-project.org/images/versioned/rstudio.html
FROM rocker/geospatial:4.3.0

# Install apt dependencies for Apptainer
RUN apt-get update
RUN apt-get install --yes htop

# Install R packages from list - Binary build
COPY installedpackages.csv /
COPY installing_packages.R /

RUN Rscript /installing_packages.R

# Keep alive
CMD [ "/bin/bash" ]