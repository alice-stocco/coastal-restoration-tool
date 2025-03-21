# Coastal Restoration Tool

This repository contains the files needed to run an interactive tool that supports the decision-making process when evaluating suitable ecological restoration techniques for coastal areas and wetlands along the river-to-sea continuum.  
Data were collected for the scientific work "Evaluating Nature-Based Adaptation Techniques in Human Dominated Coastal Continuums" by Horneman F., Stocco A., et al. (under review, to be updated soon).
If you consult the app, use the files or the data, please cite the paper:
(citation to be added after publication)

The application is based on Shiny and its graphical interface is also available on shinyapps.io.

## How to run the app on your computer
### Step 1: Download the script and the data
To run the app locally, contribute to the development of future versions, and update the database, you can download the folder /tool from this repository to get the files.
Alternatively, you can clone this repository with the following command:
```bash
git clone https://github.com/your-username/coastal_restoration_tool.git
```
After downloading or cloning, you will have a folder called tool that contains the following files:
    app.R: The main Shiny app script
    restoration_tool_dataset.xlsx: The database file

## Step 2: Open R and run the script
Make sure you have R installed (you can download it from [here](https://www.r-project.org/)).
Once the files are downloaded and the packages are installed, open the app.R file and run the script.
Read carefully the script and follow the instruction. Remember to replace the with your actual path to the folder /tool.
The app will launch in your default web browser.

## Step 3: Use the tool
Once the app is running, this interactive window will appear:
![image](https://github.com/user-attachments/assets/9271e0f1-58a5-4055-be1b-2ce911288241)
By clicking on the upper left panel, a dropdown menu will appear. 
![image](https://github.com/user-attachments/assets/59f3cda1-48ea-498b-b245-62290454483f)
Click on the pressure you want to select (e.g. erosion risk): a series of restoration techniques among those assessed by the experts participating in the project will appear on the right side of the interface.
![image](https://github.com/user-attachments/assets/993bef8e-bd52-4ee8-b8aa-3cc2610a1fe6)
When one technique is selected, the agreement level among experts on the effectiveness of such technique to address the selected pressure is shown on the left, while the radarcharts show the scores for both the structural features of the technique and the natural processes that are supported by it:
![image](https://github.com/user-attachments/assets/7cacb2d7-a42e-4eab-a979-5eb11ec053d6)


## Database Updates
The database with the techniques and the scores (restoration_tool_dataset.xlsx) is located in the /tool folder. Any researcher in the field is very welcome to contribute for updating the databse with new techniques and scores: if you are willing to contribute, please contact alice.stocco@unive.it . 

## License

This project is distributed under the GNU GPL v3 license. Please refer to the LICENSE file for more information.
