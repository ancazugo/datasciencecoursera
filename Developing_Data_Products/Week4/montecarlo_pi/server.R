library(shiny)

# Define server logic required to draw montecarlo simulation
shinyServer(function(input, output) {

    output$piPlot <- renderPlot({

        drawCircle <- function(origin = c(0, 0), radius = 1, npoints = 1000) {
            angles <- seq(0, 2 * pi, length.out = npoints)
            xvalues <- origin[1] + radius * cos(angles)
            yvalues <- origin[2] + radius * sin(angles)
            return(data.frame(xvalues, yvalues))
        }
        
        isInCircle <- function(radius, origin = c(0, 0), xcoord, ycoord) {
            d <- sqrt((xcoord - origin[1]) ** 2 + (ycoord - origin[2]) ** 2)
            ans <- F
            if(d <= radius) {
                ans <- T
            }
            return(ans)
        }
        radius <- input$radius
        n <- input$points
        
        x_coords <- runif(n, 0, radius)
        y_coords <- runif(n, 0, radius)
        points_df <- data.frame(x_coords, y_coords)
        
        in_circle <- points_df[isInCircle(radius = radius, xcoord = points_df$x_coords, ycoord = y_coords), ]
        out_circle <- points_df[!isInCircle(radius = radius, xcoord = points_df$x_coords, ycoord = y_coords), ]
        
        circle <- drawCircle(radius = radius)
        
        plot(y_coords ~ x_coords, points_df, col = rgb(red = 0, green = 0, blue = 1, alpha = 0.5))
        points(y_coords ~ x_coords, points_df, col = rgb(red = 1, green = 0, blue = 0, alpha = 0.5))
        ifelse(input$show_circle, plot(yvalues ~ xvalues, circle, type = 'l'))

    })

})
