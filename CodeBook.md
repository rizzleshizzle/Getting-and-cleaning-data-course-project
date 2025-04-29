## Overview

This code book describes the variables, data, and transformations performed to clean and tidy the UCI HAR Dataset.

Each observation in `tidy_dataset.txt` is a unique combination of `Subject` and `Activity`.

- `Subject`: ID of the participant (1–30)
- `Activity`: Descriptive activity name (e.g. WALKING, LAYING)
- The remaining variables are the **average values** of original sensor measurements, limited to mean and standard deviation values.

## Variable Naming Conventions

- `Time` = time-domain signals
- `Frequency` = frequency-domain signals
- `Accelerometer` = acceleration measurement
- `Gyroscope` = gyroscope measurement
- `Mean` = mean value
- `STD` = standard deviation
- `X`, `Y`, `Z` = axis of measurement

## Data Cleaning Steps

1. Merged the training and test datasets using `rbind()`.
2. Extracted only measurements with `mean()` or `std()` in their names.
3. Applied descriptive activity names.
4. Cleaned variable names to remove special characters and expand abbreviations.
5. Created a second tidy dataset with the average of each variable per subject and activity.
