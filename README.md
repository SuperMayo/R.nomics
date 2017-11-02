# R.nomics
An R package that talks to [DBnomics](db.nomics.world)

## How to install
In R console:

`github_install("SuperMayo/R.nomics")`

## Basic use
To download a given series, copy the __slug__ of the data, then

`data <- DBson("slug")`

will give you a data frame with 3 columns [ time , values , varname ]
