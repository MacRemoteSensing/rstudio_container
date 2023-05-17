csv <- read.csv('/installedpackages.csv')
install.packages(csv$Package , repos = c('https://cloud.r-project.org','http://cran.rstudio.com/'), type='source')