function F= fun2N(x,K2i,Beta)

alpha = 1+prod(K2i);

beta(1) = Beta(2);
beta(2) = Beta(1);

F(1) = (sum(x)*(prod(1+K2i)));
F(2) = (sum(K2i)+(prod(x)*(prod(1+K2i))))*2;
F = F/alpha;
F = F-beta;
end

