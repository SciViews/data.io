#' Calculate path relative to a reference directory
#'
#' @param file A single string with the path to a file or directory to transform
#' as relative.
#' @param dir A single string with the "reference" directory (by default, the
#' directory provided by [getwd()].
#'
#' @description After normalizing both `file` and `dir`, try to find a common
#' ancestor directory to build a path for `file` relative to `dir`.
#'
#' @return A single character string with the relative path, or `file`
#' unmodified if `file` is totally unrelated to `dir`.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [getwd()], [normalizePath()]
#' @keywords utilities
#' @concept relative paths
#' @examples
#' relative_path("/Users/me/project/file.txt", "/Users/me/project")
#' relative_path("/Users/me/project/subdir/file.txt", "/Users/me/project")
#' relative_path("/Users/me/file.txt", "/Users/me/project")
#' relative_path("/Users/me/subdir/file.txt", "/Users/me/project")
#' relative_path("/Users/file.txt", "/Users/me/project")
#' relative_path("/Users/subdir1/subdir2/file.txt", "/Users/me/project")
#' relative_path("/Unrelated/file.txt", "/Users/me/project")
#' \donttest{
#' relative_path("file.txt", "/Users/me/project")
#' relative_path("~/file.txt", "/Users/me/project")
#' relative_path("./file.txt", "/Users/me/project")
#' relative_path(file.path(getwd(), "data.io", "file.txt"))
#' }
relative_path <- function(file, dir = getwd()) {
  file2 <- normalizePath(file, winslash = "/", mustWork = FALSE)
  dir <- normalizePath(dir, winslash = "/", mustWork = FALSE)

  end_with_slash <- function(path) {
    if (substring(path, nchar(path)) != "/") {
      paste0(path, "/")
    } else path
  }

  # If dir is part of file2, it is easy to calculate the relative path
  dir <- end_with_slash(dir)
  n <- nchar(dir)
  if (substring(file2, 1, n) == dir)
    return(substring(file2, n + 1))

  # Try recursively with parent dir to find a common ancestor
  # For instance:
  # file = "/Users/me/project/data/dat.xls"
  # versus
  # dir = "/Users/me/project/reports"
  # must give "../data/dat.xls"
  back_dir <- ""
  while (dirname(dir) != "/") {
    dir <- end_with_slash(dirname(dir))
    back_dir <- paste0(back_dir, "../")
    n <- nchar(dir)
    if (substr(file2, 1, n) == dir)
      return(paste0(back_dir, substring(file2, n + 1)))
  }

  # If nothing works, return file unmodified
  file
}
