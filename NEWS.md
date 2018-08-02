# sjmisc 2.7.4

## New functions

* `has_na()` to check if variables or observations in a data frame contain `NA`, `NaN` or `Inf` values. Convenient shortcuts for this function are `complete_cases()`, `incomplete_cases()`, `complete_vars()` and `incomplete_vars()`.
* `total_mean()` to compute the overall mean of all values from all columns in a data frame.
* `prcn()` to convert numeric scalars between 0 and 1 into a character-percentage value.
* `numeric_to_factor()` to convert numeric variables into factors, using associated value labels as factor levels.

## Changes to functions

* `set_na()` now also replaces different values per variable into `NA`.
* Changed behaviour of `row_sums()` and missing values. `row_sums()` gets a `n`-argument and now computes row sums if a row has at least `n` non-missing values.

# sjmisc 2.7.3

## General

* A test-suite was added to the package.
* Updated reference in `CITATION` to the publication in the Journal of Open Source Software.

## New functions

* `is_cross_classified()` to check whether two factors are partially crossed.

## Changes to functions

* `ref_lvl()` now also accepts value labels as value for the `lvl`-argument. Additionally, `ref_lvl()` now also works for factor with non-numeric factor levels and simply returns `relevel(x, ref = lvl)` in such cases.

## Bug fixes

* Fixed encoding issues in `rec()` with direct labelling for certain locales.
* Fixed issue in `count_na()`, which did not print labels of tagged `NA` values since the last revision of `frq()`.
* Fixed issue in `merge_imputation()` for cases where original data frame had less columns than imputed data frames.
* Fixed issue in `find_var()` for fuzzy-matching in all elements (i.e. when `fuzzy = TRUE` and `search = "all"`).

# sjmisc 2.7.2

## New functions

* `round_num()` to round only numeric values in a data frame.

## General

* Improved performance for `merge_df()`. Furthermore, `add_rows()` was added as alias for `merge_df()`.
* `merge_df()` resp. `add_rows()` now create a unique `id`-name instead of dropping the ID-variable, in case `id` has the same name of any existing variables in the provided data frames.
* Improved performance for `descr()` and minor changes to the output.

## Support for `mids`-objects (package _mice_)

Following functions now also work on `mids`-objects, as returned by the `mice()`-function:
* `row_count()`, `row_sums()`, `row_means()`, `rec()`, `dicho()`, `center()`, `std()`, `recode_to()` and `to_long()`.

## Changes to functions

* The `weight.by`-argument in `frq()` now should be a variable name from a variable in `x`, and no longer a separate vector.

## Bug fixes

* `descr()` does not work with character vectors, so these are being removed now.

# sjmisc 2.7.1

## General

* Fix typos and revise outdated paragraphs in vignettes.

## New functions

The recoding and transformation functions get scoped variants, allowing to select variables based on logical conditions described in a function:

* `rec_if()` as scoped variant of `rec()`.
* `dicho_if()` as scoped variant of `dicho()`.
* `center_if()` as scoped variant of `center()`.
* `std_if()` as scoped variant of `std()`.
* `split_var_if()` as scoped variant of `split_var()`.
* `group_var_if()` and `group_label_if()` as scoped variant of `group_var()` and `group_label()`.
* `recode_to_if()` as scoped variant of `recode_to()`.
* `set_na_if()` as scoped variant of `set_na()`.

## Changes to functions

* New function `remove_cols()` as alias for `remove_var()`.
* `std()` gets a new robust-option, `robust = "2sd"`, which divides the centered variables by two standard deviations.
* Slightly improved performance for `set_na()`.

## Bug fixes

* `frq()` now removes empty columns before computing frequencies, because applying `frq()` on empty vectors caused an error.
* `empty_cols()` and `empty_rows()` (and hence, `remove_empty_cols()` and `remove_empty_rows()`) caused an error for data frames with only one column resp. row, or if `x` was a vector and no data frame.
* `frq()` now removes missing values from input when weights are applied, to ensure that input and weights have same length.

# sjmisc 2.7.0

## General

* *Breaking changes*: The `append`-argument in recode and transformation functions like `rec()`, `dicho()`, `split_var()`, `group_var()`, `center()`, `std()`, `recode_to()`, `row_sums()`, `row_count()`, `col_count()` and `row_means()` now defaults to `TRUE`.
* The `print()`-method for `descr()` now accepts a `digits`-argument, to specify the rounding of the output.
* Cross refences from `dplyr::select_helpers` were updated to `tidyselect::select_helpers`.

## New functions

* `is_whole()` as counterpart to `is_float()`.

## Changes to functions

