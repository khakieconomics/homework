
function x = t_den_q2(draws, nu, mu, sigma2)

lambda = 1./gamrnd(nu/2, 2/nu, draws, 1);

x = mu + (sqrt(sigma2*lambda)).*randn(draws, 1);

