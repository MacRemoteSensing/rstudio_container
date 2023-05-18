# RStudio Server Container
Recipe to build a base docker container with RStudio Server, to be then run with Apptainer in Alliance Canada servers



Notes:
- Unstable build!
- Building R dependencies takes around 40 min
- Mount port 8787 to localhost to be able to access the container
  - Needs rstudio server start/restart in the beginning (despite the dockerfile start) 

ToDo list:
- Check if package list is ok (based on Cheryl`s benchmark code)