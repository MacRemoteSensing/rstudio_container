csv <- read.csv('/installedpackages.csv')
install.packages(csv$Package)