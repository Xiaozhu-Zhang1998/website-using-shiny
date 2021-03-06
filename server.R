library(shiny)
library(shinydashboard)
library(shinyalert)
library(shinyjs)
library(shinyBS)
library(shinycssloaders)
library(ggplot2)

shinyServer(function(input, output, session) {
    
    # index page ----
    output$indexpage <- renderUI({
        sidebarLayout(position = "left",
            sidebarPanel(width = 4,
                tags$img(src = "avatar.jpeg", height = 200, width = 160, 
                         style="display: block; margin-left: auto; margin-right: auto;"),
                h4(tags$b("Ph.D in Statistics, Shiny University")), 
                
                hr(),
                
                h5(tags$b("Education")),
                h5("Ph.D in Statistics, Shiny University, 2022 - 2027"),
                h5("M.S. in Math, RStudio University, 2020 - 2022"),
                h5("B.S. in Computer Science, R University, 2016 - 2020"),
                
                hr(),
                
                h5(tags$b("Experiences")),
                h5("Teaching Assistant, Shiny University, Jan - April, 2023"),
                h5("Internship, Facebook, June 2022"),
                h5("Visiting Student, Python University, Spring 2019"),
                
                hr(),
                
                h5(tags$b("Contact")),
                h5("Email: xxx@gmail.com"),
                h5("Phone: (xxx) xxx-xxxx")

            ),
            
            mainPanel(
                h4("Hi, welcom to my website!"),
                h4("I am currently a..., and my interests lie in..."),
                h4("If you have any questions, don't hesitate to contact me!"),
                br(),
                tags$img(src = "img.jpg", height = 600, width = 400, 
                         style="display: block; margin-left: auto; margin-right: auto;")
            )
        )
    })
    
    # paper page ----
    output$pubpage <- renderUI({
        tabsetPanel(
            tabPanel(tags$b("Theses"), dataTableOutput("thesistable")),
            tabPanel(tags$b("Publications"), dataTableOutput("pubstable")),
            tabPanel(tags$b("Preprints"), dataTableOutput("pretable"))
        )
    })
    
    output$thesistable <- renderDataTable({
        thesis
    })
    
    output$pubstable <- renderDataTable({
        pubs
    })
    
    output$pretable <- renderDataTable({
        pre
    })
    
    # project page ----
    output$proj1 <- renderInfoBox({
        infoBox(title = "Kaggle", value = "Titanic Data Analysis", 
                subtitle = "This is a comprehensive data report on the dataset titanic,...", icon = icon("arrow-up"),
                href = "https://www.google.com")
    })
    
    output$proj2 <- renderInfoBox({
        infoBox(title = "Contest", value = "A Dynamic Model on Transportation",
                subtitle = "How to manage and optimize the transportation system?", icon = icon("check"), color = 'yellow',
                href = "https://www.bing.com")
    })
    
    output$proj3 <- renderInfoBox({
        infoBox(title = "Software", value = "An R Package to Solve RegNN Problem",
                subtitle = "The penalized neural networks.", icon = icon("box"), color = 'maroon',
                href = "https://www.github.com")
    })
    
    # teach page ----
    output$updates <- renderUI({list(
        tags$li("May 12th: Please check the Canvas for class materials."),
        tags$li("May 11th: Assignment 2 is coming out.")
    )
        
    })
    
    output$curclass <- renderTable({
        class1
    })
    
    output$pastclass <- renderDataTable({
        class2
    })
    
    output$ofappoint <- renderUI({
        lst <- list(
            p1 = p("If you have any problems over the classes, assignments, or exams and want to talk to me, please make an appointment on W/F."),
            p2 = p("There would be 15 slots available each day."),
            d1 = dateInput("date", "Please select a date", value = Sys.Date(), min = Sys.Date() + 1, max = Sys.Date() + 21, daysofweekdisabled = c(0,1,2,4,6), width = '40%'),
            u1 = uiOutput("checkava"),
            t1 = textInput("name", "Please input your name", width = "40%"),
            t2 = textInput("password", "Please input your password", width = "40%"),
            u2 = useShinyalert(),
            a1 = actionButton("make", "Make an appointment"),
            a2 = actionButton("check", "Check appointments"),
            a3 = actionButton("del", "Delete the appointment")
        )
        return(lst)
    })
    
    output$checkava <- renderUI({
        if(length(input$date) == 0)
            return()
        else{
            dat <- read.table("slots.csv", sep = ',', header = T)
            sub <- subset(dat, Date == as.character(input$date))
            p(paste(nrow(sub), "slot(s) occupied."))
        }
    })
    
    observeEvent(input$make, {
        # check whether full information
        if(length(input$date) == 0 | input$name == "" | input$password == ""){
            shinyalert("Alert", "Please input full information!", type = "error")
        }
        else{
            dat <- read.table("slots.csv", sep = ',', header = T)
            # check whether exist
            sub <- subset(dat, Date == as.character(input$date) & Name == input$name & Password == input$password)
            if(nrow(sub) != 0){
                shinyalert("Alert", "You have made an appointment on this day!", type = "error")
            }
            else{
                # check whether available
                count <- sum(dat$Date == as.character(input$date))
                if(count >= 15){
                    shinyalert("Alert", "The office hour capacity is full on this day!", type = "error")
                }
                else{
                    record <- c(as.character(input$date), input$name, input$password)
                    dat <- rbind(dat, record)
                    write.csv(dat, "slots.csv", row.names = F)
                    shinyalert("Success", "You have made an appointment!", type = "success")
                }
            }
        }
    })
    
    observeEvent(input$check, {
        dat <- read.table("slots.csv", sep = ',', header = T)
        sub <- subset(dat, Name == input$name & Password == input$password)
        date <- sub$Date
        if(nrow(sub) == 0){
            shinyalert("No matches", "You don't have any appointments now!", type = "info")
        }
        else{
            shinyalert("Matches", paste0("Your appointment(s): ", paste(date, collapse = ", ")), type = "info")
        }
    })
    
    observeEvent(input$del, {
        if(length(input$date) == 0 | input$name == "" | input$password == ""){
            shinyalert("Alert", "Please input full information!", type = "error")
        }
        else{
            dat <- read.table("slots.csv", sep = ',', header = T)
            sub <- subset(dat, Date == as.character(input$date) & Name == input$name & Password == input$password)
            if(nrow(sub) == 0){
                shinyalert("No matches", "This appointment does not exist!", type = "info")
            }
            else{
                id <- as.numeric(rownames(sub))
                write.csv(dat[-id,], "slots.csv", row.names = F)
                shinyalert("Success", "You have deleted the appointment!", type = "success")
            }
        }
        
    })
    
    
    # misc page
    data_uploaded <- reactive({
        file1 <- input$file
        if(is.null(file1)){ return() }
        read.table(file = file1$datapath, sep = ",", header = T, stringsAsFactors = T)
    })
    
    output$histui <- renderUI({
        if(is.null(input$file))
            return()
        else{
            lst <- list(actionButton("plot_button", "View Plot", icon = icon("bar-chart")),
                        bsModal(id = "Plot", title = "Plot", trigger = "plot_button", size = "large",
                                selectInput("data_names", "Select a variable", choices = names(data_uploaded())),
                                sliderInput("bins", label = "Select the number of bins", min = 20, max = 50, value = 30),
                                br(),
                                withSpinner(plotOutput("plot_gg"))
                                ))
            return(lst)
        }
    })
    
    output$plot_gg <- renderPlot({
        ggplot(data = data_uploaded()) +
            geom_histogram(bins = input$bins, aes(x = get(input$data_names))) +
            ggtitle("Histogram") +
            xlab(paste(input$data_names, " & number of bins as ", input$bins)) +
            ylab("Frequency") +
            theme_minimal()
    })
    
    
    
})