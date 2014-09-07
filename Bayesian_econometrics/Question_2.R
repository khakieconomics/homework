# Question 2 - write a function that samples from a t distribution using the method of composition
library(MCMCpack); library(ggplot2)
t.sampler <- function(draws, nu, mu, sigma2){
	lambda <- rinvgamma(draws, shape = nu/2, scale = nu/2)
	out <- rnorm(draws, mu, sqrt(lambda*sigma2))
	out
}

test <- t.sampler(1000, 3, 0, 1)

# Sanity checking
test2 <- rt(1000, 3)
ks.test(test, test2)
plot(density(test))
lines(density(test2))

# Looks like they're from the same distribution

# This bit answers the question
answer <- data.frame(output = t.sampler(1000, 5, 1, 2))
str(answer)
ggplot(answer, aes(x = output)) + geom_density(fill = "orange", alpha = 0.7) + theme_bw(base_size = 22) + xlab("t(5, 1, 2) draws")
