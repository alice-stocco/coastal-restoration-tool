# Coastal Restoration Tool

This repository hosts the files needed to run an interactive tool that supports the decision-making process in selecting suitable ecological restoration techniques for coastal areas and wetlands along the river-to-sea continuum.  

The application is based on Shiny and is available at: https://ecological.shinyapps.io/coastal_restoration_tool/ .

## Get the data and run the app on your computer
To run the app locally, contribute to the development of future versions, and update the database, you can get in touch with the author writing at alice.stocco@unive.it and download the files from this repository.

Alternatively, you can clone this repository with the following command:
```bash
git clone https://github.com/your-username/coastal_restoration_tool.git
```

## Requirements 

```R
    R (version 4.3.3 or later)
    Shiny
    Other R packages as specified in the app.R file
```

## Installation

Open R in your favourite environment (see https://www.r-project.org/ for further details).

Install the required R packages:

```R
 install.packages(c("shiny", "dplyr", "DT", "ggplot2", "fmsb", "readxl"))
```

## Launch the app:
You can either open the script app.R and run the code,
 or
run the command:
```R
shiny::runApp("/path/to/coastal_restoration_tool/app") # change with your path
```

## Database Updates

The database (restoration_tool_dataset.xlsx) is located in the /tool folder. To update the data, contact alice.stocco@unive.it . 

## License

This project is distributed under the GNU GPL v3 license. Please refer to the LICENSE file for more information.