* `frq()` now prints variable names for non-labelled data, adds variable names in braces for labelled data and omits the _label_ column for non-labelled data.
* `frq()` now prints mean and standard deviation in the header line of the output.
* `frq()` now gets a `auto.grp`-argument to automatically group variables with many unique values.
* `frq()` now gets a `show.strings`-argument to omit string variables (character vectors) from being printed as frequency table.
* `frq()` now gets a `grp.strings`-argument to group similar string values in the frequency table.
* `frq()` gets an `out`-argument, to print output to console, or as HTML table in the viewer or web browser.
* `descr()` gets an `out`-argument, to print output to console, or as HTML table in the viewer or web browser.

## Bug fixes

* `is_empty()` returned `TRUE` for single vectors with `NA` being the first element.
* Fix issue where due to a bug during code cleanup, `remove_empty_rows()` did no longer remove empty rows, but columns.

# sjmisc 2.6.3

## General

* Revised examples that used removed methods from other packages.
* Use select-helpers from package *tidyselect*, instead of *dplyr*.
* Beautiful colored output for `frq()`, `descr()` and `flat_table()`.

## Changes to functions

* `rec()` now also recodes doubles with floating points, if a range of values is specified.
* `std()` and `center()` now use `include.fac = FALSE` as default option.
* `std()` gets a `robust`-argument, to divide variables either by standard deviation, or - in case of asymmetrically distributed variables - median absolute deviation or Gini's mean difference.
* `frq()` now shows total and valid N in output.

## Bug fixes

* `center()`, `std()`, `dicho()`, `split_var()` and `group_var()` did not work correctly for grouped data frames.
* `frq()` did not print multiple variables when applied on grouped data frames.

# sjmisc 2.6.2

## Changes to functions

* Arguments `as.df` and `as.varlab` in function `find_var()` are now deprecated. Please use `out` instead.
* `rotate_df()` preserves attributes.
* `is_float()` is now exported as function.

## Bug fixes

* Fixed bug for `to_label()`, when `x` was a character vector and argument `drop.levels` was `TRUE`.

# sjmisc 2.6.1

## General

* Fixed issue with latest tidyr-update on CRAN.

## Bug fixes

* `frq()` did not correctly calculate valid and cumulative percentages when using weights.

# sjmisc 2.6.0

## General
* All labelled-data functions were removed and are now in package *sjlabelled*.

## New functions

* `remove_var()` as pipe-friendly function to remove variables from data frames.
* `var_type()` as pipe-friendly function to determine the type of variables.
* `all_na()` to check whether a vector only consists of NA values.
* `rotate_df()` to rotate data frames (switch columns and rows).
* `shorten_string()`, to shorten strings to a certain maxium number of chars.

## Changes to functions

* Following functions now also work on grouped data frames: `dicho()`, `split_var()`, `group_var()`, `std()` and `center()`.
* Argument `groupcount` in `split_var()`, `group_var()` and `group_labels()` is now named `n`.
* Argument `groupsize` in `group_var()` and `group_labels()` is now named `size`.
* `frq()` gets a revised print-method, which does not print the result to console when captured in an object (i.e., `x <- frq(x)` no longer prints the result).
* `frq()` no longer prints (redundant) labels for factors w/o value label attributes.
* `frq()` adds information about the variable type in the table caption (only for variables with variable labels).
* `frq()` adds information about groups when printing grouped, non-labelled variables.
* `descr()` now also prints information about the variable type.
* `to_character()` now preserves variable labels.

# sjmisc 2.5.0

## General

* **sjmisc** now uses dplyr's [tidyeval-approach](http://dplyr.tidyverse.org/articles/programming.html) to evaluate arguments. This means that the select-helper-functions (like `one_of()` or `contains()`) no longer need to be prefixed with a `~` when used as argument within **sjmisc**-functions.
* All labelled-data functions are now deprecated and will become defunct in future package versions. The labelled-data functions have been moved into a separate package, *sjlabelled*.

## New functions

* `row_count()` to count specific values in a data frame per observation.
* `col_count()` to count specific values in a data frame per variable.
* `str_start()` and `str_end()` to find starting and end indices of patterns inside strings.

## Changes to functions

* The output for `frq()` now always includes a `NA`-row, but no longer prints a value for the `NA`-row.
* `merge_imputations()` gets a `summary`-argument to plot a graphical summary of the quality of the merging process.

## Bug fixes

* `add_columns()` and `replace_columns()` crashed R when no data frame was specified in `...`-ellipses argument.
* `descr()` and `frq()` used wrong variable labels when processing grouped data frames for specific situations, where the grouping variable had no sequences values.
* `descr()` did not work for large data frames, because internally, because `psych::describe()` switched to fast mode by default then (removing columns from the output).

# sjmisc 2.4.0

## General

