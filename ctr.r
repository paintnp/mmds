
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

budget <- hash()
.set(budget, A=1)
.set(budget, B=2)
.set(budget, C=3)
.set(budget, D=4)
.set(budget, E=5)

clicks <- hash()
.set(clicks, A=0)
.set(clicks, B=0)
.set(clicks, C=0)
.set(clicks, D=0)
.set(clicks, E=0)

total_clicks <- 0

iteration <- function() {
 remaining <- keys(h)
 #find max for window 1
 max_expected <- function(advertisers, window) {
     max_advertiser <- ""
     max_val <- -1
     for ( a in advertisers) {
             row <- h[[a]][[1]]
             val <- row[[window+1]] * row[[1]]
             if (val > max_val) {
                     max_val <- val
                     max_advertiser <- a
             }   
     }
      list(max_advertiser, max_val)  
 } # end max_expected
  
 window1 <- max_expected(remaining, 1)
 print(paste0("window1 selected as=", window1))
 remaining <- remaining[!remaining==window1[[1]]]
 window2 <- max_expected(remaining, 2)
 print(paste0("window2 selected as=", window2))
 remaining <- remaining[!remaining==window2[[1]]]
 if (length(remaining) == 0) {
         return(FALSE)
 }
 window3 <- max_expected(remaining, 3)
 print(paste0("window3 selected as=", window3))
 die <- function(element,window){
         ctr <- h[[element]][[1]][[window + 1]]
         ctr <- ctr * 100
         roll <- floor(runif(1, 1, 101))
         if (roll <= ctr) {
                 total_clicks <<- total_clicks + 1
                 print(paste0("Total clicks is=", total_clicks))
                 clicks[[element]] <<- clicks[[element]][[1]] +1
                 budget[[element]] <<- budget[[element]][[1]] - h[[element]][[1]][[1]]
                 if (budget[[element]] <= h[[element]][[1]][[1]]) {
                    del(element, h)  
                 }
                 TRUE
         }
         else {
                 FALSE
         }
 } # end die
 die1 <- die(window1[[1]], 1)
 die2 <- die(window2[[1]], 2)
 die3 <- die(window3[[1]], 3)
 remaining <- keys(h)
 
 if (total_clicks == 101 || length(remaining) == 0) {
         FALSE
 }
 else {
         TRUE
 }
        
} # end iteration

val <- iteration()

while(val) {
        val <- iteration()
        if (val == F) {
                print(clicks)
                print(paste0("Total clicks is=", total_clicks))
        }
}

