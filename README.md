
<!-- README.md is generated from README.Rmd. Please edit that file -->
coperate
========

The goal of `coperate` is to facilitate the modelling of parametric copula-based models. Resolving a copula model involves more than one step such as fitting a maximum likelihood model. It more often first requires choosing appropriate parametric copula families, their orientations, and sometimes even restricting the canonical parameter spaces.

`coperate` cooperates with you to do this by

1.  providing an extensive built-in selection of parametric copula models;
2.  creating user-defined parametric copula families (optionally);
3.  operating on the copula parameter space to restrict, relax, and alter the space; and
4.  computing distributional quantities from a copula model,

This package intentionally does not include model-fitting functionality, such as MLE and CNQR, but is intended to be useful as a back-end for such fitting.

Installation
------------

You can install coperate from github with:

``` r
# install.packages("devtools")
devtools::install_github("vincenzocoia/coperate")
```

Examples
--------

Fully resolved copula:

    my_cop <- bicop("gum", cpar=1.3, dep=+1, taildep="upper")
    dcop(my_cop, u, v)

Not fully resolved:

    my_cop <- bicop("gum")
    dcop(my_cop, u, v)

    > Error: copula class `my_cop` not resolved to a single copula. Cannot evaluate.

    my_cop %>%
        restrict(cpar=1.3, dep=1, taildep="upper") %>%
        dcop(u, v)
