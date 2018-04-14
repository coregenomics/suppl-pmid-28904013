local({
    ## Set default repo per http://stackoverflow.com/a/31413989
    repos <- getOption("repos")
    repos["CRAN"] <- "https://cran.rstudio.com"
    options(repos = repos)

    ## Sandbox R packages to ./r-lib in current directory.
    lib <- file.path("r-lib", R.version$platform, getRversion())
    if (!file.exists(lib)) {
      dir.create(lib, recursive = TRUE)
    }
    .libPaths(lib)
    message("Using sandboxed library directory ", sQuote(lib))
})
