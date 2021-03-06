#' @title Find variable by name or label
#' @name find_var
#'
#' @description This functions finds variables in a data frame, which variable
#'                names or variable (and value) label attribute match a specific
#'                pattern. Regular expression for the pattern is supported.
#'
#' @param data A data frame.
#' @param pattern Character string to be matched in \code{data}. May also be a
#'          character vector of length > 1 (see 'Examples'). \code{pattern} is
#'          searched for in column names and variable label attributes of
#'          \code{data} (see \code{\link[sjlabelled]{get_label}}). \code{pattern} might also
#'          be a regular-expression object, as returned by \code{\link[stringr]{regex}},
#'          or any of \pkg{stringr}'s supported \code{\link[stringr]{modifiers}}.
#' @param ignore.case Logical, whether matching should be case sensitive or not.
#' @param search Character string, indicating where \code{pattern} is sought.
#'          Use one of following options:
#'          \describe{
#'            \item{\code{"name_label"}}{The default, searches for \code{pattern} in
#'                  variable names and variable labels.}
#'            \item{\code{"name_value"}}{Searches for \code{pattern} in
#'                  variable names and value labels.}
#'            \item{\code{"label_value"}}{Searches for \code{pattern} in
#'                  variable and value labels.}
#'            \item{\code{"name"}}{Searches for \code{pattern} in
#'                  variable names.}
#'            \item{\code{"label"}}{Searches for \code{pattern} in
#'                  variable labels}
#'            \item{\code{"value"}}{Searches for \code{pattern} in
#'                  value labels.}
#'            \item{\code{"all"}}{Searches for \code{pattern} in
#'                  variable names, variable and value labels.}
#'          }
#' @param out Output (return) format of the search results. May be abbreviated
#'          and must be one of:
#'          \describe{
#'            \item{\code{"table"}}{A tabular overview (as data frame) with
#'              column indices, variable names and labels of matching variables.
#'            }
#'            \item{\code{"df"}}{A data frame with all matching variables.}
#'            \item{\code{"index"}}{
#'              A named vector with column indices of all matching variables.
#'            }
#'          }
#' @param fuzzy Logical, if \code{TRUE}, "fuzzy matching" (partial and
#'          close distance matching) will be used to find \code{pattern}
#'          in \code{data} if no exact match was found. \code{\link{str_pos}}
#'          is used for fuzzy matching.
#' @param as.df Deprecated, use \code{out = "df"} instead.
#' @param as.varlab Deprecated, use \code{out = "table" instead.}
#'
#' @return By default (i.e. \code{out = "table"}, returns a data frame with three
#'         columns: column number, variable name and variable label. If
#'         \code{out = "index"}, returns a named vector with column indices
#'         of matching variables (variable names are used as names-attribute);
#'         if \code{out = "df"}, returns the matching variables as data frame
#'
#' @details This function searches for \code{pattern} in \code{data}'s column names
#'            and - for labelled data - in all variable and value labels of \code{data}'s
#'            variables (see \code{\link[sjlabelled]{get_label}} for details on variable labels and
#'            labelled data). Search is performed using the
#'            \code{\link[stringr]{str_detect}} functions; hence, regular
#'            expressions are supported as well, by simply using
#'            \code{pattern = stringr::regex(...)}.
#'
#' @examples
#' data(efc)
#'
#' # find variables with "cop" in variable name
#' find_var(efc, "cop")
#'
#' # return data frame with matching variables
#' find_var(efc, "cop", out = "df")
#'
#' # or return column numbers
#' find_var(efc, "cop", out = "index")
#'
#' # find variables with "dependency" in names and variable labels
#' library(sjlabelled)
#' find_var(efc, "dependency")
#' get_label(efc$e42dep)
#'
#' # find variables with "level" in names and value labels
#' res <- find_var(efc, "level", search = "name_value", out = "df")
#' res
#' get_labels(res, attr.only = FALSE)
#'
#' # use sjPlot::view_df() to view results
#' \dontrun{
#' library(sjPlot)
#' view_df(res)}
#'
#' @importFrom stringr regex coll str_detect
#' @importFrom sjlabelled get_labels
#' @importFrom purrr map_lgl
#' @export
find_var <- function(data,
                     pattern,
                     ignore.case = TRUE,
                     search = c("name_label", "name_value", "label_value", "name", "label", "value", "all"),
                     out = c("table", "df", "index"),
                     fuzzy = FALSE,
                     as.df,
                     as.varlab) {
  # check valid args
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = F)
  }

  # match args
  search <- match.arg(search)
  out <- match.arg(out)

  # check deprecated
  if (!missing(as.df)) {
    message("`as.df` is deprecated. Please use `out = \"df\" instead.")
    out <- "df"
  }

  if (!missing(as.varlab)) {
    message("`as.varlab` is deprecated. Please use `out = \"table\" instead.")
    out <- "table"
  }


  pos1 <- pos2 <- pos3 <- c()

  # search for pattern in variable names
  if (search %in% c("name", "name_label", "name_value", "all")) {
    # check variable names
    if (inherits(pattern, "regex"))
      pos1 <- which(stringr::str_detect(colnames(data), pattern))
    else
      pos1 <- which(stringr::str_detect(colnames(data), stringr::coll(pattern, ignore_case = ignore.case)))

    # if nothing found, find in near distance
    if (sjmisc::is_empty(pos1) && fuzzy && !inherits(pattern, "regex")) {
      pos1 <- str_pos(search.string = colnames(data), find.term = pattern, part.dist.match = 1)
    }
  }


  # search for pattern in variable labels
  if (search %in% c("label", "name_label", "label_value", "all")) {
    # get labels and variable names
    labels <- sjlabelled::get_label(data)

    # check labels
    if (inherits(pattern, "regex"))
      pos2 <- which(stringr::str_detect(labels, pattern))
    else
      pos2 <- which(stringr::str_detect(labels, stringr::coll(pattern, ignore_case = ignore.case)))

    # if nothing found, find in near distance
    if (sjmisc::is_empty(pos2) && fuzzy && !inherits(pattern, "regex")) {
      pos2 <- str_pos(search.string = labels, find.term = pattern, part.dist.match = 1)
    }
  }

  # search for pattern in value labels
  if (search %in% c("value", "name_value", "label_value", "all")) {
    labels <- sjlabelled::get_labels(data, attr.only = F)

    # check value labels with regex
    if (inherits(pattern, "regex")) {
      pos3 <- which(purrr::map_lgl(labels, ~ any(stringr::str_detect(.x, pattern))))
    } else {
      pos3 <-
        which(purrr::map_lgl(labels, ~ any(stringr::str_detect(
          .x, stringr::coll(pattern, ignore_case = ignore.case)
        ))))
    }

    # if nothing found, find in near distance
    if (sjmisc::is_empty(pos3) && fuzzy && !inherits(pattern, "regex")) {
      pos3 <- which(purrr::map_lgl(
        labels,
        function(.x) {
          p <- str_pos(
            search.string = .x,
            find.term = pattern,
            part.dist.match = 1
          )
          p[1] != -1
        }))
    }
  }

  # get unique variable indices
  pos <- unique(c(pos1, pos2, pos3))
  # remove -1
  pos <- pos[which(pos != -1)]

  # return data frame?
  if (out == "df") {
    return(data[, pos, drop = FALSE])
  }

  # return variable labels?
  if (out == "table") {
    return(data_frame(
      col.nr = pos,
      var.name = colnames(data)[pos],
      var.label = sjlabelled::get_label(data[, pos, drop = FALSE], def.value = colnames(data)[pos])
    ))
  }

  # use column names
  names(pos) <- colnames(data)[pos]
  pos
}
