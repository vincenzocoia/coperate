
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

The entities that this package deal with can be usefully categorized as *copulas*, *parameters*, and *operations*.

-   **Copulas**: A bundle of properties that describe a copula. Things like kendall's tau, CCEVI, tail dependence, even the cdf at a point can be considered a property. Not all properties uniquely define a copula, but the "canonical" ones will ought to be distribution-related functions. Ideally, other properties will be defined, like kendall's tau (even density), but could be calculated if need be
-   **Parameters**: Variables that disambiguate a copula. Includes family name, canonical parameters, symmetries~~, and possibly extensions~~. A *family* is a collection of copulas continuously related, indexed by a continuous set of *canonical parameters*. ~~This family might be *extended* by some parametric transformation -- for example, adding a skew, or considering the interpolated version of a DJ copula family.~~ A *symmetry* is a re-orientation of a copula by reflection and/or permutation.
-   **Operations**: include things like relaxing, shrinking, or mutating the parameter space, similar to how a data frame might be filtered, expanded, or mutated.
-   **Closures?**: Possibly include transformations of a copula to another copula. For example, a threshold copula (as in the DJ paper), or extreme value copula, or skew copula.

This package cannot include a comprehensive list of any one of these. The user should be allowed to make their own. But this package ought to start with the basics of these.

0. Copula class
---------------

Define a `bicop` object (start bivariate!), which represents a (collection of?) copula models.

Why not one-family-at-a-time? Because families are an artificial construct. We just want to consider a bunch of families that share common properties. - The point may be to consider an expansive parameter space that is larger than your typical parameteric model, yet not as big as non-parametric models.

-   Methods:
    -   `plot.bicop` method should plot normal scores density contours.
-   Parameter space:
    -   Needs to allow for easy looping across the finite aspect of the parameter space, running an optimizer on each part. Perhaps tidy data frame (but not a tibble), where each row is a resolution of finite copula parameters (family, reflection, etc). Would make it easy to append fitted values for the continuous parameters, to then fit into the `restrict` function to fully resolve the copula.
-   May require a database of parametric copula families, that should be auto-added to when a user makes a new model. Disambiguate from this list, or grab from this list?
-   `bicop` class: A list with the following components:
    -   $parspace
    -   $symmetries
    -   $cdf
    -   $pdf
    -   $cond\_cdf
        -   list of 2; entry j is the distribution of j (given the others). This paves the way for higher dimensional copulas.

1. providing an extensive built-in selection of parametric copula models;
-------------------------------------------------------------------------

Pre-defined copula families:

cop\_frk
cop\_igl
...
cop\_ig and cop\_igl have precision problems that need fixing.

-   Implement *lower* bound for Newton-Raphson in helper function: just replace p with sqrt(p) and I'll get a lower bound. Why? Does it solve the problem of inaccuracies when k is small?
-   The cnstr\_H function's inverse could probably use improvements through Newton-Raphson, similar to what I did with the helper function.

Building a model could look something like this:

    copula_model(family %in% c("Frank", "Gumbel"))
    copula_model(family %in% c("Frank", "Gumbel"), dependence=1)
    copula_model(dependence=1, minor=1, ncpar=1) %>% 
        relax(family="BB1") # Adds BB1 family
    ## Alternatively:
    copula_model((dependence=1, minor=1, ncpar=1) | family="BB1")

2. creating user-defined parametric copula families (optionally);
-----------------------------------------------------------------

-   Allow users to make a parametric copula family by specifying the generator of a Gaussian, DJ, or interpolated DJ copula class.
-   Allow users to make their own from a clean slate (requires more from the user).

<!-- -->

    cop <- copula_manual(C=, c=, C2g1=, C1g2=, make_symmetries=TRUE, other args that are needed -- otherwise try via differentiation/integration from what the user provides.)  # Make your own. Sends out warnings if it can't fill in the other fields automatically. 
    cop <- copula(families=get_families())
    cop <- copula_arch(psi=)
    cop <- copula_dj(psi=)
    cop <- copula_extdj(psi=)
    cop <- copula_gauss(d)
    cop <- copula_t(d)

3. operating on the copula parameter space to restrict, relax, and alter the space;
-----------------------------------------------------------------------------------

