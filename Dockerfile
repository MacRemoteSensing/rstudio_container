FROM ubuntu:latest

# Set timezone, to avoid tzdata hang --> https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d
ENV TZ=America/Toronto
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Insert R CRAN repository for Ubuntu. Refer to --> http://cran.rstudio.com/bin/linux/ubuntu/
RUN apt update -qq
RUN apt install --yes --no-install-recommends software-properties-common dirmngr wget
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
#RUN add-apt-repository "deb https://ppa.launchpadcontent.net/c2d4u.team/c2d4u4.0+/ubuntu $(lsb_release -cs) main"

# Updates and upgrades image
RUN apt-get update
RUN apt-get upgrade --yes

# Install R Base
RUN apt-get install --yes r-base-dev

#TODO: Implement R install from file
# Install R packages from list
RUN R -e "install.packages(path_to_file, repos = 'http://cran.rstudio.com/', type='source')"


# Install R

# Keep alive
#ENTRYPOINT ["tini", "--"]
CMD [ "/bin/bash" ]