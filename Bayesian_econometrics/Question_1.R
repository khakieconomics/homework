library(ggplot2)
# Question 1 wants to sample from a N(0.5,2) distribution truncated below at 0 via inverse transform method. 
# Part a
rnorm.trunc <- function(mean, variance, truncation.point, draws){
	u <- runif(draws, 0, 1)
	uhat <- pnorm(truncation.point, mean, sqrt(variance)) + 
		u * (1-pnorm(truncation.point, mean, sqrt(variance)))
	out <- qnorm(uhat, mean = mean, sd = sqrt(variance))
	out
	
}


sim <- data.frame(Draws = rnorm.trunc(0.5, 2, 0, 10000))

# Part b, plot the distribution
summary(sim)
ggplot(sim, aes(x=Draws)) + geom_density(fill = "orange", alpha = 0.7)
ggplot(sim, aes(x=Draws)) + geom_histogram(fill = "orange", alpha = 0.6)

# Part c
# What is the probability the parameter lies inside the interval (0,1)

mean(sim$Draws>0 & sim$Draws<1)

# Compute the 0.05 and 0.95 percentiles of the distribution
qs <- quantile(sim$Draws, probs = c(0.05, 0.95))

# What is the length of the interval?
qs[2] - qs[1]

# Can I find a shorter 90% interval? 
# Yes
qs2 <- quantile(sim$Draws, probs = c(0, 0.9))
qs2[2] - qs2[1]

# I know this will be a shorter interval as there is more mass around the mean of the untruncated normal distribution (0.5)


# Sanity check ====

sim2 <- rnorm(20000, 0.5, sqrt(2))
sim3 <- data.frame(draws = sim2[sim2>=0])

ggplot(sim3, aes(x = draws)) + geom_histogram(alpha = 0.7, fill = "orange")

mean(sim3$draws<1)

head(sim3, 50)

qs3 <- quantile(sim3$draws, probs = c(0.05, 0.95))
qs3[2] - qs3[1]
qs4 <- quantile(sim3$draws, probs = c(0.0, 0.9))
qs4[2] - qs4[1]

# Sanity check complete - it passes