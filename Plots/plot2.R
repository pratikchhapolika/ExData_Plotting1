#This script exposes a function plot2() that renders the second plot.
#It also calls the function as the question asks us to render the png from the script.


#import data loading, etc. utility functions
source('utility.R')

#This function carries out the plotting of graph 2. 
#It is used in this script if the script is called stand alone.
#It is also reused from plot4.R, and at that time, it needs to render to the
#"current" device, rather than opening a new png.
#The first parameter 'pngDevice' specifies if the function should render to its own png
#or the current device.
#In plot4.R's top left graph, the ylab is different from the one in the target graph for
#plot 2. The parameter ylab defaults to plot2's target label, but setting this
#parameter enables us to override the y axis label.
plot2 <- function(pngDevice, ylab='Global Active Power (kilowatts)'){
    print('Running plot2')
    
    data <- getData()
    
    #if a new png is requested, open a new png device.
    if(pngDevice){
        dir.create('out', showWarnings='F')
        png('out/plot2.png', width=480, height=480, bg='transparent')
    }
    
    #do the plot
    with(data, {
        plot(DateTime, Global_active_power, type='l', xlab='', ylab=ylab)
    })
    
    #if a new png was created, dispose of it, which saves the file.
    if(pngDevice){
        dev.off()
    }
}

#if plotting is not disabled, carry out the plot.
#since the question asks for plot2.R to actually plot the png, when this
#is reused in plot4.R, it re-plots plot2 without this check. 
#To get around this problem a global flag is maintained (utility.R), that signals
#whether a plot to plot2.png should happen. plot4.R disables this when rendering to 
#its own png, but the plotting to plot2.png is carried out when plot2.R is called independently.
if(!disablePlottingToFile){
    plot2(T)
}
