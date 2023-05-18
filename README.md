# RStudio Server Container
Recipe to build a base docker container with RStudio Server, to be then run with Apptainer in Alliance Canada servers



Notes:
- stable build!
- Building R dependencies is faster, due to the docker base image change
- Mount port 8787 to localhost to be able to access the rstudio server. 
  - Needs rstudio server start/restart in the beginning 

ToDo list:
- Package install seems to work. Needs fullscale test.