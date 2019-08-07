function temp = gauss(sigma, kls, banding)
temp =0;
for i=1:length(kls)
   g=exp(-(norm(kls(i,:)-banding)^2)/(2*(sigma^2)));
   temp = temp+g;
end
end