* Argument `value` in `set_na()` is deprecated. Please use `na` instead.
* Argument `recodes` in `rec()` is deprecated. Please use `rec` instead.
* Argument `lab` in `set_label()` is deprecated. Please use `label` instead.
* Argument `value` in `add_labels()` and `replace_labels()` is deprecated. Please use `labels` instead.
* Argument `value` in `ref_lvl()` is deprecated. Please use `lvl` instead.

## New functions

* `row_sums()` as wrapper of `rowSums()` to compute row sums, but works within pipe-workflow and with select-helpers for variables, and always returns a tibble..
* `row_means()` as wrapper of `sjstats::mean_n()` to compute row means, but works within pipe-workflow and with select-helpers for variables, and always returns a tibble..
* `%nin%` as complement to `%in%`.

## Changes to functions

* Functions `rec()`, `dicho()`, `center()`, `std()`, `recode_to()` and `group_var()` get an `append`-argument, to optionally return the original data including the transformed variables as new columns.
* `var_labels()` and `var_rename()` now give a warning if specified variables to rename or relabel do not exist in the data frame. Non-matching variables are ignored.
* If `model.term` does not exist in models, `spread_coef()` now prints the name of non-existing coefficients.
* `find_var()` gets a `fuzzy`-argument to enable fuzzy-matching for search pattern.

## Bug fixes

* `remove_empty_cols()` returned an empty data frame, when input data frame had no empty columns.
* `remove_empty_rows()` returned an empty data frame, when input data frame had no empty rows.
* `add_columns()` and `replace_columns()` in some cases coerced data frames of class `data.frame` with only one column into a vector, which gave an error when binding columns.
* Argument `part.dist.match` in `str_pos()` caused an error when being larger than 0.

# sjmisc 2.3.1

## General

* Re-exports `magrittr::%>%` (Bob Rudis said more packages should do so).

## New functions

* `replace_columns()` to replace variables in one data frame with variables from other data frames.

## Changes to functions

* `descr()` gets a `max.length`-argument to shorten variable labels in the output to a specific number of chars.
* `descr()` now also reports the percentage of missing values.
* `set_na()` no longer gives a warning when trying to replace values with `NA` for vectors that completely contained `NA`s.

## Bug fixes

* `descr()` now also works on single vectors as data argument.
* Fixed bugs with `write_*()`-functions.

# sjmisc 2.3.0

## General

* Added package-vignettes.
* Functions were largely revised to work seamlessly within the tidyverse. This may break existing code, but in the long run, consistent api-design makes working with the package more intuitive. See `vignette("design_philosophy", "sjmisc")` for more details.
* `as_labelled()` only converts vectors into `labelled`-class if vector has label attributes. This ensures that data can be properly saved into other formats, e.g. with `write_spss()`.
* The `write_*()`-functions have been revised and should now save data frame with any common classes of vectors (labelled, factor, numeric, atomic...).

## New functions

* `center()` and `std()` are moving from package `sjstats` to `sjmisc`.
* `add_columns()` to bind columns of first data frame at the end of all data frames.

## Changes to functions

* `frq()` now has the same argument-structure as `flat_table()`.
* Following functions now follow a consistent tidyverse-approach, with the data being the first argument, followed by variable names: `add_labels()`, `replace_labels()`, `remove_labels()`, `count_na()`, `rec()`, `dicho()`, `split_var()`, `drop_labels()`, `fill_labels()`, `group_var()`, `group_labels()`, `ref_lvl()`, `recode_to()`, `replace_na()`, `set_na()` and `set_labels()`.
* `get_values()` now sorts returned values by default, to be consistent with `get_labels()`.
* `spread_coef()` gets arguments `se` and `p.val`, to define whether standard errors and p-values should be included in the return value or not.

## Bug fixes

* `merge_df()` did not copy label attributes for data frame with identical variables (that were row-bound).
* `to_value()` did not work for character vectors of class labelled, with empty values (which typically have no value label).

# sjmisc 2.2.1

## Bug fixes

* The `sort.frq` did not work `frq()`.

# sjmisc 2.2.0

## New functions

* `zap_inf()` to "clean" vectors from `NaN` and infinite values.
* `descr()` to provide basic descriptive statistics (similar to `describe()` in the psych-package), but including variable labels and usable in pipe-workflows. Also works with grouped data frames.

## Changes to functions

