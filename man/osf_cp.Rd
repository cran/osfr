% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osf_cp.R
\name{osf_cp}
\alias{osf_cp}
\title{Copy a file or directory}
\usage{
osf_cp(x, to, overwrite = FALSE, verbose = FALSE)
}
\arguments{
\item{x}{An \code{\link{osf_tbl_file}} containing a single file or directory.}

\item{to}{Destination where the file or directory will be copied.
This can be one of the following:
\itemize{
\item An \code{\link{osf_tbl_node}} with a single project or component.
\item An \code{\link{osf_tbl_file}} with a single directory.
}}

\item{overwrite}{Logical, if a file or directory with the same name already
exists at the destination should it be replaced with \code{x}?}

\item{verbose}{Logical, indicating whether to print informative messages
about interactions with the OSF API (default \code{FALSE}).}
}
\value{
An \code{\link{osf_tbl_file}} containing the updated OSF file.
}
\description{
Use \code{osf_cp()} to make a copy of a file or directory in a new location.
}
\details{
Note that a file (or directory) cannot be moved or copied onto itself, even
if \code{overwrite = TRUE}.
}
\examples{
\dontrun{
project <- osf_create_project("Flower Data")

write.csv(iris, file = "iris.csv")
data_file <- osf_upload(project,"iris.csv")

# Create a new directory to copy our file to
data_dir <- osf_mkdir(project, "data")

# Copy the file to our data directory
data_file <- osf_cp(data_file, to = data_dir)

# Copy directory to new component
data_comp <- osf_create_component(project, title = "data", category = "data")
data_dir \%>\%
  osf_cp(to = data_comp) \%>\%
  osf_open()
}

}
\seealso{
Other OSF file operations: 
\code{\link{osf_mkdir}()},
\code{\link{osf_mv}()},
\code{\link{osf_rm}()}
}
\concept{OSF file operations}
