[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/916)

# Setup

The original paper used R 3.3.0 on Debian 7 Wheezy, but because CRAN
only released R version 3.2.5 for Wheezy, we use a Singularity image to
replicate the R executable.

Install the latest version of
[singularity](http://singularity.lbl.gov/) for your operating system.

Then run the `bootstrap.sh` script in the cloned directory to:

1. Download the supplement data to `downloads/`,
2. Install the R packages sandboxed under `r-lib/` in the current
   directory, and finally
3. Run the analysis.

# Why do we specifically need R 3.3.0?

The R minor release version matters because Bioconductor package
releases are pinned against them.

# Why use a Singularityfile instead of a Dockerfile?

Singularity produces portable, read-only, containers based on a
non-proprietary image format and suited to scientific workflows.

Docker has lately been favored by the academic community, but has
several troubling drawbacks in practice:

- A reason many academics use Docker is for `Makefile`-like caching
  long operations.
- But without continuous integration, caching does not make the work
  reproducible, and there are more sensible language specific
  memoization operations available such as `Biobase::cache()` in `R`.
- Docker images have also become a crutch for distributing poorly
  packaged software.  In other words, distributing containers has
  become customary instead of writing the traditional
  language-specific software package and minimal analysis scripts that
  rely on package controlled code.
- Images also encourage bad practices of not separating data and code.
- Docker has non-sensical default security, such as root privileged
  containers without user namespace remapping (see
  [NCC Group whitepaper](https://www.nccgroup.trust/uk/our-research/abusing-privileged-and-unprivileged-linux-containers/)).
- Docker has poor community support with nearly all questions on
  the [docker forum unanswered](https://forums.docker.com/).

In industry settings, having the smallest possible infrastructure
footprint using containers is important, but less so in academia given
the drawbacks above.  Preferring language-specific software packaging,
and minimizing the user of containers is more extensible, maintainable
and reproducibile.
