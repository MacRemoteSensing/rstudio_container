# RStudio Server Container
Recipe to build a base docker container with RStudio Server, to be then run with Apptainer on computers of Alliance Canada servers.

Notes:
- Base gaospatial docker package managed by the [RockeR project](https://rocker-project.org/).
  - Reference: [Package Description](https://rocker-project.org/images/versioned/rstudio.html); [Singularity Run](https://rocker-project.org/use/singularity.html)
- File '_installedpackages.csv_' comes with all packages that supplement the base environment, installed from binaries when possible. If you need anything, customize the file.
- Instructions on how to launch jobs on HPC will be gradually available in [CCPrimer](https://ricardobarroslourenco.github.io/CCprimer/).

Disclaimer: This work is licensed with a MIT License, and support is limited to lab members. In any case, feel free to open an issue in this repo.