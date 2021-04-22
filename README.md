
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coperate <img src="man/figures/coperate-240x278.png" align="right" height="150"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/coperate)](https://CRAN.R-project.org/package=coperate)
[![Travis build
status](https://travis-ci.com/vincenzocoia/coperate.svg?branch=master)](https://travis-ci.com/vincenzocoia/coperate)
[![Codecov test
coverage](https://codecov.io/gh/vincenzocoia/coperate/branch/master/graph/badge.svg)](https://codecov.io/gh/vincenzocoia/coperate?branch=master)
<!-- badges: end -->

The goal of `coperate` is to facilitate the modelling of parametric
copula-based models. Resolving a copula model involves more than one
step such as fitting a maximum likelihood model. It more often first
requires choosing appropriate parametric copula families, their
orientations, and sometimes even restricting the canonical parameter
spaces.

`coperate` cooperates with you to do this by

1.  providing an extensive built-in selection of parametric copula
    models;
2.  creating user-defined parametric copula families (optionally);
3.  operating on the copula parameter space to restrict, relax, and
    alter the space; and
4.  computing distributional quantities from a copula model,

This package intentionally does not include model-fitting functionality,
such as MLE and CNQR, but is intended to be useful as a back-end for
such fitting.

The entities that this package deal with can be usefully categorized as
*copulas*, *parameters*, and *operations*.

  - **Copulas**: A bundle of properties that describe a copula. Things
    like kendall’s tau, CCEVI, tail dependence, even the cdf at a point
    can be considered a property. Not all properties uniquely define a
    copula, but the “canonical” ones will ought to be
    distribution-related functions. Ideally, other properties will be
    defined, like kendall’s tau (even density), but could be calculated
    if need be
  - **Parameters**: Variables that disambiguate a copula. Includes
    family name, canonical parameters, symmetries~~, and possibly
    extensions~~. A *family* is a collection of copulas continuously
    related, indexed by a continuous set of *canonical parameters*.
    ~~This family might be *extended* by some parametric transformation
    – for example, adding a skew, or considering the interpolated
    version of a DJ copula family.~~ A *symmetry* is a re-orientation of
    a copula by reflection and/or permutation.
  - **Operations**: include things like relaxing, shrinking, or mutating
    the parameter space, similar to how a data frame might be filtered,
    expanded, or mutated.
  - **Closures?**: Possibly include transformations of a copula to
    another copula. For example, a threshold copula (as in the DJ
    paper), or extreme value copula, or skew copula.

This package cannot include a comprehensive list of any one of these.
The user should be allowed to make their own. But this package ought to
start with the basics of these.

## Installation

`coperate` is not on CRAN yet, so the best way to install it is:

``` r
devtools::install_github("vincenzocoia/coperate")
```

## Code of Conduct

Please note that the coperate project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
