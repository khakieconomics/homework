

posterior <- function(x, y, n, k, v0, capv0inv){
	
	# Ordinary least squares
	bols <- solve(t(x)%*%x)%*%t(x)%*%y
	s2 <- t(y - x%*%bols)%*%(y - x%*%bols)/(n-k)
	xpx <- t(x)%*%x
	ixpx <- solve(xpx)
	bolscov <- s2*ixpx
	bolssd <- sqrt(diag(bolscov))
	v <- n-k
	
	# Posterior hyperparameters
	v1 <- v0+n
	capv1inv <- capv0inv + xpx
	capv1 <- solve(capv1inv)
	
	b1 <- capv1*(capv0inv%*%b0 + xsquare%*%bols)
	
	if(det(capv0inv)>0){
		v1s12 <- v0*s02 + v*s2 + t(bols-b0)%*%solve(capv0 + ixpx)%*%(bols-b0)
	} else{
		v1s12 <- v0*s02 + v*s2
	}
	
	s12 <- v1s12/v1
	bcov <- capv1%*%v1s12/(v1-2)
	bsd <- sqrt(diag(bcov))
	
	
}

