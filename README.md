# QMDTemplate

This is a Typst package designed to integrate R code into Typst
documents, specifically for statistical academic assignments to be an
alternative to Quarto documents.

------------------------------------------------------------------------

## Prerequisites

1.  R installed (https://cran.r-project.org/mirrors.html)
2.  Typst installed
3.  PowerShell (Windows user)
4.  VS Code (recommended but optional)

------------------------------------------------------------------------

## 1. Template Installation

Move the included rsetup folder into your local Typst packages
directory:

    C:/Users/[YourUser]/AppData/Local/typst/packages/local/

------------------------------------------------------------------------

## 2. Global "rbuild" Setup (PowerShell)

1.  Place your build.R and qmdhooks.R in a permanent reference folder
    (e.g., C:/Users/\[YourUser\]/Desktop/reference)

2.  Open PowerShell

3.  Run the following command to find the path of your Rscript.exe:

    ```Get-ChildItem -Path "C:\Program Files\R" -Filter "Rscript.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object FullName```

4.  Open your PowerShell profile by typing:

    ```notepad $PROFILE```

in the terminal.

5.  Add the following function, ensuring the path matches your R
    version:

``` powershell
function rbuild {
    & "C:\Program Files\R\R-4.5.2\bin\x64\Rscript.exe" "G:\My Drive\reference\build.R" $args
}
```

6.  Close PowerShell

------------------------------------------------------------------------

## 3. Usage

At the top of your .typ document, import the package:

    #import "@local/rsetup:0.1.0": *;
    #show: qmdtemplate.with(
      title: "Title",
      author: "Author"
    )

    ``` r
    #Global Setup
    set.seed(123) #For Reproducability
    ```

------------------------------------------------------------------------

## 4. Execution

Navigate to your project folder in PowerShell and run:

    rbuild your_filename.typ

(Alternatively, use the terminal inside of VS Code and it will use your
current directory)

The script will:

1.  Knit the R code into filename.knit.typ
2.  Compile that Typst file into a PDF

------------------------------------------------------------------------

## Notes
