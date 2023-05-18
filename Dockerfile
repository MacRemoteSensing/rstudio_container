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
RUN apt-get install --yes cmake unixodbc-dev apt-utils

#TODO: Implement R install from file
# Install R packages from list
COPY installedpackages.csv /
COPY installing_packages.R /

# Install R
#RUN R CMD BATCH /installing_packages.R # This run in silent build (not good for inspection, but less verbose)
RUN Rscript /installing_packages.R

# Install RStudio - Consistent with Ubuntu version
## Refer to the repo : https://dailies.rstudio.com/rstudio/mountain-hydrangea/electron/jammy-amd64/
RUN wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.03.1-446-amd64.deb
RUN gdebi -n /rstudio-server-2023.03.1-446-amd64.deb

# Start Rstudio Server -- https://support.posit.co/hc/en-us/articles/200532327-Managing-RStudio-Workbench-RStudio-Server
RUN rstudio-server stop
RUN rstudio-server start

# Create user for processing
## References: https://askubuntu.com/a/1377369/463917 | https://stackoverflow.com/a/49848507/4743714
RUN useradd rstudio -p "$(openssl passwd -1 password)"

RUN mkdir /home/rstudio
RUN chown -R rstudio /home/rstudio

# Keep alive
#ENTRYPOINT ["tini", "--"]
CMD [ "/bin/bash" ]