The idea here is to tailor your copula parameter space to the more obvious properties of your data, before hitting it with heavy-duty machinery like MLE or CNQR. For example, if your data are positively dependent and has upper tail dependence, then we know what copula families are appropriate, and the reflection. This is also useful for interactive-type analyses, because it allows you to easily modify the parameter space to explore.

-   Alter: "migrates" the parameter space to something else, but does not change the size of the space. Uses the dihedral group algebra. Consists of the following verbs:
    -   `permute`:
        -   change which copula variables correspond to the data variables.
        -   Should make it easier for higher dimensions down the road. There's the group-theoretic notation, like (1,3)(2,4), meaning 1-&gt;3, 3-&gt;1, 2-&gt;4, 4-&gt;2, but that's complex.
    -   `reflect(cop, axes=c(1,2))`:
        -   reflect on certain variables.
    -   `rotate(cop, times=1)`:
        -   the normal scores density.
-   `restrict` and `relax`: make the copula space smaller and larger (respectively).
    -   by tail dependence, by sign of dependence, by skew.
    -   restrict or relax canonical parameters.
    -   restrict by properties, such as ktau = that of the data (useful for models with more than 1 copula parameter).
    -   remove and add copula families
    -   add a skew option (with corresponding variable(s) to add skew to).
-   Query the parameter space:
    -   What range do the canonical parameters currently have?
    -   What copula families are in my class?
    -   What range of dependence do I have?
    -   What directions of dependence are currently possible?

<!-- -->

    restrict_cpar(cop, ...)  # Example: restrict_cpar(cop, theta=MLE)
    restrict_symm(cop, symm=..., dep="positive")
    relax_symm(cop, symm=...)
    relax_cpar(cop, ...)
    relax_fam(cop
    reparam_...

Was also thinking "expand" instead of "relax", but I think the latter makes more sense.

Could also do "resolve" instead of "restrict" -- although the former may suggest resolving to one copula.

4. computing distributional quantities from a copula model,
-----------------------------------------------------------

-   pdf, cdf, densities, quantiles, mean, rosenblatt transform (?). Joint, conditional, or marginal.
    -   dcop, pcop, dcop(log=FALSE)
        -   `_cop.bicop(cop, u, v)` -- `v` optional, if `u` is a matrix.
-   Generate data from a copula.
-   Copula properties (as a function of the parameter space, if needed):
    -   CCEVI, Kendall's tau, Spearman's rho?, tail order, tail index. Examples:
        -   `meas_corr(cop, ..., cpar, symm=0, type="kendall")`
        -   `meas_taildep(cop, ..., cpar, symm=0, corner=)`
    -   When given an unresolved copula, give the full range of possible values, as if it's querying the parameter space. Might be appropriate to return a function from the canonical parameters to the property (like ktau).
-   extract the remaining parameter space of a copula family.

Perhaps:

    avail_symmetries(cop)
    avail_parspace(cop)
    avail_families(cop, dep.tail=TRUE, symm.perm=TRUE, symm.refl=NULL)
    avail_families_all(dep.tail=TRUE, symm.perm=TRUE, symm.refl=NULL)

Installation
============

You can install coperate from github with:

``` r
# install.packages("devtools")
devtools::install_github("vincenzocoia/coperate")
```

Examples
========

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

Future Ideas (hopefully not so distant)
=======================================

-   Multivariate parametric copula families.
    -   Multivariate Archimedean
    -   Vines
-   Easy handling, manipulation, and querying of vine objects.
    -   Adding or removing parts of the vine.
    -   Rearranging parts of the vine.
    -   Subsetting the vine.
    -   Conversion between vine arrays
    -   Define a random vine.
-   Eventually I don't want people to have to work with raw copulas like gumbel and frank. I want them to specify properties they're looking for, and work with that.
    -   Something like `my_cop <- bicop(families with upper tail dependence)`.
-   Instead of fitting the entire gamut of copula families, pre-select them according to some properties. Choose candidate copula families that are appropriate for the data.
    -   Based on tail dependence is one idea.
    -   Based on symmetry is another.

Eventually, downstream packages/functions will exist, something like `mle()`, and `cnqr()`, so that we can just do:

    my_model %>%
        fit(mle, data=my_dat)

Better, something like

    my_model %>%
        group_by(family) %>%
        fit(mle, data=my_dat)

...which fits to each group. Can then output things about the fitted models to aid in model selection, like adding the following pipe to the chain:

    %>% mutate(nllh, ktau=..., ncpar=...)

...to assist in model selection.
