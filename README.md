# RStudio Server Container
Recipe to build a base docker container with RStudio Server, to be then run with Apptainer in Alliance Canada servers



Notes:
- Very unstable build!
- Building R dependencies takes around 40 min
- Mount port 8787 to localhost to be able to access the container

ToDo list:
- Rebuild and check if RStudio install is working
- Then test the server ports and tunneling.
