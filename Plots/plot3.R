#This script exposes a function plot3() that renders the third plot.
#It also calls the function as the question asks us to render the png from the script.


#import data loading, etc. utility functions
source('utility.R')

#This function carries out the plotting of graph 3. 
#It is used in this script if the script is called stand alone.
#It is also reused from plot4.R, and at that time, it needs to render to the
#"current" device, rather than opening a new png.
#The parameter 'pngDevice' specifies if the function should render to its own png
#or the current device.
plot3 <- function(pngDevice){
    print('Running plot3')
    
    data <- getData()

    #if a new png is requested, open a new png device.
    if(pngDevice){
        dir.create('out', showWarnings='F')
        png('out/plot3.png', width=480, height=480, bg='transparent')
    }
    
    #do the plot
    with(data, {
        plot(DateTime, Sub_metering_1, type='l', xlab='', ylab="Energy sub metering")
        lines(DateTime, Sub_metering_2, type='l', col='red')
        lines(DateTime, Sub_metering_3, type='l', col='blue')
    })
    
    legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd='1', col=c('black', 'red', 'blue'))
    
    #if a new png was created, dispose of it, which saves the file.
    if(pngDevice){
        dev.off()
    }
}

#if plotting is not disabled, carry out the plot.
#since the question asks for plot3.R to actually plot the png, when this
#is reused in plot4.R, it re-plots plot3 without this check. 
#To get around this problem a global flag is maintained (utility.R), that signals
#whether a plot to plot2.png should happen. plot4.R disables this when rendering to 
#its own png, but the plotting to plot3.png is carried out when plot3.R is called independently.
if(!disablePlottingToFile){
    plot3(T)
}
