# R.nomics
An R package that talks to [DBnomics](https://db.nomics.world/)

## How to install
In R console:

`install.packages("devtools")`

`install_github("SuperMayo/R.nomics")`

## Basic use
To download a given series, copy the __slug__ of the data, then

`data <- DBson("slug")`

will give you a data frame with 3 columns [ time , values , varname ]
