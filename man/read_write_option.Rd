% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_write_option.R
\name{read_write_option}
\alias{read_write_option}
\title{Define default read/write options and add items to it}
\usage{
read_write_option(new_type)
}
\arguments{
\item{new_type}{A data.frame with four columns: \code{type}, \code{read_fun},
\code{read_header} and \code{write_fun} containing each a single character string or
\code{NA}. \code{type} is the usual extension for this type of file, e.g., \code{png} for
PNG images, \code{read_fun}, \code{read_header} and \code{write_fun} are character strings
with "pkg::fun" format ("pkg" is the package containing the function and
"fun" is the function name), or just "fun" if the function
is visible on the search path.}
}
\value{
The data.frame with all known formats is returned invisibly. The same
data.frame is also saved in the \verb{read_write`` option, and can be retrieved directly with }getOption("read_write")`.
}
\description{
Define the functions that \code{\link[=read]{read()}} or write() must call to
import or export data for the different types (formats).
}
\examples{
# The default options
(read_write_option())
# To add a new type:
tail(read_write_option(data.frame(type = "png", read_fun = "png::readPNG",
  read_header = NA, write_fun = "png::writePNG", comment = "PNG image")))
}
\seealso{
\code{\link[=read]{read()}}, \code{\link[=getOption]{getOption()}}
}
\author{
Philippe Grosjean \href{mailto:phgrosjean@sciviews.org}{phgrosjean@sciviews.org}
}
\concept{labeling objects}
\keyword{utilities}
