# Personal Website using R Shiny App

This is an interactive personal website framework designed for people working in academia. It is written using R Shiny applications, including:

- a fancy about page,
- manageable publication lists,
- cool project boxes,
- an office-hour appointment system,
- a personal demo zone to play videos, draw statistical plots and so on,
- an embedded CV (in pdf) framework,
- menu, sub-menu with badges, and
- social media icons

Besides, you can add almost whatever pages and contents or change the structure of this framework as you want! If you would like to have more features in this website, please do not hesitate to contact me!

---

## Details

| File            | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| Website.Rproj   | The R project file                                           |
| ui.R            | The file that controls the layout and appearance of the app  |
| server.R        | The file that contains the instructions that computer needs to build the app |
| global.R        | The file that stores global objects                          |
| class1.csv      | Table of current classes                                     |
| class2.csv      | Table of past classes                                        |
| pre.csv         | Table of preprints                                           |
| pubs.csv        | Table of publications                                        |
| slots.csv       | Table of student appointment information (*)                 |
| thesis.csv      | Table of theses                                              |
| avatar.jpeg     | (in folder WWW) A profile photo shown on the about page      |
| img.jpg         | (in folder WWW) A random picture which can be used in any page |
| CV-Template.pdf | (in folder WWW) The CV document                              |
| iris.csv        | (in folder WWW but can be placed anywhere technically) A dataset file which can be uploaded in the "Draw the histogram!" model, w/o missing values |
| airquality.csv  | (in folder WWW but can be placed anywhere technically) A dataset file which can be uploaded in the "Draw the histogram!" model, w/ missing values |

(*) **How to use this office-hour appointment system**: 

- Set the available days for office hours each week (such as R/T) and update them using the argument `daysofweekdisabled` in the function `dateInput()`. Don't forget to update the contents in `p1()` as well.
- Set the number of available slots each day (such as 10) and update it by changing the syntax `if(count >= 15)` to `if(count >= 10)`. Don't forget to update the contents in  `p2()` as well.
- Once a date is selected, the number of slots occupied for that day will be shown below.
- In order to make an appointment successfully, a student must input his/her full information (date, name and password) and then click the button "make an appointment". There must be remaining slots available on that day. Students are not allowed to make repeated appointments on the same day. 
- The passwords can be any strings that students should design by themselves for the sake of privacy protection, though no registrations are needed. Students should always remember their passwords for each appointment, and should contact the website owner if they forget their passwords. 
- The website owner can check appointment records (and particularly the passwords) in the file slots.csv.
- In order to check appointment records, a student must input his/her name and password, and then click the button "check appointments". All appointment records made under this name and password will be shown.
- In order to delete a certain appointment record, a student must input his/her full information (date, name and password) and then click the button "delete the appointment". Only existed appointment records can be deleted.
- In order to reschedule an appointment, a student should delete the original appointment and make a new one. 

**How to embed an Youtube video**:

- Identify the string after "watch?v=" in the Youtube link (such as "zZffa_Z_Cxs" in the link https://www.youtube.com/watch?v=zZffa_Z_Cxs).
- Insert the string identified above after https://youtube.com/embed/ (such as https://youtube.com/embed/zZffa_Z_Cxs).
- Replace the Youtube link in ui.R with your new link derived above.

## How to launch the app

You should have at least very basic knowledges about [Shiny App](https://shiny.rstudio.com/) in order to make changes to this framework and fulfill your own needs. Please follow the steps:

1. Fork this repository and clone it to your local machine.
2. Start a new session in RStudio and open this R project.
3. Make changes to the general & contact information, research, teaching and other pages.
4. Host your Shiny app using shinyapps.io, Shiny Server, RStudio Connect, or other access to an IT department server; a simple guide can be found [here](https://shiny.rstudio.com/tutorial/written-tutorial/lesson7/).

## Author(s)

- Xiaozhu Zhang
