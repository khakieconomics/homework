function out=rnormtrunc(draws, mean, variance, truncation_point)
    u = rand(draws, 1);
	uhat = normcdf(truncation_point, mean, sqrt(variance)) + u * (1-normcdf(truncation_point, mean, sqrt(variance)));
	out = norminv(uhat, mean, sqrt(variance));

return;

end