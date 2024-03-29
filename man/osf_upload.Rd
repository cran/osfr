% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osf_upload.R
\name{osf_upload}
\alias{osf_upload}
\title{Upload files to OSF}
\usage{
osf_upload(
  x,
  path,
  recurse = FALSE,
  conflicts = "error",
  progress = FALSE,
  verbose = FALSE
)
}
\arguments{
\item{x}{The upload destination on OSF. Can be one of the following:
\itemize{
\item An \code{\link{osf_tbl_node}} with a single project or component.
\item An \code{\link{osf_tbl_file}} with a single directory.
}}

\item{path}{A character vector of paths pointing to existing
local files and/directories.}

\item{recurse}{If \code{TRUE}, fully recurse directories included in \code{path}. You
can also control the number of levels to recurse by specifying a positive
number.}

\item{conflicts}{This determines what happens when a file with the same name
exists at the specified destination. Can be one of the following:
\itemize{
\item \code{"error"} (the default): throw an error and abort the file transfer operation.
\item \code{"skip"}: skip the conflicting file(s) and continue transferring the
remaining files.
\item \code{"overwrite"}: replace the existing file with the transferred copy.
}}

\item{progress}{Logical, if \code{TRUE} progress bars are displayed for each file
transfer. Mainly useful for transferring large files. For tracking lots of
small files, setting \code{verbose = TRUE} is more informative.}

\item{verbose}{Logical, indicating whether to print informative messages
about interactions with the OSF API (default \code{FALSE}).}
}
\value{
An \code{\link{osf_tbl_file}} containing the uploaded files and directories
that were directly specified in \code{path}.
}
\description{
Upload local files to a project, component, or directory on OSF.
}
\section{File and directory paths}{

The \code{x} argument indicates \emph{where} on OSF the files will be uploaded (\emph{i.e.},
the destination). The \code{path} argument indicates \emph{what} will be uploaded,
which can include a combination of files \emph{and} directories.

When \code{path} points to a local file, the file is uploaded to the \emph{root} of the
specified OSF destination, regardless of where it's on your local machine
(\emph{i.e.}, the intermediate paths are not preserved). For example, the
following would would upload both \code{a.txt} and \code{b.txt} to the root of
\code{my_proj}:

\if{html}{\out{<div class="sourceCode">}}\preformatted{osf_upload(my_proj, c("a.txt", "subdir/b.txt"))`
}\if{html}{\out{</div>}}

When \code{path} points to a local directory, a corresponding directory will be
created at the root of the OSF destination, \code{x}, and any files within the
local directory are uploaded to the new OSF directory. Therefore, we could
maintain the directory structure in the above example by passing \code{b.txt}'s
parent directory to \code{path} instead of the file itself:

\if{html}{\out{<div class="sourceCode">}}\preformatted{osf_upload(my_proj, c("a.txt", "subdir2"))
}\if{html}{\out{</div>}}

Likewise, \code{osf_upload(my_proj, path = ".")} will upload your entire current
working directory to the specified OSF destination.
}

\section{Uploading to subdirectories}{

In order to upload directly to an existing OSF directory you would first need
to retrieve the directory as an \code{\link{osf_tbl_file}}. This can be accomplished by
passing the directory's unique identifier to \code{\link[=osf_retrieve_file]{osf_retrieve_file()}}, or, if
you don't have the ID handy, you can use \code{\link[=osf_ls_files]{osf_ls_files()}} to retrieve the
directory by name.

\if{html}{\out{<div class="sourceCode">}}\preformatted{# search for the 'rawdata' subdirectory within top-level 'data' directory
target_dir <- osf_ls_files(my_proj, path = "data", pattern = "rawdata")
# upload 'a.txt' to data/rawdata/ on OSF
osf_upload(target_dir, path = "a.txt")
}\if{html}{\out{</div>}}
}

\section{A note about synchronization}{

While \code{osf_download()} and \code{osf_upload()} allow you to conveniently shuttle
files back and forth between OSF and your local machine, it's important to
note that \strong{they are not file synchronization functions}. In contrast to
something like \href{https://rsync.samba.org}{\code{rsync}},
\code{osf_download()}/\code{osf_upload()} do not take into account a file's contents or
modification time. Whether you're uploading or downloading, if \code{conflicts = "overwrite"}, osfr will overwrite the existing file regardless of whether it
is the more recent copy. You have been warned.
}

\examples{
\dontrun{
# Create an example file to upload to our example project
write.csv(iris, file = "iris.csv")
project <- osf_create_project("Flower Data")

# Upload the first version
osf_upload(project,"iris.csv")

# Modify the data file, upload version 2, and view it on OSF
write.csv(subset(iris, Species != "setosa"), file = "iris.csv")
project \%>\%
  osf_upload("iris.csv", conflicts = "overwrite") \%>\%
  osf_open()
}

}
\seealso{
\itemize{
\item \code{\link[=osf_download]{osf_download()}} for downloading files and directories from OSF.
\item \code{\link[=osf_ls_files]{osf_ls_files()}} for listing files and directories on OSF.
}
}
