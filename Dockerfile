# Uses Rstudio from certified repository - Refer:https://rocker-project.org/images/versioned/rstudio.html
FROM rocker/geospatial:4.3.0

# Install R packages from list - Binary build
COPY installedpackages.csv /
COPY installing_packages.R /

RUN Rscript /installing_packages.R

# Keep alive
CMD [ "/bin/bash" ]