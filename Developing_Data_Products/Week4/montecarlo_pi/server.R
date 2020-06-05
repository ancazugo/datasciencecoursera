library(shiny)
library(dplyr)

# Define server logic required to draw montecarlo simulation
shinyServer(function(input, output, session) {
    url <- a("Slides", href="https://rpubs.com/ancazugo/montecarlopi")
    #output$text <- renderText({paste('Number of points in circle = ', p, '. pi = ', x)})
    output$see <- renderUI({tagList("Visit these ", url, 'for more information')})
    output$piPlot <- renderPlot({

        drawCircle <- function(origin = c(0, 0), radius = 1, npoints = 1000) {
            angles <- seq(0, 2 * pi, length.out = npoints)
            xvalues <- origin[1] + radius * cos(angles)
            yvalues <- origin[2] + radius * sin(angles)
            return(data.frame(xvalues, yvalues))
        }
        
        radius <- input$radius
        n <- input$points
        seed <- input$seed
        
        set.seed(seed)
        x_coords <- runif(n, -radius, radius)
        set.seed(-seed)
        y_coords <- runif(n, -radius, radius)
        points_df <- data.frame(x_coords, y_coords)
        
        in_circle <- points_df %>% 
            filter(sqrt(x_coords ** 2 + y_coords ** 2) <= radius)
        
        out_circle <- points_df %>% 
            filter(sqrt(x_coords ** 2 + y_coords ** 2) > radius)
        
        circle <- drawCircle(radius = radius)
        
        pi_est <- as.character(format(round(4 * nrow(in_circle) / nrow(points_df), 5), nsmall = 5))
        pointsCircle <- as.character(nrow(in_circle))
        
        title <- bquote(paste(pi, ' = ', .(pi_est)))
        subtitle <- bquote(paste('# points in circle = ', .(pointsCircle)))
        
        plot(y_coords ~ x_coords, in_circle, col = rgb(red = 0, green = 0, blue = 1, alpha = 0.5),
             ylim = c(-radius, radius), xlim = c(-radius, radius), pch = 19, xlab = '', ylab = '', main = title,
             sub = subtitle, cex.main = 2, cex.sub = 2, yaxt = 'n', xaxt = 'n')
        axis(1, at = seq(-radius, radius, radius / 2))
        axis(2, at = seq(-radius, radius, radius / 2))
        
        points(y_coords ~ x_coords, out_circle, col = rgb(red = 1, green = 0, blue = 0, alpha = 0.5), pch = 19)
        
        circleColor <- ifelse(input$circle, rgb(red = 0, green = 0.39, blue = 0, alpha = 0.75),
                              rgb(red = 0, green = 1, blue = 0, alpha = 0))
        
        lines(yvalues ~ xvalues, circle, type = 'l', col = circleColor, lwd = 2)
        
        squareColor <- ifelse(input$square, rgb(red = 0, green = 0.39, blue = 0, alpha = 0.75),
                              rgb(red = 0, green = 1, blue = 0, alpha = 0))
        
        rect(-radius, -radius, radius, radius, border = squareColor, lwd = 2)
        
        
    }, height = function() {
        session$clientData$output_piPlot_width
    })

})
