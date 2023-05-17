# Ubuntu version must be the same as Rstudio
FROM ubuntu:jammy

# Set timezone, to avoid tzdata hang --> https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d
ENV TZ=America/Toronto
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Insert R CRAN repository for Ubuntu. Refer to --> http://cran.rstudio.com/bin/linux/ubuntu/
RUN apt update -qq
RUN apt install --yes --no-install-recommends software-properties-common dirmngr wget
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Updates and upgrades image
RUN apt-get update
RUN apt-get upgrade --yes

# Install R Base
RUN apt-get install --yes r-base-dev gdebi-core

# Install other dependencies needed for package build
RUN apt-get install --yes cmake unixodbc-dev

#TODO: Implement R install from file
# Install R packages from list
COPY installedpackages.csv /
COPY installing_packages.R /

# Install R
#RUN R CMD BATCH /installing_packages.R # This run in silent build (not good for inspection, but less verbose)
RUN Rscript /installing_packages.R

# Install RStudio - Consistent with Ubuntu version
## Refer to the repo : https://dailies.rstudio.com/rstudio/mountain-hydrangea/electron/jammy-amd64/
RUN wget https://s3.amazonaws.com/rstudio-ide-build/electron/jammy/amd64/rstudio-2023.05.0-daily-366-amd64.deb
RUN gdebi -n /rstudio-2023.05.0-daily-366-amd64.deb

# Keep alive
#ENTRYPOINT ["tini", "--"]
CMD [ "/bin/bash" ]