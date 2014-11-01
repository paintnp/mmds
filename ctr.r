
data <- data.frame(advertiser=c("A", "B", "C", "D", "E"), 
                   bid=c(0.1,0.09, 0.08, 0.07, 0.06), 
                   ctr1=c(0.015,0.016,0.017,0.018,0.019),
                   ctr2=c(0.01,0.012,0.014,0.015,0.016), 
                   ctr3=c(0.005, 0.006,0.007,0.008,0.010),
                   budget=c(1.0,2.0,3.0,4.0,5.0))

remaining_advertisers <- data$advertiser

a <- c(0.1, 0.015,0.01,0.005,1.0)
b <- c(0.09,0.016,0.012,0.006,2.0)
c <- c(0.08,0.017,0.014,0.007,3.0)
d <- c(0.07,0.018,0.015,0.008,4.0)
e <- c(0.06,0.019,0.016,0.010,5.0)

h <- hash()
.set(h,A=a)
.set(h,B=b)
.set(h,C=c)
.set(h,D=d)
.set(h,E=e)

iteration <- function() {
 remaining <- keys(h)
 #find max for window 1
 max <- function(advertisers, window) {
         
 } # end max
        
        
} # end iteration

