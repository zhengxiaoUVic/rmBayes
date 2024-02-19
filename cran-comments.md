## CRAN submission

* Re-submitted: February 19, 2024.
* Accepted: February 19, 2024.
The Date field is over a month old.

It's 2024! I accidentally wrote the year 2024 as 2023 in DESCRIPTION.

* Re-submitted: September 12, 2022.
* Accepted: September 12, 2022.
Found the following (possibly) invalid URLs:
  URL: https://codecov.io/gh/zhengxiaoUVic/rmBayes (moved to https://app.codecov.io/gh/zhengxiaoUVic/rmBayes)
    From: README.md

R 4.2.0 switched to use HTML5 for documentation pages. Now validation using HTML Tidy finds problems in the HTML generated from the previous Rd files. 

* Submitted: September 14, 2021.
* Accepted: September 15, 2021.
For future submissions/updates: If there are references describing the methods in your package, please add these in the description field of your DESCRIPTION file in the form e.g. authors (year) <doi:...>

## Test environments

* local: darwin22.6.0, darwin18.6.0
* win-builder: windows-x86_64-oldrel, release, devel
* GitHub Actions: macOS-latest-release, windows-latest-release, ubuntu-latest-devel, ubuntu-latest-release, ubuntu-latest-oldrel 

## R CMD check results
0 errors | 0 warnings | 2 notes

Any package is larger than 5Mb.
```
> checking installed package size ... NOTE
installed size is  9.9Mb
sub-directories of 1Mb or more:
  libs   9.5Mb
```

This is a Stan-based R package.
```
> checking for GNU extensions in Makefiles ... NOTE
GNU make is a SystemRequirements.
```

## Downstream dependencies

There are currently no downstream dependencies for this package.
