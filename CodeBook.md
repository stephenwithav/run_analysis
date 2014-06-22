CodeBook for Course Project
===========================

Lines 1-8 in `run_analysis.R` store the test and training sets into
the appropriate variables.

Lines 11-12 read in the `features` and `activity_labels`, specifying
colClasses to simplify the later code.


## Step 1

Lines 16-17 merge the training and test set, with line 17 setting the
column names.  (Line 16 deliberately omits `test_Y`, `train_Y`,
`test_subject`, and `train_subject`, as `grep` would omit tho
columns, forcing me to add them in later.)


## Step 2

Line 21 resets `dataset` to contain only the data in columns about
means and standard deviations.

Line 22 adds `"SubjectID"` and `"Activity"` to the `features`
character vector, which will later be used to set the column names of
the expanded `dataset`.

Line 23 prepends the `SubjectID` and appends the `Activity` fields to
`dataset`.  Line 24, meanwhile, sets the column names.


## Step 3

Line 29 simply replaces the `"Activity"` field, converting its id to
the appropriate string.


## Step 4

Lines 33-34 specify a list of regular expressions and their intended
replacements.  The first value splits camelCase variable names, while
the oter values are self explanatory.

Line 36 loops over the patterns variable, replacing each match with
the specified substitution.

Lines 37-38 set the column names to all lower case characters, as the
lectures suggested.


## Step 5

Line 42 initializes the `tidyset` variable using the `aggregate`
function, which unfortunately prepends two non-tidy columns to the
dataframe; line 43 renames those and prepends `"avg_"` to the feature
column names..

Line 45 removes the nowly named `avg_activity` and `avg_subject_id`,
as they are duplicated.

Line 47 outputs the now tidy dataset to `tidyset.csv` in the current
directory.
