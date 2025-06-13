library(shiny)
library(bs4Dash)

# Phase details
phase_data <- list(
    "Phase 1: Planning & Community Engagement" = list(
        color = "#a1c181", # earthy green
        tasks = c(
            "Community Intro & Feedback",
            "Advisory Committee Formation",
            "Site Identification",
            "Fundraising & Resources"
        )
    ),
    "Phase 2: Installation & Activation" = list(
        color = "#fcca46", # golden yellow
        tasks = c(
            "Final Design & Site Prep",
            "Community Planting Days",
            "Program Launch Events"
        )
    ),
    "Phase 3: Stewardship & Expansion" = list(
        color = "#f3722c", # burnt orange
        tasks = c(
            "Volunteer Stewardship Teams",
            "Monitoring & Feedback",
            "Policy Integration & Expansion"
        )
    )
)

# UI
ui <- dashboardPage(
    header = dashboardHeader(title = "Edible Trail Roadmap"),
    sidebar = dashboardSidebar(disable = TRUE),
    body = dashboardBody(
        fluidRow(
            lapply(names(phase_data), function(phase) {
                column(
                    width = 4,
                    bs4Card(
                        title = phase,
                        status = "success",
                        background = NULL,
                        solidHeader = TRUE,
                        width = 12,
                        style = paste0("background-color:", phase_data[[phase]]$color, "; color:white;"),
                        footer = actionButton(inputId = gsub(" ", "_", phase), label = "View Tasks", class = "btn-light")
                    )
                )
            })
        )
    )
)

# Server
server <- function(input, output, session) {
    lapply(names(phase_data), function(phase) {
        observeEvent(input[[gsub(" ", "_", phase)]], {
            showModal(modalDialog(
                title = phase,
                HTML(paste("<ul>", paste0("<li>", phase_data[[phase]]$tasks, "</li>", collapse = ""), "</ul>")),
                easyClose = TRUE
            ))
        })
    })
}

shinyApp(ui, server)