* `rec()`, `split_var()` and `dicho()` get an argument `suffix`, to append a suffix to variable (column) names, if applied on a data frame.
* Value labels in `rec()` can now directly be assigned inside the `recodes`-syntax (see 'Details' in `?rec`).
* `find_var()` gets a `as.df`-argument, to return a data frame with matching variables, instead of their column indices only.
* `find_var()` gets a `as.varlab`-argument, to return a "summary" data frame with column number, variable name and variable label.
* `flat_table()` now also accepts grouped data frames.
* `flat_table()` gets a `show.values`-argument, to add values to associated labels in output.
* `frq()` now also accepts grouped data frames.
* `frq()` gets a `weight.by`-argument to weight frequencies.
* `set_na()` can now also find values by their value labels and replace them with NA.
* `set_na()` now removes unused value labels from values that have been replaced with NA.
* The `as.tag`-argument in `set_na()` now defaults to `FALSE`.
* `get_labels()` now always returns labels in sorted order of the associated values.
* `get_labels()` gets a `drop.unused`-argument, to automatically drop labels from values that don't occur in the vector.
* For a named vector as `labels`-argument, `set_labels()` now always sorts labels in sorted order of the associated values.
* `is_empty()` gets a `first.only`-argument, to evaluate either first or all elements of a character vector.

## Bug fixes

* `set_na()` did not work on vectors of class `Date` when argument `as.tag = TRUE`.
* `flat_table()` did not show values that had no value labels. Now all categories are shown in the frequency table.
* `rec()` did not properly copy labels of tagged NA values when not all recoded values appeared in the vector.
* `frq()` did not show correct values, when value labels of a vector were not sorted according their values.
* `set_labels()` did not set labels properly for ordered factors.
* `remove_labels()` returned NA-values for value labels (instead of no value labels) when the last value label of a vector was removed.


# sjmisc 2.1.0

## New functions

* `find_var()` to find variables in data frames by name or label.
* `var_labels()` as "tidyversed" alternative to `set_label()` to set variable labels.
* `var_rename()` to rename variables.

## Changes to functions

* Following functions now get an ellipses-argument `...`, to apply function only to selected variables, but return the complete data frame (thus, overwriting existing variables in a data frame, if requested): `to_factor()`, `to_value()`, `to_label()`, `to_character()`, `to_dummy()`, `zap_labels()`, `zap_unlabelled()`, `zap_na_tags()`.

## Bug fixes

* Fixed bug with copying attributes from tibbles for `merge_df()`.
* Fixed wrong argument-description in docs of `frq()`.

# sjmisc 2.0.1

## General

* Removed package `coin` from Imports.

## New functions

* `count_na()` to print a frequency table of tagged NA values.

## Changes to functions

* `set_na()` gets a `drop.levels` argument to keep or drop factor levels of values that have been replaced with NA.
* `set_na()` gets a `as.tag` argument to set NA values as regular or tagged NA.


# sjmisc 2.0.0

## General

* **sjmisc** now supports _tagged_ `NA` values, a new structure for labelled missing values introduced by the [haven-package](https://cran.r-project.org/package=haven). This means that functions or arguments that are no longer useful, have been removed while other functions dealing with NA values have been largely revised.
* All statistical functions have been removed and are now in a separate package, [sjstats](https://cran.r-project.org/package=sjstats).
* Removed some S3-methods for `labelled`-class, as these are now provided by the haven-package.
* Functions no longer check input for type `matrix`, to avoid conflicts with scaled vectors (that were recognized as matrix and hence treated as data frame).
* `table(*, exclude = NULL)` was changed to `table(*, useNA = "always")`, because of planned changes in upcoming R version 3.4.
* More functions (like `trim()` or `frq()`) now also have data frame- or list-methods.

## New functions

* `zap_na_tags()` to turn tagged NA values into regular NA values.
* `spread_coef()` to spread coefficients of multiple fitted models in nested data frames into columns.
* `merge_imputations()` to find the most likely imputed value for a missing value.
* `flat_table()` to print flat (proportional) tables of labelled variables.
* Added `to_character()` method.
* `big_mark()` to format large numbers with big marks.
* `empty_cols()` and `empty_rows()` to find variables or observations with exclusively NA values in a data frame.
* `remove_empty_cols()` and `remove_empty_rows()` to remove variables or observations with exclusively NA values from a data frame.

## Changes to functions
* `str_contains()` gets a `switch` argument to switch the role of `x` and `pattern`.
* `word_wrap()` coerces vectors to character if necessary.
* `to_label()` gets a `var.label` and `drop.levels` argument, and now preserves variable labels by default.
* Argument `def.value` in `get_label()` now also applies to data frame arguments.
* If factor levels are numeric and factor has value labels, these are used in `to_value()` by default.
* `to_factor()` no longer generates `NA` or `NaN`-levels when converting input into factors.

## Bug fixes
* `rec()` did not recode values, when these were the first element of a multi-line string of the `recodes` argument.
* `is_empty()` returned `NA` instead of `TRUE` for empty character vectors.
* Fixed bug with erroneous assignment of value labels to subset data when using `copy_labels()` ([#20](https://github.com/strengejacke/sjmisc/issues/20))
