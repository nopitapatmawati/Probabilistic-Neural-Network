function flatih = multi(sigma, kls, banding)
flatih = gauss(sigma, kls, banding)/((((2*3.14)^(3/2))*(sigma^3))*length(banding));
end
